import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.80,
      width: size.width,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        color: Colors.blue,
      ),
    );
  }
}
