import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:todo_project/constants/app_style.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_project/model/todo_model.dart';
import 'package:todo_project/provider/service_provider.dart';
import '../provider/dateTime_provider.dart';
import '../provider/radio_provider.dart';
import '../widget/DateTime_Widget.dart';
import '../widget/radio_widget.dart';
import '../widget/textField_widget.dart';

class AddNewTask extends ConsumerWidget {
  AddNewTask({
    super.key,
  });

  final titleController= TextEditingController();
  final descriptionController= TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateProv = ref.watch(dateProvider);
    return Container(
      padding: EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'New Task To Do',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Divider(
            thickness: 1.2,
            color: Colors.grey,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title Task',
                style: AppStyle.headingOne,
              ),
              SizedBox(height: 6),
              TextFieldWidget(
                  maxLine: 1, hintText: 'Add a title for the new task', txtController: titleController, ),
              SizedBox(height: 10),
              Text(
                'Description',
                style: AppStyle.headingOne,
              ),
              SizedBox(height: 6),
              TextFieldWidget(maxLine: 5, hintText: 'Description', txtController: descriptionController, ),
              SizedBox(height: 10),
              Text(
                'Category',
                style: AppStyle.headingOne,
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioWidget(
                      categColor: Colors.greenAccent,
                      titleRadio: 'LRN',
                      valueInput: 1,
                      onChangeValue: () =>
                          ref.read(radioProvider.notifier).update((state) => 1),
                    ),
                  ),
                  Expanded(
                    child: RadioWidget(
                      categColor: Colors.orangeAccent,
                      titleRadio: 'WRK',
                      valueInput: 2,
                      onChangeValue: () =>
                          ref.read(radioProvider.notifier).update((state) => 2),
                    ),
                  ),
                  Expanded(
                    child: RadioWidget(
                      categColor: Colors.blueAccent,
                      titleRadio: 'GEN',
                      valueInput: 3,
                      onChangeValue: () =>
                          ref.read(radioProvider.notifier).update((state) => 3),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DateTimeWidget(
                    titleText: 'Date',
                    valueText: dateProv,
                    iconSelection: CupertinoIcons.calendar,
                    onTap: () async {
                      final getValue = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2030));
                      if (getValue != null) {
                        final format = DateFormat.yMEd();
                        ref
                            .read(dateProvider.notifier)
                            .update((state) => format.format(getValue));
                      }
                    },
                  ),
                  SizedBox(width: 10),
                  DateTimeWidget(
                    titleText: 'Time',
                    valueText: ref.watch(timeProvider),
                    iconSelection: CupertinoIcons.clock,
                    onTap: () async {
                      final getTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (getTime != null) {
                        ref
                            .read(timeProvider.notifier)
                            .update((state) => getTime.format(context));
                      }
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade200,
                            foregroundColor: Colors.white),
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel'),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade200,
                            foregroundColor: Colors.white),
                        onPressed: () {

                          final getRadioValue = ref.read(radioProvider);
                          String Category ='';
                          switch (getRadioValue){
                            case 1:
                              Category = 'Learning';
                              break;
                            case 2:
                              Category ='Working';
                              break;
                            case 3:
                              Category= 'General';
                              break;

                          }
                          ref.read(serviceProvider).addNewTask(
                              TodoModel(titleTask: titleController.text,
                                  description: descriptionController.text,
                                  Category: Category,
                                  dateTask: ref.read(dateProvider),
                                  timeTask: ref.read(timeProvider),
                                  isDone: false,),
                          );

                      titleController.clear();
                      descriptionController.clear();
                      ref.read(radioProvider.notifier).update((state) => 0);
                      Navigator.pop(context);
                        },
                        child: Text('Create'),
                      )),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
