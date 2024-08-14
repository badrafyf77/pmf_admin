import 'dart:io';
import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/core/config/theme.dart';
import 'package:pmf_admin/core/utils/service_locator.dart';
import 'package:pmf_admin/features/auth/data/repo/auth_repo_implementation.dart';
import 'package:pmf_admin/features/auth/presentation/manager/sign%20in%20bloc/sign_in_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  if (!kIsWeb && (Platform.isWindows || Platform.isMacOS)) {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      debugPrint('Erreur : $e');
    }
  }
  runApp(const MyApp());
  doWhenWindowReady(() {
    const initialSize = Size(1200, 650);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
  setupServiceLocator();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => SignInBloc(
            getIt.get<AuthRepoImplementation>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppThemes.appTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
