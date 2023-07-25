import 'package:clone_notes/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: controller.onAddNote,
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: controller.controller,
                onChanged: (val) => controller.onSearchNote(),
                decoration:
                    const InputDecoration(prefixIcon: Icon(Icons.search)),
              ),
              Expanded(
                child: Obx(
                  () => controller.noteList.isNotEmpty
                      ? ListView.builder(
                          itemCount: controller.noteList.length,
                          itemBuilder: (context, index) {
                            final element = controller.noteList.elementAt(index);
                            return Slidable(
                                key: const ValueKey(0),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  extentRatio: 0.25,
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        controller.onDeleteNote(element);
                                      },
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete_outline,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  onTap: () => controller.editNote(element),
                                  title: Text(element.title),
                                  subtitle: Text(element.description),
                                ));
                          },
                        )
                      : const Center(
                          child: Text(
                            'No notes',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black12),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
