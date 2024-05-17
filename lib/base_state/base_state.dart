
import 'package:project_management_app/models/task_model/task_model.dart';

abstract class BaseState{
  const BaseState();
}

class InitialState extends BaseState{
  const InitialState();
}

class LoadingState<T> extends BaseState{
  const  LoadingState({this.data});

  final T? data;
}

class SuccessState<T> extends BaseState {
  const SuccessState({this.data, this.message});

  final T? data;
  final T? message;
}


class ErrorState extends BaseState {
  final String errorMessage;

  const ErrorState(this.errorMessage);
}






class TaskInitialState extends BaseState{
        const TaskInitialState();
}



class TaskLoadingState<T> extends BaseState{
  const TaskLoadingState({this.data, this.nameOfProject});

  final String? nameOfProject;
  final T? data;
}

class TaskSuccessState<T> extends BaseState{
  const TaskSuccessState({this.data, this.message,this.nameOfProject});

  final T? data;
  final T? message;
  final String? nameOfProject;
}

class TaskErrorState extends BaseState {
  final String errorMessage;
  final String? nameOfProject;

  const TaskErrorState(this.errorMessage,{this.nameOfProject});
}

