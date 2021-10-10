import 'package:chat/shared/components/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Widget buildTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData prefixIcon,
  bool isSecure = false,
  IconData? suffixIcon,
  VoidCallback? onPressedSuffix,
  VoidCallback? onTap,
  Function(String)? onChanged,
  String? Function(String?)? validator,
}) {
  return TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isSecure,
      decoration: InputDecoration(
        label: Text(
          label,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          borderSide: BorderSide(width: 1.5, color: Colors.black38),
        ),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: (suffixIcon == null)
            ? null
            : IconButton(
                onPressed: onPressedSuffix,
                icon: Icon(suffixIcon),
              ),
      ),
      cursorColor: mainColor,
      onTap: onTap,
      style: const TextStyle(color: mainColor),
      onChanged: onChanged,
      validator: validator);
}

Widget buildMaterialButton(context,
    {double? width, String? label, VoidCallback? onPressed, Color? color}) {
  return Container(
    width: width,
    decoration: BoxDecoration(
        color: mainColor, borderRadius: BorderRadius.circular(50.0)),
    child: MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      height: 50.0,
      child: Text(
        label!,
        style: Theme.of(context)
            .textTheme
            .headline1!
            .copyWith(fontSize: 28.0, color: color),
      ),
      onPressed: onPressed,
    ),
  );
}

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}


void pushAndRemoveUntilPageTo(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (Route<dynamic> route) => false,
  );
}

AppBar buildDefaultAppBar({
 required BuildContext context,
  String? title,
  IconButton? leading,
  List<Widget>? actions
}){
  return AppBar(
    title: Text(
      '$title',
        style: Theme.of(context).textTheme.headline2,
    ),
    actions: actions,
    titleSpacing: .4,
    leading: leading,
  );
}
