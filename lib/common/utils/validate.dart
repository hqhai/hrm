import 'package:base_app/common/utils/regex_exp.dart';

bool isEmpty(var object) {
  if (object == false ||
      object == 'false' ||
      object == 'null' ||
      object == 'N/A' ||
      object == null ||
      object == {} ||
      object == '' ||
      object == []) {
    return true;
  }
  if (object is String && object.trim() == "") {
    return true;
  }
  if (object is Iterable && object.isEmpty) {
    return true;
  }
  return false;
}

abstract class StringValidator {
  bool isValid(String value);
}

class RegexValidator implements StringValidator {
  RegexValidator({required this.regexSource});
  final String regexSource;

  /// value: the input string
  /// returns: true if the input string is a full match for regexSource
  @override
  bool isValid(String value) {
    try {
      final regex = RegExp(regexSource);
      final matches = regex.allMatches(value);
      for (Match match in matches) {
        if (match.start == 0 && match.end == value.length) {
          return true;
        }
      }
      return false;
    } catch (e) {
      // Invalid regex
      assert(false, e.toString());
      return true;
    }
  }
}

bool appValidatePassword(String pass) {
  RegExp regExp = RegExp(checkPasswordRegexExp);
  return regExp.hasMatch(pass);
}

bool appValidateEmail(String email) {
  RegExp regExp = RegExp(checkEmailRegexExp);
  return regExp.hasMatch(email);
}
