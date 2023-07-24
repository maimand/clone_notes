import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

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
                  () => controller.notes.isNotEmpty
                      ? Column(
                          children: controller.notes
                              .map((element) => ListTile(
                                    onTap: () =>
                                        controller.onUpdateNote(element),
                                    title: Text(element.title),
                                    subtitle: Text(element.content),
                                  ))
                              .toList(),
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
