import 'package:flutter/widgets.dart';
import 'package:todo_local_storage/todo_local_storage.dart';
import 'bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final todosApi = LocalStorageApi(
    plugin: await SharedPreferences.getInstance(),
  );

  bootstrap(todosApi: todosApi);
}