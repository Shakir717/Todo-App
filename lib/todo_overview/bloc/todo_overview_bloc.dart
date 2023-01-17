import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_api/todo_api.dart';
import 'package:todo_repository/todo_repository.dart';
import '../models/todo_view_filter.dart';
part 'todo_overview_bloc.freezed.dart';
part 'todo_overview_event.dart';
part 'todo_overview_state.dart';


class TodosOverviewBloc extends Bloc<TodoOverviewEvent, TodosOverviewState> {
  TodosOverviewBloc({
    required TodosRepository todosRepository,
  })  : _todosRepository = todosRepository,
        super( TodosOverviewState()) {
    on<todoOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<todosOverviewTodoCompletionToggled>(_onTodoCompletionToggled);
    on<todosOverviewTodoDeleted>(_onTodoDeleted);
    on<todosOverviewUndoDeletionRequested>(_onUndoDeletionRequested);
    on<todosOverviewFilterChanged>(_onFilterChanged);
    on<todosOverviewToggleAllRequested>(_onToggleAllRequested);
    on<todosOverviewClearCompletedRequested>(_onClearCompletedRequested);
  }

  final TodosRepository _todosRepository;

  Future<void> _onSubscriptionRequested(
      todoOverviewSubscriptionRequested event,
      Emitter<TodosOverviewState> emit,
      ) async {
    emit(state.copyWith());

    await emit.forEach<List<Todo>>(
      _todosRepository.getTodos(),
      onData: (todos) => state.copyWith(
        status: TodosOverviewStatus.success,
        todos: todos,
      ),
      onError: (_, __) => state.copyWith(
        status: TodosOverviewStatus.failure,
      ),
    );
  }

  Future<void> _onTodoCompletionToggled(
      todosOverviewTodoCompletionToggled event,
      Emitter<TodosOverviewState> emit,
      ) async {
    final newTodo = event.todo.copyWith(isCompleted: event.isCompleted);
    await _todosRepository.saveTodo(newTodo);
  }

  Future<void> _onTodoDeleted(
      todosOverviewTodoDeleted event,
      Emitter<TodosOverviewState> emit,
      ) async {
    emit(state.copyWith(lastDeletedTodo: event.todo));
    await _todosRepository.deleteTodo(event.todo.id);
  }

  Future<void> _onUndoDeletionRequested(
      todosOverviewUndoDeletionRequested event,
      Emitter<TodosOverviewState> emit,
      ) async {
    assert(
    state.lastDeletedTodo != null,
    'Last deleted todo can not be null.',
    );

    final todo = state.lastDeletedTodo!;
    emit(state.copyWith(lastDeletedTodo:  null));
    await _todosRepository.saveTodo(todo);
  }

  void _onFilterChanged(
      todosOverviewFilterChanged event,
      Emitter<TodosOverviewState> emit,
      ) {
    emit(state.copyWith(filter: event.filter));
  }

  Future<void> _onToggleAllRequested(
      todosOverviewToggleAllRequested event,
      Emitter<TodosOverviewState> emit,
      ) async {
    final areAllCompleted = state.todos!.every((todo) => todo.isCompleted);
    await _todosRepository.completeAll(isCompleted: !areAllCompleted);
  }

  Future<void> _onClearCompletedRequested(
      todosOverviewClearCompletedRequested event,
      Emitter<TodosOverviewState> emit,
      ) async {
    await _todosRepository.clearCompleted();
  }
}
