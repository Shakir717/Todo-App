part of  'todo_overview_bloc.dart';

enum TodosOverviewStatus { initial, loading, success, failure }

@freezed
class TodosOverviewState with _$TodosOverviewState {
  factory TodosOverviewState({
    @Default(TodosOverviewStatus.initial) TodosOverviewStatus? status,
    @Default([]) List<Todo>? todos,
    @Default(TodosViewFilter.all) TodosViewFilter? filter,
    Todo? lastDeletedTodo,
  })= _TodosOverviewState;

 Iterable<Todo> get filteredTodos => filter!.applyAll(todos!);
}
