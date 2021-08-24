import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/model/todo_model.dart';

class TodoList extends StateNotifier<List<TodoObjectModel>> {
  TodoList([List<TodoObjectModel>? initialState]) : super(initialState ?? []);

  void todoAdd(String description) {
    state = [
      ...state,
      TodoObjectModel(description: description),
    ];
  }

  void todoToggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          TodoObjectModel(
            description: todo.description,
            id: todo.id,
            isCompleted: todo.isCompleted,
          )
        else
          todo,
    ];
  }

  void todoEdit({required String id, required String description}) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          TodoObjectModel(
            id: todo.id,
            description: description,
            isCompleted: todo.isCompleted,
          )
        else
          todo,
    ];
  }

  void todoRemove(TodoObjectModel target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }
}
