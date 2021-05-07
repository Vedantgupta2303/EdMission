import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  TextEditingController textEditingController;
  Function(String) validator;
  bool isPasswordField;
  Color color;
  TextInputType textInputType;
  bool isDisabled;
  InputTextField(
      {required this.color,
      required this.isPasswordField,
      this.isDisabled = false,
      this.textInputType = TextInputType.emailAddress,
      required this.validator,
      required this.textEditingController});
  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return ClayContainer(
        spread: 0.5,
        borderRadius: 15,
        color: widget.color,
        child: widget.isPasswordField
            ? PasswordTextFormField(
                validator: widget.validator,
                textEditingController: widget.textEditingController,
                color: widget.color,
                isDisabled: widget.isDisabled,
              )
            : NormalTextFormField(
                textInputType: widget.textInputType,
                validator: widget.validator,
                textEditingController: widget.textEditingController,
              ));
  }
}

class NormalTextFormField extends StatelessWidget {
  Function(String) validator;
  TextEditingController textEditingController;
  TextInputType textInputType;

  NormalTextFormField(
      {required this.textEditingController,
      required this.textInputType,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator: (value) => validator(value!),
      keyboardType: textInputType,
      style: TextStyle(
          color: Color(0xff6683AB),
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal),
      cursorRadius: Radius.circular(4),
      cursorColor: Color(0xff2F4858),
      cursorHeight: 20,
      decoration: InputDecoration(
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: BorderSide.none,
        ),
        fillColor: Colors.black,
      ),
    );
  }
}

class PasswordTextFormField extends StatefulWidget {
  bool isDisabled;
  Function(String) validator;
  TextEditingController textEditingController;
  Color color;
  PasswordTextFormField(
      {required this.color,
      this.isDisabled = false,
      required this.textEditingController,
      required this.validator});
  @override
  _PasswordTextFormFieldState createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(right: 50),
          child: TextFormField(
            enabled: !widget.isDisabled,
            validator: (value) => widget.validator(value!),
            controller: widget.textEditingController,
            keyboardType: TextInputType.visiblePassword,
            obscuringCharacter: '*',
            obscureText: widget.isDisabled ? false : !showPassword,
            style: TextStyle(
                color: Color(0xff6683AB),
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal),
            cursorRadius: Radius.circular(4),
            cursorColor: Color(0xff2F4858),
            cursorHeight: 20,
            decoration: InputDecoration(
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.black,
            ),
          ),
        ),
        widget.isDisabled
            ? Container()
            : Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  child: ClayContainer(
                    color: Colors.white,
                    parentColor: widget.color,
                    depth: 2,
                    width: 40,
                    height: 40,
                    borderRadius: 15,
                    child: Center(
                      child: !showPassword
                          ? Text(
                              '?',
                              style: TextStyle(fontSize: 18),
                            )
                          : Icon(Icons.remove_red_eye_outlined),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
