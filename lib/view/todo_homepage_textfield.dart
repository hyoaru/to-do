import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:todo/viewmodel/todo_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TodoTextField extends ConsumerWidget {
  const TodoTextField({
    Key? key,
    required this.todoTextController,
  }) : super(key: key);

  final TextEditingController todoTextController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: todoTextController,
      decoration: InputDecoration(
        labelText: 'What needs to be done?',
        contentPadding: EdgeInsets.only(top: 0.5.h, bottom: 0.5.h),

        // labelStyle: Textsty
      ),
      onSubmitted: (value) {
        ref.read(todoListProvider.notifier).todoAdd(value);
        todoTextController.clear();
      },
    );
  }
}
