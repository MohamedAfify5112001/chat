abstract class RegisterState {}

class InitialRegisterState extends RegisterState {}

class SuccessRegisterState extends RegisterState {}

class LoadingRegisterState extends RegisterState {}

class ErrorRegisterState extends RegisterState {}

class SuccessCreateUserState extends RegisterState {
}

class ErrorCreateUserState extends RegisterState {}

class LoadingCreateUserState extends RegisterState {}

class ChangeSecurePassword extends RegisterState{}
