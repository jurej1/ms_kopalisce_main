import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:coupon_repository/coupon_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:info_repository/info_repository.dart';
import 'package:ms_kopalisce_main/app.dart';
import 'package:ms_kopalisce_main/utilities/sobota_svica_bloc_observer.dart';
import 'package:price_repository/price_repository.dart';
import 'package:quiz_repository/quiz_repository.dart';
import 'package:weather_repository/weather_repository.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();

  Bloc.observer = SobotaSvicaBlocObserver();
  runApp(
    App(
      authenticationRepository: AuthenticationRepository(),
      weatherRepository: const WeatherRepository(),
      couponRepository: CouponRepository(),
      priceRepository: PriceRepository(),
      quizRepository: QuizRepository(),
      infoRepository: InfoRepository(),
    ),
  );
}
