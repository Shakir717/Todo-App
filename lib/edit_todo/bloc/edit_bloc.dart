import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_api/todo_api.dart';
import 'package:todo_repository/todo_repository.dart';
part 'edit_event.dart';
part 'edit_state.dart';
part 'edit_bloc.freezed.dart';


class EditTodoBloc extends Bloc<EditTodoEvent, EditTodoState> {
  EditTodoBloc({
    required TodosRepository todosRepository,
    required Todo? initialTodo,
  })  : _todosRepository = todosRepository,
        super(
        EditTodoState(
          initialTodo: initialTodo,
          title: initialTodo?.title ?? '',
          description: initialTodo?.description ?? '',
          status: EditTodoStatus.initial,
        ),
      ) {
    on<editTodoTitleChanged>(_onTitleChanged);
    on<editTodoDescriptionChanged>(_onDescriptionChanged);
    on<editTodoSubmitted>(_onSubmitted);
  }

  final TodosRepository _todosRepository;

  void _onTitleChanged(
      editTodoTitleChanged event,
      Emitter<EditTodoState> emit,
      ) {
    emit(state.copyWith(title: event.title));
  }

  void _onDescriptionChanged(
      editTodoDescriptionChanged event,
      Emitter<EditTodoState> emit,
      ) {
    emit(state.copyWith(description: event.description));
  }

  Future<void> _onSubmitted(
      editTodoSubmitted event,
      Emitter<EditTodoState> emit,
      ) async {
    emit(state.copyWith(status: EditTodoStatus.loading));
    final todo = (state.initialTodo ?? Todo(title: '', id: DateTime.now().millisecondsSinceEpoch.toString(), description: '')).copyWith(
      title: state.title,
      description: state.description,
    );

    try {
      await _todosRepository.saveTodo(todo);
      emit(state.copyWith(status: EditTodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditTodoStatus.failure));
    }
  }
}
