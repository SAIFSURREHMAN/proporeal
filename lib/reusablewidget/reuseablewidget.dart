import 'package:flutter/material.dart';

TextField reUsableTF(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    style: const TextStyle(color: Colors.white, fontSize: 18),
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white,
      ),
      labelText: text,
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 245, 246, 248))),
      labelStyle: const TextStyle(color: Colors.white, fontSize: 18),
    ),
    keyboardType:
        isPasswordType ? TextInputType.visiblePassword : TextInputType.name,
  );
}
