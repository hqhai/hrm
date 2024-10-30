import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/utils/app_config_utils.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/init.dart';

Future<void> main() async {
  final env = await AppConfigUtils.getConfigFromEnv(Assets.env.envProduction);
  setConfig(env);
  await initApp();
}
