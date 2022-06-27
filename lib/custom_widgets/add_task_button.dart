import 'package:flutter/material.dart';
import 'package:todo_getx/ui/theme.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({ 
    required this.label,
    required this.onTap,
    Key? key }) : super(key: key);

  final String label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(

        height: 60,
        width: MediaQuery.of(context).size.width * 0.28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryClr,
        ),
        child: Center(child: Text(label,style: const TextStyle(color: Colors.white,fontSize: 18),),),
      ),
    );
  }
}