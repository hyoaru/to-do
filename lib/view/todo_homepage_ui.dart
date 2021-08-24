import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sizer/sizer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
                height: 10.h,
              ),
              Column(
                children: [...todos.map((e) => Text(e.description))],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeTitle extends StatelessWidget {
  const HomeTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'todos',
          style: TextStyle(fontSize: 30.sp),
        ),
        Icon(
          Icons.check,
          size: 30.sp,
        ),
      ],
    );
  }
}

class TodoTextField extends StatelessWidget {
  const TodoTextField({
    Key? key,
    required this.todoTextController,
  }) : super(key: key);

  final TextEditingController todoTextController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: todoTextController,
      decoration: InputDecoration(
        labelText: 'What needs to be done?',
        contentPadding: EdgeInsets.only(top: 0.5.h, bottom: 0.5.h),

        // labelStyle: Textsty
      ),
      onSubmitted: (value) {
        //
      },
    );
  }
}
