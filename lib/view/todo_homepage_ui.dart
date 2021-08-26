import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sizer/sizer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/view/todo_homepage_textfield.dart';
import 'package:todo/view/todo_homepage_title.dart';
import 'package:todo/viewmodel/todo_providers.dart';

class HomepageUI extends HookWidget {
  const HomepageUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = useProvider(filteredTodos);
    final todoTextController = useTextEditingController();

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
            children: [
              const HomeTitle(),
              TodoTextField(todoTextController: todoTextController),
              SizedBox(
                height: 3.h,
              ),
              Column(
                children: [
                  // if (todos.isNotEmpty) const Divider(height: 0),
                  for (var i = 0; i < todos.length; i++) ...[
                    if (i > 0) const Divider(height: 0),
                    Dismissible(
                      key: ValueKey(todos[i].id),
                      onDismissed: (_) {
                        context
                            .read(todoListProvider.notifier)
                            .todoRemove(todos[i]);
                      },
                      child: TodoItem(todos[i]),
                    ),
                  ]
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TodoItem extends HookWidget {
  const TodoItem(this.todo, {Key? key}) : super(key: key);

  final TodoObjectModel todo;

  @override
  Widget build(BuildContext context) {
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
            context.read(todoListProvider.notifier).todoEdit(
                  id: todo.id,
                  description: textEdittingController.text,
                );
          }
        },
        child: ListTile(
          onTap: () {
            itemFocusNode.requestFocus();
            textFieldFocusNode.requestFocus();
          },
          leading: Checkbox(
            value: todo.isCompleted,
            onChanged: (value) =>
                context.read(todoListProvider.notifier).todoToggle(todo.id),
          ),
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
