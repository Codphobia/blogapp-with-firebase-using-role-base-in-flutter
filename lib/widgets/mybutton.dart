import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  late final title;
  late final VoidCallback onPressed;

  MyButton({Key? key, required this.title, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(10),

      child: MaterialButton(
minWidth: double.infinity,
        onPressed: onPressed,
        child: Text(
          title.toString(),
          style: TextStyle(color: Colors.white),

        ),
        color:  Colors.pink.shade300,
      ),
    );
  }
}
