import 'package:final_depi/app/app.dart';
import 'package:flutter/material.dart';
import 'package:final_depi/core/services/local_storage_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/auth_dependencies.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await LocalStorageService.init();

  runApp(
    BlocProvider(
      create: (context) => AuthDependencies.getAuthBloc(),
      child: const HelhalyApp(),
    ),
  );
}