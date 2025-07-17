import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_app/constants/textstyle.dart';

import '../constants/colors.dart';
import '../controller/eyebuttoncontroller.dart';

class Mytextfield extends StatefulWidget {
  Mytextfield({
    super.key,
    required this.hinttext,
    required this.label,
    required this.ispassword,
    this.keytype = TextInputType.text,
    this.controller,
    this.onchange,
    this.labelisVisiible = true,
    this.icon = const Icon(CupertinoIcons.text_aligncenter),
  });
  final String hinttext;
  final String label;
  final bool ispassword;
  final TextInputType keytype;
  final void Function(String)? onchange;
  final TextEditingController? controller;
  final bool labelisVisiible;
  final Icon icon;

  @override
  State<Mytextfield> createState() => _MytextfieldState();
}

class _MytextfieldState extends State<Mytextfield> {
  final _eyeController = Get.put(EyebuttonController());
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 48,
          width: double.infinity,
          child: TextField(
            controller: widget.controller,
            onChanged: widget.onchange,
            cursorColor: Appcolor.mainColor,
            keyboardType: widget.keytype,
            obscureText: widget.ispassword ? isVisible : false,
            decoration: InputDecoration(
              prefixIcon: widget.icon,
              label: Text(widget.label),
              labelStyle: MyTextstyle.labelStyle,
              suffixIcon:
                  widget.ispassword
                      ? Obx(
                        () => IconButton(
                          onPressed: () {
                            _eyeController.changeVisibility();
                            setState(() {
                              isVisible = _eyeController.isvisible.value;
                            });
                          },
                          icon: Icon(
                            _eyeController.isvisible.value
                                ? CupertinoIcons.eye_slash
                                : CupertinoIcons.eye,
                          ),
                        ),
                      )
                      : null,
              hintText: widget.hinttext,
              hintStyle: MyTextstyle.hintStyle,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Appcolor.mainColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ADDGoldTextField extends StatefulWidget {
  ADDGoldTextField({
    super.key,
    required this.hinttext,
    required this.label,
    required this.ispassword,
    required this.keytype,
    this.onchange,
    this.controller,
    this.isSufficIcon = false,
    required this.icon,
    required this.Iconntap,
    this.readOnly = false
  });
  final String hinttext;
  final String label;
  final bool ispassword;
  final TextInputType keytype;
  final void Function(String)? onchange;
  final void Function() Iconntap;
  final TextEditingController? controller;
  final bool isSufficIcon;
  final Icon icon;
  final bool readOnly;

  @override
  State<ADDGoldTextField> createState() => _ADDGoldTextFieldState();
}

class _ADDGoldTextFieldState extends State<ADDGoldTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: widget.readOnly,
      onChanged: widget.onchange,
      controller: widget.controller,
      keyboardType: widget.keytype,
      decoration: InputDecoration(
        filled: widget.readOnly?true:false,
        fillColor: widget.readOnly?Colors.grey.shade200:null,
        label: Text(widget.label),
        labelStyle: MyTextstyle.labelStyle,
        suffixIcon:
            widget.isSufficIcon
                ? IconButton(onPressed: widget.Iconntap, icon: widget.icon)
                : null,
        hintText: widget.hinttext,
        hintStyle: MyTextstyle.hintStyle,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Appcolor.mainColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
