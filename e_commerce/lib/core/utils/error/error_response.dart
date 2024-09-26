class ErrorResponse {
  final String? status;
  final String? code;
  final String? message;

  const ErrorResponse({
    this.status = 'SUCCESS',
    this.code = '0000',
    this.message = '',
  });
}
