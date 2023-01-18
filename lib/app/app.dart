import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_repository/todo_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../home/view/home_page.dart';


class App extends StatelessWidget {
  const App({super.key, required this.todosRepository});

  final TodosRepository todosRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: todosRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: .5,
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),
          iconTheme: IconThemeData(color: Colors.black),
        )
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: HomePage(),
    );
  }
}