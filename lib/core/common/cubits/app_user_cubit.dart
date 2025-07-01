import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_trip_planner/core/common/entities/user.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState>{
  AppUserCubit():super(AppUserInitial());

  void updateUserStatus(user?User)
  {
    if(User==null)
      {
        emit(AppUserInitial());
      }else{
      emit(AppUserLoggedIn(User));
    }
  }
}