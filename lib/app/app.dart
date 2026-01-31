import 'package:flutter/material.dart';
import 'router.dart';

class EasySakanApp extends StatelessWidget {
  const EasySakanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Sakan',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      home: const Scaffold(body: Center(child: Text('Easy Sakan App'))),
    );
  }
}
