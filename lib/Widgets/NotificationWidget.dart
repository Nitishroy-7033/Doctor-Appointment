import 'package:flutter/material.dart';
import 'package:get/get.dart';

successMessage(String message) {
  return Get.rawSnackbar(
    messageText: Text(message, style: const TextStyle(color: Colors.white)),  
    backgroundColor: Colors.green,
    duration: const Duration(seconds: 5),
    icon: const Icon(Icons.check_circle, color: Colors.white),
    margin: const EdgeInsets.all(10),
    borderRadius: 10,
    borderColor: Colors.white,
    borderWidth: 2,

  );
}

errorMessage(String message) {
  return Get.rawSnackbar(
    messageText: Text(message, style: const TextStyle(color: Colors.white)),  
    backgroundColor: Colors.red,
    duration: const Duration(seconds: 5),
    icon: const Icon(Icons.error, color: Colors.white),
    margin: const EdgeInsets.all(10),
    borderRadius: 10,
    borderColor: Colors.red,
    borderWidth: 2,

  );
}
