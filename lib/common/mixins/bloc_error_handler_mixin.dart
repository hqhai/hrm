import 'package:base_app/common/exception/remote/remote_exception.dart';

/// Mixin providing shared error handling for BLoCs.
/// Extracts error codes from [RemoteException] and returns them
/// so BLoCs can emit the appropriate error state.
mixin BlocErrorHandlerMixin {
  /// Extracts the first error code from a caught exception.
  /// Returns the error code string for the BLoC to emit.
  String extractErrorCode(Object error) {
    if (error is RemoteException) {
      final errors = error.serverError?.errors;
      if (errors != null && errors.isNotEmpty) {
        return errors.first;
      }
    }
    return 'error';
  }

  /// Returns true if the error is a [RemoteException] with server-defined errors.
  bool hasServerErrors(Object error) {
    if (error is RemoteException) {
      final errors = error.serverError?.errors;
      return errors != null && errors.isNotEmpty;
    }
    return false;
  }
}
