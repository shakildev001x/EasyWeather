import 'dart:ui';

import 'package:bloc_demo/bloc/bloc/weather_bloc.dart';
import 'package:bloc_demo/presentation/widgets/curve_botom_sheet.dart';
import 'package:bloc_demo/presentation/widgets/temp_graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

void showMyBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          final states = state as WeatherSuccess;
          final forecastWeather = state.weatherModel.forecast;
          final currentWeather = state.weatherModel.current;

          return ClipPath(
            clipper: InvertedLargeCurveClipper(),
            child: Container(
              height: .9.sh,
              width: 1.sw,
              color: Colors.blue,
              child: Column(
                children: [
                  SizedBox(height: 35),
                  Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("Today's Forecast"),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Next ${forecastWeather.length} Days Forecast",
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: forecastWeather.map((dayData) {
                                  DateTime date = DateTime.parse(dayData.date);
                                  String dayName = DateFormat(
                                    'EEE',
                                  ).format(date);

                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        dayName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        DateFormat('M/d').format(date),
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Image.network(
                                        dayData.conditionIcon,
                                        width: 30,
                                        height: 30,
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: 20),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 60,
                                ),
                                child: SizedBox(
                                  height: 120.h,
                                  child: CustomPaint(
                                    size: const Size(double.infinity, 150),
                                    painter: TempGraphPainter(
                                      forecastWeather,
                                      forecastWeather
                                          .map((e) => e.maxTempC)
                                          .reduce((a, b) => a > b ? a : b),
                                      forecastWeather
                                          .map((e) => e.minTempC)
                                          .reduce((a, b) => a < b ? a : b),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
