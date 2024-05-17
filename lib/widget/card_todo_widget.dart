import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/todo_model.dart';
import '../provider/service_provider.dart';

class CardTodoListWidget extends ConsumerWidget {
  const CardTodoListWidget({
    Key? key,
    required this.getIndex,
  }) : super(key: key);

  final int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchDataProvider);
    return todoData.when(
      data: (todoData) {
        Color categoryColor = Colors.white;

        final getCategory = todoData[getIndex].Category;
        switch(getCategory){
          case 'Learning' :
            categoryColor = Colors.green;
            break;
          case 'Working':
            categoryColor = Colors.orangeAccent;
            break;
          case 'General' :
            categoryColor = Colors.blue;
            break;
        }
        return Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                color: categoryColor,
                width: 30,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: IconButton(icon: Icon(CupertinoIcons.delete), onPressed: () => ref.read(serviceProvider).deleteTask(todoData[getIndex].docID)),
                        title: Text(
                          todoData[getIndex].titleTask,
                          maxLines: 1,
                          style: TextStyle(
                              decoration: todoData[getIndex].isDone ? TextDecoration.lineThrough : null
                          ),
                        ),
                        subtitle: Text(
                          todoData[getIndex].description,
                          maxLines: 1,
                          style: TextStyle(
                              decoration: todoData[getIndex].isDone ? TextDecoration.lineThrough : null
                          ),
                        ),
                        trailing: Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            activeColor: Colors.blue.shade800,
                            shape: const CircleBorder(),
                            value: todoData[getIndex].isDone,
                            onChanged: (value) => ref.read(serviceProvider).updateTask(todoData[getIndex].docID, value),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -12),
                        child: Container(
                          child: Column(
                            children: [
                              Divider(
                                thickness: 1.5,
                                color: Colors.grey.shade500,
                              ),
                              Row(
                                children: [
                                  Text(todoData[getIndex].dateTask),
                                  const SizedBox(width: 15),
                                  Text(todoData[getIndex].timeTask),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
