import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/viewmodel/todo_providers.dart';

class Toolbar extends HookConsumerWidget {
  const Toolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(todoListFilterProvider);
    final searchController = useTextEditingController();
    final search = ref.watch(todoListSearchProvider);

    Color textColorFor(TodoListFilter value) {
      return filter.state == value ? Colors.blue : Colors.black;
    }

    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Expanded(
          //   flex: 2,
          //   child: Text(
          //     '${ref.watch(uncompletedTodosCount).toString()} items left',
          //     overflow: TextOverflow.ellipsis,
          //   ),
          // ),
          Expanded(
            flex: 7,
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                border: InputBorder.none,
                icon: Icon(Icons.search),
              ),
              onChanged: (value) {
                search.state = value;
              },
            ),
          ),
          Tooltip(
            message: 'All todos',
            child: TextButton(
              onPressed: () => filter.state = TodoListFilter.all,
              child: Text(
                'All',
                style: TextStyle(color: textColorFor(TodoListFilter.all)),
              ),
            ),
          ),
          Tooltip(
            message: 'Active todos',
            child: TextButton(
              onPressed: () => filter.state = TodoListFilter.active,
              child: Text(
                'Active',
                style: TextStyle(color: textColorFor(TodoListFilter.active)),
              ),
            ),
          ),
          Tooltip(
            message: 'Completed todos',
            child: TextButton(
              onPressed: () => filter.state = TodoListFilter.completed,
              child: Text(
                'Completed',
                style: TextStyle(color: textColorFor(TodoListFilter.completed)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
