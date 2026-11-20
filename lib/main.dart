import 'package:final_depi/app/app.dart';
import 'package:final_depi/core/services/local_storage_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/widgets.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/auth_dependencies.dart';
import 'package:flutter/foundation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Enable App Check for development
  await FirebaseAppCheck.instance.activate(
    providerAndroid: kDebugMode
        ? const AndroidDebugProvider()
        : const AndroidPlayIntegrityProvider(),
  );

  // Initialize local storage
  await LocalStorageService.init();

  runApp(
    BlocProvider(
      create: (context) => AuthDependencies.getAuthBloc(),
      child: const HelhalyApp(),
    ),
  );
}