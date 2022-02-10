import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/helper.dart';

// ignore: must_be_immutable
class CustomTextfield extends StatelessWidget {
  CustomTextfield({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.title,
    required this.fillColor,
    required this.onSubmit,
    this.showTitle = false,
    this.maxLines = 1,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String title;
  final Color fillColor;
  final Function(String text) onSubmit;
  bool showTitle;
  int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showTitle
            ? Text(
                title,
                style: Theme.of(context).textTheme.subtitle2,
              )
            : const SizedBox(),
        smallSpacing(),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
              filled: true,
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              fillColor: fillColor),
          onFieldSubmitted: (String searchText) {
            onSubmit(searchText);
          },
        ),
      ],
    );
  }
}
