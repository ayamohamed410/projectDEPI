import 'package:final_depi/app/app.dart';
import 'package:flutter/material.dart';
import 'package:final_depi/core/services/local_storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalStorageService.init();

  runApp(const HelhalyApp());
}
