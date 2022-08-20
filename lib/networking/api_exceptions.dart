class AppException implements Exception {
  final _message;
  final _prefix;
AppException([this._message, this._prefix]);
String toString() {
    return "$_prefix$_message";
  }
}
class FetchDataException extends AppException {
  FetchDataException([String message])
      : super(message, "Error During Communication: ");
}
class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}
class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}
class InvalidInputException extends AppException {
  InvalidInputException([String message]) : super(message, "Invalid Input: ");
}
class ApiResponse<T> {
  Status status;
T data;
String message;
ApiResponse.loading(this.message) : status = Status.LOADING;
ApiResponse.completed(this.data) : status = Status.COMPLETED;
ApiResponse.error(this.message) : status = Status.ERROR;
@override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
enum Status { LOADING, COMPLETED, ERROR }