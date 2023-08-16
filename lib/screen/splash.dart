import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/screen/todo_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../animations/fade_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin{
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(vsync: this);
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          CustomPageRoute(
            TodoScreen(),
          ),
        );
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Lottie.network(
              "https://assets10.lottiefiles.com/temp/lf20_TeyNKj.json",
              width: 250.0,
              height: 250.0,
              controller: animationController, onLoaded: (position) {
            animationController.duration = position.duration;
            animationController.forward();
          }),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
              height: 250.0,
              child: DefaultTextStyle(
                style: const TextStyle(
                    fontSize: 50.0,
                    color: Colors.indigo,
                    fontFamily: 'Bobbers'),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      'Be Productive',
                      speed: const Duration(milliseconds: 200),
                    )
                  ],
                  onTap: () {},
                ),
              ))
        ],
      ),
    );
  }
}

