import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final title;
  final VoidCallback onPressed;

  const MyButton({Key? key, required this.title, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        minWidth: double.infinity,
        onPressed: onPressed,
        // ignore: sort_child_properties_last
        child: Text(
          title.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        color: Colors.pink.shade300,
      ),
    );
  }
}
