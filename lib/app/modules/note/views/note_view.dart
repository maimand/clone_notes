import 'package:clone_notes/app/modules/note/controllers/note_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class NoteView extends GetView<NoteController> {
  const NoteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: BackButton(
          onPressed: () {
            Get.back();
            controller.onBackHome();
          },
        ),
        actions: [
          if (!controller.isNewNote)
            IconButton(
              onPressed: controller.onDeleteNote,
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            )
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            controller: controller.titleController,
            focusNode: controller.titleNode,
            onChanged: (val) => controller.onTitleChange(),
            onEditingComplete: controller.onSubmitTitle,
            onFieldSubmitted: (val) => controller.onSubmitTitle(),
          ),
          TextFormField(
            controller: controller.contentController,
            focusNode: controller.contentNode,
            onChanged: (val) => controller.onContentChange(),
          ),
        ],
      ),
    );
  }
}
