import 'package:authentication_repository/authentication_repository.dart';
import 'package:coupon_repository/coupon_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:info_repository/info_repository.dart';
import 'package:ms_kopalisce_main/prices/blocs/blocs.dart';
import 'package:price_repository/price_repository.dart';
import 'package:quiz_repository/quiz_repository.dart';
import 'package:weather_repository/weather_repository.dart';

import 'authentication/authentication.dart';
import 'home/home.dart';
import 'vouchers/vouchers.dart';
import 'weather/weather.dart';

class App extends StatefulWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    required WeatherRepository weatherRepository,
    required CouponRepository couponRepository,
    required PriceRepository priceRepository,
    required QuizRepository quizRepository,
    required InfoRepository infoRepository,
  })  : _authenticationRepository = authenticationRepository,
        _weatherRepository = weatherRepository,
        _couponRepository = couponRepository,
        _priceRepository = priceRepository,
        _quizRepository = quizRepository,
        _infoRepository = infoRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final WeatherRepository _weatherRepository;
  final CouponRepository _couponRepository;
  final PriceRepository _priceRepository;
  final QuizRepository _quizRepository;
  final InfoRepository _infoRepository;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _navigatorState = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: widget._authenticationRepository),
        RepositoryProvider.value(value: widget._weatherRepository),
        RepositoryProvider.value(value: widget._couponRepository),
        RepositoryProvider.value(value: widget._priceRepository),
        RepositoryProvider.value(value: widget._quizRepository),
        RepositoryProvider.value(value: widget._infoRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            lazy: false,
            create: (context) => AuthenticationBloc(
              authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
            ),
          ),
          //PRICES
          BlocProvider(
            create: (context) => BathroomServicesBloc(
              priceRepository: RepositoryProvider.of<PriceRepository>(context),
            )..add(BathroomServicesLoadRequested()),
          ),
          BlocProvider(
            create: (context) => FoodPricesListBloc(
              priceRepository: RepositoryProvider.of<PriceRepository>(context),
            )..add(FoodPricesListLoadRequested()),
          ),

          //VOUCHERS
          BlocProvider(
            create: (context) => VoucherValidListBloc(
              couponRepository: RepositoryProvider.of<CouponRepository>(context),
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            )..add(VoucherListLoadRequested()),
          ),
          BlocProvider(
            create: (context) => VoucherUsedListBloc(
              couponRepository: RepositoryProvider.of<CouponRepository>(context),
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            )..add(VoucherListLoadRequested()),
          ),
          BlocProvider(
            create: (context) => VoucherExpiredListBloc(
              couponRepository: RepositoryProvider.of<CouponRepository>(context),
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            )..add(VoucherListLoadRequested()),
          ),

          //Weather
          BlocProvider(
            create: (context) => WeatherBloc(
              weatherRepository: RepositoryProvider.of<WeatherRepository>(
                context,
              ),
            )..add(const LoadWeatherDataRequested()),
          ),

          //Info
          BlocProvider(
            create: (context) => OpenTimeBloc(
              RepositoryProvider.of<InfoRepository>(context),
            )..add(OpenTimeLoadRequested()),
          ),
          BlocProvider(
            create: (context) => AdditionalInfoBloc(
              RepositoryProvider.of<InfoRepository>(context),
            )..add(AdditionalInfoLoadRequested()),
          ),
        ],
        child: MaterialApp(
          navigatorKey: _navigatorState,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: ((context, state) {
                if (state.status == AuthenticationStatus.unauthenticated) {
                  _navigatorState.currentState!.pushReplacement(LoginView.route(context));
                } else if (state.status == AuthenticationStatus.authenticated) {
                  _navigatorState.currentState!.pushReplacement(HomeView.route(context));
                }

                FlutterNativeSplash.remove();
              }),
              child: child!,
            );
          },
          home: Container(),
        ),
      ),
    );
  }
}
