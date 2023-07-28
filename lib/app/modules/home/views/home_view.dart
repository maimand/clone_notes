import 'package:clone_notes/app/data/services/auth_service.dart';
import 'package:clone_notes/app/modules/home/controllers/home_controller.dart';
import 'package:clone_notes/app/modules/home/widgets/note_item.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your notes', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
          centerTitle: false,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Get.find<AuthService>().logOut();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            )
          ],
        ),
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
              const SizedBox(height: 16),
              Expanded(
                child: Obx(
                  () => controller.noteList.isNotEmpty
                      ? ListView.separated(
                          itemCount: controller.noteList.length,
                          itemBuilder: (context, index) {
                            final element =
                                controller.noteList.elementAt(index);
                            return NoteItem(
                              note: element,
                              onEdit: () {controller.editNote(element);},
                              onDelete: () {
                                controller.onDeleteNote(element);
                              },
                            );
                          }, separatorBuilder: (BuildContext context, int index) {
                            return const Padding(
                              padding:  EdgeInsets.symmetric(vertical: 12),
                              child: Divider(height: 1, color: Colors.grey,),
                            );
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
