import 'package:base_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                height: size - 10,
                width: size - 10,
                child: Lottie.asset(
                  'assets/LottieLogo1.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Center(
              child: Container(
                height: size,
                width: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: Image.asset(Assets.images.icon.circularProgressIndicator.path).image,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
