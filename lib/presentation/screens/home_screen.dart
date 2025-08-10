import 'dart:ui';
import 'package:bloc_demo/bloc/bloc/weather_bloc.dart';
import 'package:bloc_demo/presentation/widgets/curve_botom_sheet.dart';
import 'package:bloc_demo/presentation/widgets/custom_loading.dart';
import 'package:bloc_demo/presentation/widgets/home_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locationController = TextEditingController();

    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(child: LogoLoading());
          }

          if (state is WeatherFailer) {
            return Scaffold(
              body: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.error),
                      ElevatedButton(
                        onPressed: () {
                          context.read<WeatherBloc>().add(WeatherFetch());
                        },
                        child: Text("Current Location"),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          if (state is WeatherSuccess) {
            final forecastWeather = state.weatherModel.forecast;
            final currentWeather = state.weatherModel.current;
            final location = state.weatherModel.location;
            return Stack(
              children: [
                Positioned.fill(
                  child: Image.asset('assets/images/bg.jpg', fit: BoxFit.cover),
                ),

                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            SizedBox(height: 20),
                            const Icon(
                              Icons.location_city,
                              color: Colors.white,
                            ),
                            Text(
                              location.name,
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              ", ${location.country}",
                              style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.add),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Container(
                                        height: 150.h,
                                        width: 300.w,
                                        decoration: BoxDecoration(),
                                        child: Column(
                                          children: [
                                            Text("Change Your Location"),
                                            SizedBox(height: 15),
                                            TextField(
                                              controller: locationController,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                              ),
                                              onSubmitted: (value) {
                                                if (value.trim().isNotEmpty) {
                                                  context
                                                      .read<WeatherBloc>()
                                                      .add(
                                                        WeatherChange(
                                                          value.trim(),
                                                        ),
                                                      );
                                                  locationController.clear();
                                                  Navigator.pop(context);
                                                }
                                              },
                                            ),
                                            SizedBox(height: 15),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    final value =
                                                        locationController.text
                                                            .trim();
                                                    if (value.isNotEmpty) {
                                                      context
                                                          .read<WeatherBloc>()
                                                          .add(
                                                            WeatherChange(
                                                              value,
                                                            ),
                                                          );
                                                    }
                                                    locationController.clear();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Save"),
                                                ),
                                                SizedBox(width: 15),
                                                ElevatedButton(
                                                  onPressed: () {},
                                                  child: Text("Cancel"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          currentWeather.lastUpdated,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [Colors.white, Colors.blue],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ).createShader(bounds),
                              child: Text(
                                currentWeather.tempC.toString(),
                                style: const TextStyle(
                                  fontSize: 100,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Text(
                              '°C',
                              style: TextStyle(
                                fontSize: 100,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        //glass container
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              width: 120.w,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(
                                  0.1,
                                ), // Transparent white
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.upload),
                                  Text('17'),
                                  SizedBox(width: 20),
                                  Icon(Icons.download),
                                  Text('17'),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              width: 1.sw,
                              height: 80.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(
                                  0.1,
                                ), // Transparent white
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.wind_power),
                                            Text("${currentWeather.humidity}"),
                                          ],
                                        ),

                                        Text("Slight chancr\n of rain"),
                                      ],
                                    ),
                                    SizedBox(width: 10),

                                    Container(
                                      height: 60,
                                      width: 3,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    SizedBox(width: 10),

                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.wind_power),
                                            Text(
                                              " ${currentWeather.pressureMb}",
                                            ),
                                          ],
                                        ),

                                        Text("Slight chancr\n of rain"),
                                      ],
                                    ),
                                    SizedBox(width: 10),
                                    Container(
                                      height: 60,
                                      width: 3,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    SizedBox(width: 10),

                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.wind_power),
                                            Text("${currentWeather.uv}"),
                                          ],
                                        ),

                                        Text("Slight chancr\n of rain"),
                                      ],
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
                ),

                Positioned(
                  bottom: 0,
                  child: ClipPath(
                    clipper: InvertedLargeCurveClipper(),
                    child: Container(
                      height: .4.sh,
                      width: 1.sw,
                      color: Colors.white,
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
                          SizedBox(height: 2.h),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Today Hourly Forecast :"),
                            ),
                          ),
                          SizedBox(height: 2.h),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: SizedBox(
                              height: 100.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemCount: forecastWeather[0].hourly.length,
                                itemBuilder: (context, index) {
                                  DateTime dt = DateTime.parse(
                                    forecastWeather[0].hourly[index].time,
                                  );
                                  String timeFormatted = DateFormat(
                                    'hh:mm a',
                                  ).format(dt);

                                  return Container(
                                    width: 100,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          forecastWeather[0]
                                              .hourly[index]
                                              .conditionIcon,
                                          width: 40.w,
                                          height: 40.h,
                                        ),
                                        const SizedBox(height: 5),

                                        Text(
                                          timeFormatted,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          '${forecastWeather[0].hourly[index].tempC}°C',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 10),

                          InkWell(
                            onTap: () {
                              showMyBottomSheet(context);
                            },
                            child: Container(
                              height: 60.h,
                              width: .8.sw,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade500),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(3, 10),
                                    color: Colors.black12,
                                    spreadRadius: .3,
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Icon(Icons.sunny),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Tomorrow"),
                                        Text("Light Rain Showers"),
                                      ],
                                    ),
                                    SizedBox(width: 10),
                                    Row(
                                      children: [
                                        Icon(Icons.upload),
                                        Text('17'),
                                      ],
                                    ),
                                    SizedBox(width: 10),
                                    Row(
                                      children: [
                                        Icon(Icons.upload),
                                        Text('17'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
