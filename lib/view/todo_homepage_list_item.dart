import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/viewmodel/todo_providers.dart';

class TodoItem extends HookConsumerWidget {
  const TodoItem(this.todo, {Key? key}) : super(key: key);

  final TodoObjectModel todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemFocusNode = useFocusNode();
    useListenable(itemFocusNode);
    final isFocused = itemFocusNode.hasFocus;

    final textEdittingController = useTextEditingController();
    final textFieldFocusNode = useFocusNode();

    return Material(
      // color: Colors.white,
      // elevation: 6,
      child: Focus(
        focusNode: itemFocusNode,
        onFocusChange: (focused) {
          if (focused) {
            textEdittingController.text = todo.description;
          } else {
            ref.read(todoListProvider.notifier).todoEdit(
                  id: todo.id,
                  description: textEdittingController.text,
                );
            // return value;
          }
        },
        child: ListTile(
          onTap: () {
            itemFocusNode.requestFocus();
            textFieldFocusNode.requestFocus();
          },
          leading: Checkbox(
              value: todo.isCompleted,
              onChanged: (value) {
                ref.read(todoListProvider.notifier).todoToggle(todo.id);
                // return value;
              }),
          title: isFocused
              ? TextField(
                  autofocus: true,
                  focusNode: textFieldFocusNode,
                  controller: textEdittingController,
                )
              : Text(todo.description),
        ),
      ),
    );
  }
}
