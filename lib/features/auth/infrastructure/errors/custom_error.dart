class CustomError implements Exception {
  final String errorMessage;
  final int errorCode;
  CustomError({required this.errorMessage, required this.errorCode});
}
