part of 'todo_overview_bloc.dart';

@freezed
class TodoOverviewEvent with _$TodoOverviewEvent{
const factory TodoOverviewEvent.todoOverviewSubscriptionRequested() = todoOverviewSubscriptionRequested;
const factory TodoOverviewEvent.todosOverviewTodoCompletionToggled({required Todo todo, required bool isCompleted,})=todosOverviewTodoCompletionToggled;
const factory TodoOverviewEvent.todosOverviewTodoDeleted({required Todo todo})=todosOverviewTodoDeleted;
const factory TodoOverviewEvent.todosOverviewUndoDeletionRequested()=todosOverviewUndoDeletionRequested;
const factory TodoOverviewEvent.todosOverviewFilterChanged({required TodosViewFilter filter})=todosOverviewFilterChanged;
const factory TodoOverviewEvent.todosOverviewToggleAllRequested()=todosOverviewToggleAllRequested;
const factory TodoOverviewEvent.todosOverviewClearCompletedRequested()=todosOverviewClearCompletedRequested;
}