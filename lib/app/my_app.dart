import 'package:provider/provider.dart';
import 'package:snake_game/presentation/snake_commands_provider.dart';
import 'package:flutter/material.dart';

import '../presentation/pages/splash_page/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => SnakeCommandsProvider(), lazy: false),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
