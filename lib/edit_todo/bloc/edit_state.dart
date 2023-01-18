part of 'edit_bloc.dart';

enum EditTodoStatus { initial, loading, success, failure }

extension EditTodoStatusX on EditTodoStatus {
  bool get isLoadingOrSuccess => [
    EditTodoStatus.loading,
    EditTodoStatus.success,
  ].contains(this);

}

extension EditTodo on EditTodoState{
  bool get isNewTodo => initialTodo == null;
}

@freezed
class EditTodoState with _$EditTodoState {
  const factory EditTodoState({
    required EditTodoStatus status,
    Todo? initialTodo,
    @Default('') String title,
    @Default('') String description,
  })= _EditTodoState;

}
