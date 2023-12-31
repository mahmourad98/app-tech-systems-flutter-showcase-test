import 'package:dartz/dartz.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/features/auth/domain/model/credentials.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LoginPresentationModel implements LoginViewModel {
  /// Credentials used to log in
  final Credentials credentials;

  /// Result of the login operation
  final FutureResult<Either<LogInFailure, User>> loginResult;

  /// Whether the login button should be enabled
  @override bool get isLoginEnabled => credentials.isValid();

  /// Whether show loading indicator or not
  @override bool get isLoading => loginResult.isPending();

  /// Creates the initial state
  LoginPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LoginInitialParams initialParams,
  ) : credentials = Credentials(), loginResult = const FutureResult.empty();

  /// Used for the copyWith method
  LoginPresentationModel._({
    required this.credentials,
    required this.loginResult,
  });

  LoginPresentationModel copyWith({
    Credentials? credentials,
    FutureResult<Either<LogInFailure, User>>? loginResult,
  }) => LoginPresentationModel._(
    credentials: credentials ?? this.credentials,
    loginResult: loginResult ?? this.loginResult,
  );
}

/// Interface to expose fields used by the view (page).
abstract class LoginViewModel {
  bool get isLoginEnabled;
  bool get isLoading;
}
