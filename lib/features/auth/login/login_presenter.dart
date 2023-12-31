import 'package:bloc/bloc.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/core/utils/either_extensions.dart';
import 'package:flutter_demo/core/utils/mvp_extensions.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/localization/app_localizations_utils.dart';


class LoginPresenter extends Cubit<LoginViewModel> with CubitToCubitCommunicationMixin<LoginViewModel> {
  LoginPresenter(
    LoginPresentationModel super.model,
    this.navigator,
    this.logInUseCase,
  );

  final LoginNavigator navigator;
  final LogInUseCase logInUseCase;

  // ignore: unused_element
  LoginPresentationModel get _model => state as LoginPresentationModel;

  /// addEmail is called when the user types in the email field
  void addEmail(String email,) {
    return emit(_model.copyWith(credentials: _model.credentials.copyWith(email: email,),),);
  }

  /// addPassword is called when the user types in the password field
  void addPassword(String password,) {
    return emit(_model.copyWith(credentials: _model.credentials.copyWith(password: password,),),);
  }

  /// onLoginPressed is called when the user presses the login button
  Future<void> onLoginPressed() async {
    await Future(
      () async => await logInUseCase
          .execute(username: _model.credentials.email, password: _model.credentials.password,) //
          .observeStatusChanges((result) => emit(_model.copyWith(loginResult: result)))
          .asyncFold(
            (fail) => navigator.showError(fail.displayableFailure()),
            (success) => navigator.showAlert(title: appLocalizations.welcomeMessage, message: appLocalizations.loginSuccessMessage,),
      ),
    );
  }
}
