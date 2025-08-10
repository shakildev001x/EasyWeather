import 'package:bloc_demo/bloc/bloc/loading_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoLoading extends StatelessWidget {
  const LogoLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingCubit, double>(
      builder: (context, opacity) {
        return Opacity(
          opacity: opacity,
          child: Image.asset(
            "assets/images/icon.png",
            width: 80.h,
            height: 80.h,
          ),
        );
      },
    );
  }
}
