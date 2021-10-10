abstract class LoginState {}

class InitialLoginState extends LoginState {}

class ChangeSecurePassword extends LoginState{}

class SuccessLoginState extends LoginState {
  final String uId;
  SuccessLoginState({required this.uId});
}

class LoadingLoginState extends LoginState {}

class ErrorLoginState extends LoginState {
  String message;
  ErrorLoginState({required this.message});
}
