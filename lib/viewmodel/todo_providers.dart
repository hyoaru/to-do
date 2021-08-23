import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/model/todo_notifiers.dart';
import 'package:todo/model/todo_model.dart';

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
    StateProvider<TodoListFilter>((_) => TodoListFilter.all);

final uncompletedTodosCount = Provider<int>((ref) {
  return ref
      .watch(todoListProvider)
      .where((todoObjectModel) => !todoObjectModel.isCompleted)
      .length;
});

final filteredTodos = Provider<List<TodoObjectModel>>((ref) {
  final filters = ref.watch(todoListFilterProvider);
  final todos = ref.watch(todoListProvider);

  switch (filters.state) {
    case TodoListFilter.completed:
      return todos.where((todos) => todos.isCompleted).toList();
    case TodoListFilter.active:
      return todos.where((todos) => !todos.isCompleted).toList();
    case TodoListFilter.all:
      return todos;
  }
});
