import 'package:fpdart/fpdart.dart';
import 'package:smart_trip_planner/core/error/failure.dart';
import 'package:smart_trip_planner/core/usecase/usecase.dart';
import 'package:smart_trip_planner/core/common/entities/user.dart' show user;
import 'package:smart_trip_planner/features/authentication/domain/repository/auth_repository.dart';

class CurrentUser implements UseCase<user, NoParams> {
  final authRepository _authRepository;
  CurrentUser(this._authRepository);
  @override
  Future<Either<Failure, user>> call(NoParams params) async
  {
    return await _authRepository.getCurrentUserData();
  }
}

class NoParams {
}
