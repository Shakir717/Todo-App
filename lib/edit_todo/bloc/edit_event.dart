part of 'edit_bloc.dart';

@freezed
class EditTodoEvent with _$EditTodoEvent {
const factory EditTodoEvent.editTodoTitleChanged({required String title})= editTodoTitleChanged;
const factory EditTodoEvent.editTodoDescriptionChanged({required String description})= editTodoDescriptionChanged;
const factory EditTodoEvent.editTodoSubmitted()= editTodoSubmitted;
}

