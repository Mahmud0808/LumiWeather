import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lumi_weather/screens/home_screen.dart';

import 'bloc/weather_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const LumiWeather());
}

class LumiWeather extends StatelessWidget {
  const LumiWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lumi Weather',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
          useMaterial3: false,
          fontFamily: 'SF Pro Rounded'),
      home: FutureBuilder(
        future: _determinePosition(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BlocProvider<WeatherBloc>(
              create: (context) =>
                  WeatherBloc()..add(FetchWeather(snapshot.data as Position)),
              child: const HomeScreen(),
            );
          } else {
            if (snapshot.hasError) {
              List data = snapshot.error as List;

              Fluttertoast.showToast(
                  msg: data[0].toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0);

              return BlocProvider<WeatherBloc>(
                create: (context) => WeatherBloc()
                  ..add(FetchWeather(data[1] != null
                      ? data[1] as Position
                      : Position(
                          latitude: 23.810331,
                          longitude: 90.412521,
                          timestamp: DateTime.now(),
                          accuracy: 0,
                          altitude: 0,
                          altitudeAccuracy: 0,
                          heading: 0,
                          headingAccuracy: 0,
                          speed: 0,
                          speedAccuracy: 0,
                        ))),
                child: const HomeScreen(),
              );
            }

            return Scaffold(
              backgroundColor: Colors.black,
              body: Container(),
            );
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    Position? position = await Geolocator.getLastKnownPosition();
    return Future.error(['Location services are disabled', position]);
  }

  permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      Position? position = await Geolocator.getLastKnownPosition();
      return Future.error(['Location permissions are denied', position]);
    }
  }

  if (permission == LocationPermission.deniedForever) {
    Position? position = await Geolocator.getLastKnownPosition();
    return Future.error(
        ['Location permissions are permanently denied', position]);
  }

  return await Geolocator.getCurrentPosition();
}
