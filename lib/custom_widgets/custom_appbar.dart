// import 'package:flutter/material.dart';
// //import 'package:get/get_utils/src/extensions/context_extensions.dart';
// import 'package:get/get.dart';

// class CustomAppBarr extends StatelessWidget implements PreferredSizeWidget{
//   const CustomAppBarr({
//     required this.toggleTheme,
//     required this.icon,
//     required this.iconColor,
//     //this.title,
//     Key? key,
//   }) : super(key: key);

//   final Function() toggleTheme;
//  // final String title;
//   final IconData icon;
//   final Color iconColor;

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: context.theme.backgroundColor,
//       elevation: 0,
//      // title: const Text("Todo"),
//      // centerTitle: true,
//     leading: IconButton(
//       onPressed: toggleTheme,
//         icon: Icon( icon,
//           // Get.isDarkMode ? Icons.wb_sunny_rounded :
//          // Icons.nightlight_round,
//       color: iconColor,
//       // Get.isDarkMode ? Colors.white : Colors.black,
//       ),
//     ),
//     actions: const [
//       CircleAvatar(
//         backgroundImage: AssetImage('images/profile.png'),

//       ),
//       SizedBox(width: 3,)
//     ],
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(60);
  
// }

