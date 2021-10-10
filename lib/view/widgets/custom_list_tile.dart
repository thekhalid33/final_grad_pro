import 'package:admin_grad_pro/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String image;
  final String text;
  final Function onPress;

  CustomListTile({
    @required this.text,
    @required this.image,
    @required this.onPress,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: TextButton(
        onPressed: onPress,
        child: ListTile(
          title: CustomText(
            text: text,
          ),
          leading: Image.asset(
            image,
            height: 50,
            width: 50,
          ),
          trailing: Icon(
            Icons.navigate_next,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
