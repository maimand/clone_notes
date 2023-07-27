import 'package:clone_notes/app/modules/home/controllers/home_controller.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotesList extends GetView<HomeController> {
  const NotesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirebaseAnimatedList(
        query: controller.firebaseService.fetchNoteStream(),
        itemBuilder: (context, snapshot, animation, index) {
          return Text(snapshot.value.toString());
        },
      defaultChild: const Center(
          child: SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(),
          ),
      ),
    );
  }
}
