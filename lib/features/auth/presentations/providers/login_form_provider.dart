import 'package:clientes_app/features/auth/presentations/providers/auth_provider.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:formz/formz.dart';

import '../../../shared/infrastructure/inputs/index.dart';

final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  final userLoginNRegisterCallBack = ref.watch(authProvider.notifier);
  final loginUserCallBack = userLoginNRegisterCallBack.loginUser;
  final registerUserCallBack = userLoginNRegisterCallBack.registerUser;

  return LoginFormNotifier(
      loginUserCallBack: loginUserCallBack,
      registerUserCallBack: registerUserCallBack);
});

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final Function(String, String) loginUserCallBack;
  final Function(String, String, String) registerUserCallBack;
  LoginFormNotifier(
      {required this.loginUserCallBack, required this.registerUserCallBack})
      : super(LoginFormState());

//* metodos para el login
  void onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
        email: newEmail, isValid: Formz.validate([newEmail, state.password]));
  }

  void onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate([newPassword, state.email]));
  }

  void onFormSubmit() async {
    _touchEveryField();
    state = state.copyWith(isPosting: true);
    await loginUserCallBack(state.email.value, state.password.value);
    state = state.copyWith(isPosting: false);
  }

  void _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    state = state.copyWith(
        isFormPosted: true,
        email: email,
        password: password,
        isValid: Formz.validate([email, password]));
  }

  //* metodos para el register

  void onNameRegisterChange(String value) {
    final newName = Name.dirty(value);
    state = state.copyWith(
        name: newName,
        isValid: Formz.validate([newName, state.password, state.email]));
  }

  void onEmailRegisterChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
        email: newEmail,
        isValid: Formz.validate([newEmail, state.password, state.name]));
  }

  void onPasswordRegisterChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate([newPassword, state.email, state.name]));
  }

  void onPasswordConfirmed(String value) {
    final newPassword = ConfirmedPassword.dirty(value);
    state = state.copyWith(
        confirmedPassword: newPassword,
        isValid: Formz.validate(
            [newPassword, state.password, state.email, state.name]));
  }

  void _reviewPasswords() {
    final password = Password.dirty(state.password.value);
    final confirmedPassword =
        ConfirmedPassword.dirty(state.confirmedPassword.value);
    if (password.value != confirmedPassword.value) {
      Formz.validate(
          [state.password, state.confirmedPassword, state.email, state.name]);
    } else {
      state = state.copyWith(isPasswordMatched: true);
    }
  }

  void _onPasswordDissMatched() {
    final notMatched = ConfirmedPassword.dirty('-1');
    state = state.copyWith(
        confirmedPassword: notMatched,
        isFormPosted: true,
        isValid: Formz.validate(
            [notMatched, state.password, state.email, state.name]));
  }

  void _touchEveryRegisterField() {
    final name = Name.dirty(state.name.value);
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final confirmedPassword =
        ConfirmedPassword.dirty(state.confirmedPassword.value);
    state = state.copyWith(
        isFormPosted: true,
        email: email,
        name: name,
        password: password,
        confirmedPassword: confirmedPassword,
        isValid: Formz.validate([email, name, password, confirmedPassword]));
  }

  void onRegisterSubmit() async {
    _reviewPasswords();
    state = state.copyWith(isPosting: true);
    if (state.isPasswordMatched) {
      _touchEveryRegisterField();
      await registerUserCallBack(
          state.name.value, state.email.value, state.password.value);
      state = state.copyWith(isPosting: false);
    }
    await Future.delayed(Duration(milliseconds: 280));
    _onPasswordDissMatched();
    state = state.copyWith(isPosting: false);
  }
}

class LoginFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final bool isPasswordMatched;
  final Name name;
  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.isPasswordMatched = false,
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    bool? isPasswordMatched,
    Name? name,
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
  }) =>
      LoginFormState(
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isValid: isValid ?? this.isValid,
          isPasswordMatched: isPasswordMatched ?? this.isPasswordMatched,
          name: name ?? this.name,
          email: email ?? this.email,
          password: password ?? this.password,
          confirmedPassword: confirmedPassword ?? this.confirmedPassword);
}
