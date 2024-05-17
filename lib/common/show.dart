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

class AddNewTask extends ConsumerStatefulWidget {
  AddNewTask({super.key});

  @override
  _AddNewTaskState createState() => _AddNewTaskState();
}

class _AddNewTaskState extends ConsumerState<AddNewTask> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dateProv = ref.watch(dateProvider);

    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'New Task To Do',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Divider(
            thickness: 1.2,
            color: Colors.grey,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Title Task',
                style: AppStyle.headingOne,
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Add a title for   the new task',
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 10),
              const Text(
                'Description',
                style: AppStyle.headingOne,
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Description',
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 10),
              const Text(
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
                        lastDate: DateTime(2030),
                      );
                      if (getValue != null) {
                        final format = DateFormat.yMEd();
                        ref.read(dateProvider.notifier)
                            .update((state) => format.format(getValue));
                      }
                    },
                  ),
                  const SizedBox(width: 10),
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
                        ref.read(timeProvider.notifier)
                            .update((state) => getTime.format(context));
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade200,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade200,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        final getRadioValue = ref.read(radioProvider);
                        String category = '';
                        switch (getRadioValue) {
                          case 1:
                            category = 'Learning';
                            break;
                          case 2:
                            category = 'Working';
                            break;
                          case 3:
                            category = 'General';
                            break;
                        }
                        ref.read(serviceProvider).addNewTask(
                          TodoModel(
                            titleTask: titleController.text,
                            description: descriptionController.text,
                            Category: category,
                            dateTask: ref.read(dateProvider),
                            timeTask: ref.read(timeProvider),
                            isDone: false,
                          ),
                        );

                        titleController.clear();
                        descriptionController.clear();
                        ref.read(radioProvider.notifier).update((state) => 0);
                        Navigator.pop(context);
                      },
                      child: const Text('Create'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
