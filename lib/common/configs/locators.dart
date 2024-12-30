import 'package:encrypt_shared_preferences/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'locators.config.dart';

final dI = GetIt.instance;

@module
abstract class AppModule {
  // ignore: invalid_annotation_target
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  // ignore: invalid_annotation_target
  @preResolve
  Future<EncryptedSharedPreferences> get prefs2 => getShared();
}

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> configureInjection() async => dI.init();

Future<EncryptedSharedPreferences> getShared() async {
  await EncryptedSharedPreferences.initialize("Agfjdgjr34645tjh");
  return EncryptedSharedPreferences.getInstance();
}
