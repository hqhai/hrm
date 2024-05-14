
import 'package:base_app/data/models/check_in_setting/create_check_in_setting_request.dart';

abstract class CheckInSettingService{
  Future<int> createCheckInSetting({required CreateCheckInSettingRequest createCheckInSettingRequest});

 
}