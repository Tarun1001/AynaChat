part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

class SignUpEvent extends AuthEvent{
  final String userName;
  final String emailID;
  final String password;

  SignUpEvent(this.userName, this.emailID, this.password);
  @override
  // TODO: implement props
  List<Object?> get props => [userName,emailID,password];

}
