import 'package:formz/formz.dart';

// Define input validation errors
enum ConfirmedPasswordError { equality, required }

// Extend FormzInput and provide the input type and error type.
class ConfirmedPassword extends FormzInput<String, ConfirmedPasswordError> {
  static final RegExp passwordRegExp = RegExp(
    r'(?:(?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$',
  );

  // Call super.pure to represent an unmodified form input.
  const ConfirmedPassword.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const ConfirmedPassword.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == ConfirmedPasswordError.equality) {
      return 'Cotraseñas no coinciden';
    }
    if (displayError == ConfirmedPasswordError.required) {
      return 'Campo requerido';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  ConfirmedPasswordError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return ConfirmedPasswordError.required;
    }
    if (value.toString() == '-1' || value.trim().toString() == '-1') {
      return ConfirmedPasswordError.equality;
    }

    return null;
  }
}
