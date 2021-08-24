import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

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
