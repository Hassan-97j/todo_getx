
import 'package:flutter/material.dart';
//import 'package:todo_getx/custom_widgets/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_getx/controllers/task_controller.dart';
import 'package:todo_getx/custom_widgets/add_task_button.dart';
import 'package:todo_getx/custom_widgets/custom_text_input.dart';
import 'package:todo_getx/modals/tasks.dart';
import 'package:todo_getx/ui/theme.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController taskController = Get.put(TaskController());
  DateTime selectedDate = DateTime.now();
  String? endTime = '9:30 PM';
  String? startTime = DateFormat('hh:mm:a').format(DateTime.now()).toString();
  int? selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String? selectedRepeat = 'none';
  List<String> repeatList = ['none', 'daily', 'weekly', 'monthly'];
  int selectedCollor = 0;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: context.theme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
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
        ],
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Text(
              'Add Task',
              style: headingTextStyle,
            ),
            CustomTextInput(
              title: 'title',
              hint: 'Enter title here',
              textEditingController: titleController,
            ),
            CustomTextInput(
              title: 'note',
              hint: 'Enter note here',
              textEditingController: noteController,
            ),
            CustomTextInput(
              title: 'date',
              hint: DateFormat.yMd().format(selectedDate),
              textEditingController: dateController,
              widget: IconButton(
                onPressed: () {
                  getDateFromUser();
                },
                icon: const Icon(
                  Icons.calendar_view_month_outlined,
                  color: Colors.grey,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextInput(
                    title: 'start time',
                    hint: startTime,
                    widget: IconButton(
                      onPressed: () {
                        getTimeFromUser(isStartTime: true);
                      },
                      icon: const Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                // const SizedBox(
                //   width: 12,
                // ),
                Expanded(
                  child: CustomTextInput(
                    title: 'end time',
                    hint: endTime,
                    widget: IconButton(
                      onPressed: () {
                        getTimeFromUser(isStartTime: false);
                      },
                      icon: const Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            CustomTextInput(
              title: 'remind',
              hint: '$selectedRemind minutes early',
              widget: DropdownButton(
                icon: const Icon(Icons.keyboard_arrow_down, 
                color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleTextStyle,
                items: remindList.map<DropdownMenuItem<String>>((int value) => 
                DropdownMenuItem<String>(
                  value: value.toString(),
                  child: Text(value.toString()),)
                
                ).toList(),
                onChanged: (String? newValue){
                  setState(() {
                    selectedRemind = int.parse(newValue!) ;
                  });
                }),
            ),
            CustomTextInput(
              title: 'repaet',
              hint: selectedRepeat,
              widget: DropdownButton(
                icon: const Icon(Icons.keyboard_arrow_down, 
                color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleTextStyle,
                items: repeatList.map<DropdownMenuItem<String>>((String? value) => 
                DropdownMenuItem<String>(
                  value: value,
                  child: Text(value! ,style: const TextStyle(color: Colors.grey)),),
                
                ).toList(),
                onChanged: (String? newValue){
                  setState(() {
                    selectedRepeat = newValue! ;
                  });
                }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Text('color',style: titleTextStyle,),
                 const SizedBox(height: 6,),
                 Wrap(children: List.generate(3, (int index) {
                   return  GestureDetector(
                     onTap: (){
                       setState(() {
                         selectedCollor = index;
                       });
                       
                     },
                     child: Padding(
                       padding: const EdgeInsets.only(right:8.0),
                       child:  CircleAvatar(
                         radius: 14,
                         backgroundColor: index == 0 ? primaryClr : index == 1 ? pinkClr : yellowishClr,
                                child: selectedCollor == index ? const Icon(
                                  Icons.done,
                                  color: Colors.white,
                                  size: 16,
                                ) : Container()
                       ),
                     ),
                   );
                 }), ),
                    ],
                  ),
                  AddTaskButton(
                    label: 'Create Task',
                    onTap: () {
                      validateDate();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2030));
    if (pickerDate != null) {
      setState(() {
        selectedDate = pickerDate;
       // dateController.text = selectedDate.toString();
      });
     // selectedDate = pickerDate;
    } else {
      Get.dialog(
        const Text('Select Date '),
      );
    }
  }

  getTimeFromUser({required bool isStartTime}) async {
    var pickerTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(startTime!.split(':')[0]),
        minute: int.parse(startTime!.split(':')[1].split(' ')[0]),
      ),
    );
    String? formattedTime = pickerTime?.format(context);
    if (pickerTime == null) {
      // ignore: avoid_print
      print('time cancelled');
    } else if (isStartTime == true) {
      setState(() {
        startTime = formattedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        endTime = formattedTime;
      });
    }
  }

  validateDate(){
    if(titleController.text.isNotEmpty && noteController.text.isNotEmpty){
      addTaskToDB();
      Get.back();
    }else if(titleController.text.isEmpty && noteController.text.isEmpty) {
      Get.snackbar(
        'Required', 
        "All Fields are required",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: pinkClr,
        icon: const Icon(Icons.warning_amber_outlined)
      );
    }
  }

  addTaskToDB() async{
     int value = await taskController.addTask(
      task: Task(
       title: titleController.text,
       note: noteController.text,
       isCompleted: 0,
       date:// dateController.text,
       DateFormat.yMd().format(selectedDate),
       startTime: startTime,
       endTime: endTime,
       color: selectedCollor,
       remind: selectedRemind,
       repeat: selectedRepeat,
    )
    );
    // ignore: avoid_print
    print('my id is''$value');
  }
}
