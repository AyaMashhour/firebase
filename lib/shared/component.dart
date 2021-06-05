import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void navigateTo(context, Widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));
}

void navigateAndFinish(context, Widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => Widget),
    (Route<dynamic> route) => false,
  );
}

bool isUpperCase = true;

Widget defaultBottom({
  String text,
  Function function,
}) =>
    Container(
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue,
      ),
      width: double.infinity,
      child: TextButton(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          onPressed: function,
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          )),
    );

Widget defaultAppBar(
    {@required BuildContext context, String title, List<Widget> actions}) {
  return AppBar(
      title: Text(title),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios_outlined,
          size: 30.0,
          color: Colors.black,
        ),

      ),actions: actions,);
}

Widget defaultTextFromField({
  TextEditingController controller,
  Function validator,
  IconData prefixIcon,
  String labelText,
  TextInputType type,
  IconData suffixIcon,
  TextStyle style,

}) =>
    TextFormField(
      style: style,
      controller: controller,
      // ignore: missing_return
      validator:validator,
      keyboardType: type,
      decoration: InputDecoration(
          suffixIcon: Icon(suffixIcon),
          prefixIcon: Icon(prefixIcon),
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 15.0,
                fontFamily: 'Play'
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 5.0),
          )),
    );

Widget defaultTextBottom({String text, Function function}) => TextButton(
      onPressed: function,
      child: Text(text.toUpperCase(), style: TextStyle(color: Colors.blue)),
    );
