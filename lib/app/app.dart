import 'package:final_depi/app/routes/routes_app.dart';
import 'package:flutter/material.dart';



class HelhalyApp extends StatelessWidget {
  const HelhalyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RoutesApp.onGeneratedRoute,
    );
  }
}