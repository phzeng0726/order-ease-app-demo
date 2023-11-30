import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ordering_system_client_app/bloc_observer.dart';
import 'package:ordering_system_client_app/core/models/core/cache_helper.dart';
import 'package:ordering_system_client_app/views/core/app_widget.dart';
import 'package:ordering_system_client_app/views/core/widgets/loading_overlay.dart';

import 'firebase_options.dart';

// flutter pub run build_runner watch --delete-conflicting-outputs
// flutter packages pub get
// flutter pub run build_runner build --delete-conflicting-outputs
// flutter gen-l10n

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/.env');
  Bloc.observer = const AppBlocObserver();
  LoadingOverlay.init();
  await CacheHelper.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const AppWidget());
}
