import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class LottieLoading extends StatelessWidget {
  const LottieLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 350,
      height: 350,
      child: Lottie.asset(
        'images/animations/loading.json',
        width: 250,
        height: 250,
      ),
    );
  }
}

class LottieEmpty extends StatelessWidget {
  const LottieEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 350,
      height: 350,
      child: Lottie.asset(
        'images/animations/empty.json',
        width: 280,
        height: 280,
        fit: BoxFit.cover,
      ),
    );
  }
}

class LottieCartAdded extends StatelessWidget {
  const LottieCartAdded({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 200,
      child: Lottie.asset(
        'images/animations/cart.json',
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }
}

class LottieClearDone extends StatelessWidget {
  const LottieClearDone({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 400,
      child: Lottie.asset(
        'images/animations/clear_3.json',
        width: 220,
        height: 220,
        fit: BoxFit.cover,
      ),
    );
  }
}