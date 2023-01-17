import 'package:freezed_annotation/freezed_annotation.dart';
part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo{
  @Assert('id.isNotEmpty', 'id cannot be empty')
   factory Todo({
    required String id,
    required String title,
    required String description,
    @Default(false) bool isCompleted,
})= _Todo;

  factory Todo.fromJson(Map<String, Object?> json)
  => _$TodoFromJson(json);
}