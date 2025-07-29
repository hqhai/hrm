import 'package:base_app/app.dart';
import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/configs/push_noti.dart';
import 'package:base_app/firebase_options.dart';
import 'package:base_app/presentations/bloc/main_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initHydratedBloc();
  await configureInjection();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupOneSignal();
  runApp(const _InitApp());
}

Future<void> _initHydratedBloc() async {
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorageDirectory.web
          : HydratedStorageDirectory((await getTemporaryDirectory()).path));
}

class _InitApp extends StatelessWidget {
  const _InitApp();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: MainBloc.allBlocs(),
      child: const App(),
    );
  }
}
