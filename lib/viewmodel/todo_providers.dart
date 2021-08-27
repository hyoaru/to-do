import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/model/todo_notifiers.dart';

final todoListProvider =
    StateNotifierProvider<TodoList, List<TodoObjectModel>>((ref) {
  return TodoList([
    TodoObjectModel(description: 'hi', id: 'todo-0'),
    TodoObjectModel(description: 'henlo', id: 'todo-1'),
    TodoObjectModel(description: 'bonjour', id: 'todo-2'),
  ]);
});

enum TodoListFilter { all, active, completed }

final todoListFilterProvider =
    StateProvider<TodoListFilter>((ref) => TodoListFilter.all);

final todoListSearchProvider = StateProvider((_) => '');

final uncompletedTodosCount = Provider<int>((ref) {
  return ref
      .watch(todoListProvider)
      .where((todoObjectModel) => !todoObjectModel.isCompleted)
      .length;
});

final filteredTodos = Provider<List<TodoObjectModel>>((ref) {
  final filters = ref.watch(todoListFilterProvider);
  final todos = ref.watch(todoListProvider);
  final search = ref.watch(todoListSearchProvider);

  List<TodoObjectModel> filteredTodos;

  switch (filters.state) {
    case TodoListFilter.completed:
      filteredTodos = todos.where((todos) => todos.isCompleted).toList();
      break;
    case TodoListFilter.active:
      filteredTodos = todos.where((todos) => !todos.isCompleted).toList();
      break;
    case TodoListFilter.all:
    default:
      filteredTodos = todos;
      break;
  }

  if (search.state.isEmpty) {
    return filteredTodos;
  } else {
    return filteredTodos
        .where((todo) => todo.description.contains(search.state))
        .toList();
  }
});
