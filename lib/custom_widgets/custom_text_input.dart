import 'package:flutter/material.dart';
import 'package:todo_getx/ui/theme.dart';
import 'package:get/get.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput(
      {this.title,
      this.hint,
      this.textEditingController,
      this.widget,
     // this.icon,
      Key? key})
      : super(key: key);
  final String? title;
  final String? hint;
  final TextEditingController? textEditingController;
  final Widget? widget;
  //final Function()? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
     // padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: titleTextStyle,
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(top: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
            height: 52,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextFormField(
              
              autofocus: false,
              cursorColor: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
              controller: textEditingController,
              style: subTitleTextStyle,
              readOnly: widget==null?false:true,
              decoration: InputDecoration(
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: context.theme.backgroundColor,
                  ),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: context.theme.backgroundColor,
                  ),
                ),
                suffixIcon: widget,
                hintText: hint,
                hintStyle: subTitleTextStyle,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: context.theme.backgroundColor,
                  ),
                ),

              ),
            ),
          )
        ],
      ),
    );
  }
}
