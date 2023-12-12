import 'package:flutter/material.dart';
import 'package:wedding_planner_management/src/domain/enums/private/loading_enum.dart';

class StateData<T> {
  const StateData._({
    this.value,
    this.message,
    required this.state,
  });

  final T? value;
  final String? message;
  final LoadingState state;

  const StateData.loading() : this._(state: LoadingState.loading);

  const StateData.success(T value)
      : this._(state: LoadingState.success, value: value);

  const StateData.error(String message)
      : this._(state: LoadingState.error, message: message);

  bool get isLoading => state == LoadingState.loading;

  bool get isSuccess => state == LoadingState.success;

  bool get isError => state == LoadingState.error;

  String? get loadingMessage => state == LoadingState.loading ? message : null;

  StateData<T> loading() {
    return StateData<T>._(
      value: value,
      message: message,
      state: LoadingState.loading,
    );
  }

  StateData<T> success(T value, {String? message}) {
    return StateData<T>._(
      value: value,
      message: message,
      state: LoadingState.success,
    );
  }

  StateData<T> error(String message) {
    return StateData<T>._(
      value: value,
      message: message,
      state: LoadingState.error,
    );
  }

  StateData<T> copyWith({
    ValueGetter<T?>? value,
    ValueGetter<String?>? message,
    LoadingState? state,
  }) {
    return StateData<T>._(
      value: value != null ? value.call() : this.value,
      message: message != null ? message.call() : this.message,
      state: state ?? this.state,
    );
  }
}
