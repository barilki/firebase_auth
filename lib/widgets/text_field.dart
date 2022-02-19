import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFill extends StatelessWidget {
  String? labelText;
  TextEditingController? textController;

  TextFill({this.labelText, this.textController});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        child: TextFormField(
          controller: textController,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            labelText: labelText,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
      ),
    );
  }
}
