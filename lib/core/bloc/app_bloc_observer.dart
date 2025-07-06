import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    log('Event: ${event.runtimeType}', name: bloc.runtimeType.toString());
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    log(
      'Transition: ${transition.currentState} -> ${transition.nextState}',
      name: bloc.runtimeType.toString(),
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log(
      'Error: $error',
      name: bloc.runtimeType.toString(),
      error: error,
      stackTrace: stackTrace,
    );
  }
}
