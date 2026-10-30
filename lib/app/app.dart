import 'package:final_depi/app/routes/routes_app.dart';
import 'package:flutter/material.dart';


class HelhalyApp extends StatelessWidget {
  const HelhalyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '7elhaly - حلهالي',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F9FD),
        primarySwatch: Colors.blue,
        fontFamily: 'sans-serif',
      ),
       initialRoute: '/',
       onGenerateRoute: RoutesApp.onGeneratedRoute,

    );
  }
}
