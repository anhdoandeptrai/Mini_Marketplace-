import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/user_entity.dart';
import '../../repositories/auth_repository.dart';

class RegisterUseCase implements UseCase<UserEntity, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(RegisterParams params) async {
    return await repository.register(
      params.email,
      params.password,
      params.name,
      params.role,
    );
  }
}

class RegisterParams {
  final String email;
  final String password;
  final String name;
  final String role;

  RegisterParams({
    required this.email,
    required this.password,
    required this.name,
    required this.role,
  });
}
