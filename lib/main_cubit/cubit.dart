
import 'package:chat/main_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialStates());
  static AppCubit get(context) => BlocProvider.of(context);

}
