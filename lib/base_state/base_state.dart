
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