import 'package:aynachatx/core/entities/user.dart';
import 'package:aynachatx/core/errors/failures.dart';
import 'package:aynachatx/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:aynachatx/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource authLocalDataSource;

  const AuthRepositoryImpl(
    this.authLocalDataSource,
  );

  @override
  Future<Either<Failure, User>> currentUser() async{
    throw UnimplementedError();
  }

  @override
Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) async{
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String name, required String email, required String password}) async{

     try {
       var auth =  authLocalDataSource.createUser(
    user: User( name: name, password: password));
      return right(auth as User);
     }on Exception catch(e){
       return left(Failure(e.toString()));
     }


  }
}
