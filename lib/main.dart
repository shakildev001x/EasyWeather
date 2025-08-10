import 'package:bloc_demo/bloc/bloc/loading_cubit.dart';
import 'package:bloc_demo/bloc/bloc/weather_bloc.dart';
import 'package:bloc_demo/data/data_provider/weather_data_provider.dart';
import 'package:bloc_demo/data/repository/weather_repository.dart';
import 'package:bloc_demo/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(WeatherDataProvider()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              final bloc = WeatherBloc(context.read<WeatherRepository>());
              bloc.add(WeatherFetch());
              return bloc;
            },
          ),
          BlocProvider(create: (_) => LoadingCubit()),
        ],
        child: ScreenUtilInit(
          designSize: Size(360, 700),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
          ),
        ),
      ),
    );
  }
}
