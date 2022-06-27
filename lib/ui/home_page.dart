import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_getx/controllers/task_controller.dart';
import 'package:todo_getx/custom_widgets/add_task_button.dart';
import 'package:todo_getx/custom_widgets/task_tile.dart';
import 'package:todo_getx/modals/tasks.dart';
//import 'package:todo_getx/custom_widgets/custom_appbar.dart';
import 'package:todo_getx/services/notification_services.dart';
import 'package:todo_getx/services/theme_services.dart';
import 'package:todo_getx/ui/add_task_page.dart';
import 'package:todo_getx/ui/theme.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TaskController showController = Get.put(TaskController());
  DateTime selectedDate = DateTime.now();
  // ignore: prefer_typing_uninitialized_variables
  var notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: context.theme.backgroundColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              ThemeServices().switchTheme();
              notifyHelper.displayNotification(
                title: "Theme Changed",
                body: Get.isDarkMode
                    ? 'Activated light Mode'
                    : 'Activated dark Mode',
              );
             // notifyHelper.scheduledNotification();
            },
            icon: Icon(
              Get.isDarkMode ? Icons.wb_sunny_rounded : Icons.nightlight_round,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          actions: const [
            CircleAvatar(
              backgroundImage: AssetImage('images/profile.png'),
            ),
            SizedBox(
              width: 3,
            )
          ]
          // toggleTheme: () {
          //   ThemeServices().switchTheme();
          //   notifyHelper.displayNotification(
          //     title: "Theme Changed",
          //     body:
          //         Get.isDarkMode ? 'Activated light Mode' : 'Activated dark Mode',
          //   );
          //   notifyHelper.scheduledNotification();
          // },
          //  icon:  Get.isDarkMode ? Icons.wb_sunny_rounded :
          //   Icons.nightlight_round,
          //   iconColor: Get.isDarkMode ? Colors.white : Colors.black,
          ),
      body: Column(
        //
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMMMMd().format(DateTime.now()),
                        style: subHeadingTextStyle,
                      ),
                      Text(
                        "Today",
                        style: headingTextStyle,
                      ),
                    ],
                  ),
                ),
                AddTaskButton(
                    label: '+ Add Task',
                    onTap: () async {
                      await Get.to(() => const AddTaskPage());
                      showController.getTasks();
                    }),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: primaryClr,
              selectedTextColor: whiteColor,
              dateTextStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
              onDateChange: (date) {
                setState(() {
                  selectedDate = date;
                });
                
              },
            ),
          ),
          GetBuilder<TaskController>(
            init: TaskController(),
            initState: (_) {},
            builder: (_) {
          return ListView.builder(
            shrinkWrap: true,
              itemCount: showController.taskList.length,
              itemBuilder: (_,index) {
                Task task = showController.taskList[index];
                if (task.repeat == 'daily') {
                  DateTime date = DateFormat.jm().parse(task.startTime.toString());
                  var myTime = DateFormat("HH:mm").format(date);
                  // ignore: avoid_print
                  print(myTime);
                  notifyHelper.scheduledNotification(
                    int.parse(myTime.toString().split(":")[0]),
                    int.parse(myTime.toString().split(":")[1]),
                    task 

                  );
                  return  AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(child: Row(children: [
                      GestureDetector(
                        onTap: (){
                          showBottomSheet(context, task);
                        },
                        child: TaskTile(task),
                      )
                    ],),),),);
                }
                if (task.date == DateFormat.yMd().format(selectedDate)){
                  return  AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(child: Row(children: [
                      GestureDetector(
                        onTap: (){
                          showBottomSheet(context, task);
                        },
                        child: TaskTile(task),
                      )
                    ],),),),);
                }else{
                    return Container();
                }
                // return  AnimationConfiguration.staggeredList(
                //   position: index,
                //   child: SlideAnimation(
                //     child: FadeInAnimation(child: Row(children: [
                //       GestureDetector(
                //         onTap: (){
                //           showBottomSheet(context, task);
                //         },
                //         child: TaskTile(task),
                //       )
                //     ],),),),);
                
              });
            },
          )
        ],
      ),
    );
  }

  showBottomSheet(BuildContext context,Task task) {
      Get.bottomSheet(
        Container(
          padding: const EdgeInsetsDirectional.only(top: 4),
          height: task.isCompleted==1?
          MediaQuery.of(context).size.height * 0.24:
          MediaQuery.of(context).size.height * 0.32,
          decoration: BoxDecoration(
            color: Get.isDarkMode?darkGrayClr:whiteColor,

          ),
          child: Column(children: [
            Container(
              width:120,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300],

              ),
            ),
            const Spacer(),
            task.isCompleted==1?Container():bottomSheetButton(
              label: 'Task Completed',
              onTap: (){
                showController.markTaskCompleted(task.id!);
                Get.back();
              },
              clr: primaryClr,
              context: context,

            ),
            
            bottomSheetButton(
              label: 'Delete Task',
              onTap: (){
                showController.delete(task);
               // showController.getTasks();
                Get.back();
              },
              clr: Colors.red[300]!,
              context: context,

            ),
            const SizedBox(height: 20,),
            bottomSheetButton(
              label: 'Close',
              onTap: (){
                Get.back();
              },
              isClose: true,
              clr: Colors.white,
              context: context,

            ),
            const SizedBox(height: 10,),
          ],),
        )
      );
  }
  bottomSheetButton({
    required String label,
    required Function() onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        
        decoration: BoxDecoration(
          color: isClose == true?Colors.transparent:clr,
          border: Border.all(
            width: 2,
            color: isClose==true?Get.isDarkMode?Colors.grey[600]!:Colors.grey[300]!:clr,
          ),
          borderRadius: BorderRadius.circular(20),

        ),
        child: Center(child: Text(label,style: isClose?titleTextStyle:titleTextStyle.copyWith(color: Colors.white),),),
      ),

    );
  }
}
