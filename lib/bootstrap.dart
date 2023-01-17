import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_api/todo_api.dart';
import 'package:todo_repository/todo_repository.dart';

import 'app/app.dart';
import 'app/app_bloc_observer.dart';

void bootstrap({required TodoApi todosApi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = AppBlocObserver();

  final todosRepository = TodosRepository(todosApi: todosApi);

  runZonedGuarded(
        () => runApp(App(todosRepository: todosRepository)),
        (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}