import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_project/provider/service_provider.dart';

import '../common/show.dart';
import '../widget/card_todo_widget.dart';

class HomePage extends ConsumerWidget {
  HomePage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchDataProvider);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.amber.shade200,
            radius: 25,
            child: Image.asset('Images/profile.png'), // Check image path
          ),
          title: const Text(
            'Hello I\'m',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          subtitle: const Text(
            'Sarra Jbeli',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.calendar),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.bell),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today\'s tasks',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text('Wednesday, 11 May'),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        context: context,
                        builder: (context) => AddNewTask(),
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.add),
                        Text('New Task'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              ListView.builder(
                  itemCount: todoData.value!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
               CardTodoListWidget(getIndex: index),)
            ],
          ),
        ),
      ),
    );
  }
}