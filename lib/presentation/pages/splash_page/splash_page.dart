import 'package:flutter/material.dart';
import 'package:snake_game/utils/constants.dart';

import '../home_page/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const PlayGameScreen()),
            ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(
                  AppConstants.gameLogo,
                  width: 200.0,
                ),
                const SizedBox(height: 20.0),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                    strokeWidth: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/logo.png',
                width: 50.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
