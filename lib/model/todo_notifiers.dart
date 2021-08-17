import 'package:state_notifier/state_notifier.dart';
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
    for (final TodoObjectModel in state) {
      if (TodoObjectModel.id == id) {
        TodoObjectModel(
          id: TodoObjectModel.id,
          description: TodoObjectModel.description,
          isCompleted: !TodoObjectModel.isCompleted,
        );
      }
      // else
      //   TodoObjectModel;
    }
  }
}
