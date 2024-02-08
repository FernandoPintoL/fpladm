import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  String text;

  Loading({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpinKitWaveSpinner(
            color: Colors.white,
            size: 100.0,
            duration: Duration(milliseconds: 1200),
          ),
          Text(text)
        ],
      ),
    );
  }
}
