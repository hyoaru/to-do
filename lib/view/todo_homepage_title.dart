import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
