import 'package:flutter/material.dart';

class tile extends StatelessWidget {
  final Color? color;
  final String? text;
  const tile({super.key,required this.color,required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              color:color, borderRadius: BorderRadius.circular(5)),
        ),
        const SizedBox(width: 20,),
        Text( text! ,style: const TextStyle(color: Colors.black , fontWeight: FontWeight.bold , fontSize: 22),),
      ],
    );
  }
}
