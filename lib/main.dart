import 'package:clone_notes/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';


void main() {
  runApp(
    GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
        title: 'Application',
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
