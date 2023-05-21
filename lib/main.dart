import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game/providers/snake_commands_provider.dart';
import 'package:snake_game/screen/splash_screen/splash_screen.dart';

void main() => runApp(
    /*
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const MyApp(), // Wrap your app
      ),
      */
    const MyApp());

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
        //locale: DevicePreview.locale(context),
        //builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
