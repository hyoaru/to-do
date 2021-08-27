import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sizer/sizer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/view/todo_homepage_list_item.dart';
import 'package:todo/view/todo_homepage_textfield.dart';
import 'package:todo/view/todo_homepage_title.dart';
import 'package:todo/viewmodel/todo_providers.dart';

class HomepageUI extends HookConsumerWidget {
  const HomepageUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(filteredTodos);
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
                        ref
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
