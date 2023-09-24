// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';


class New_Box extends StatelessWidget {
  final child;
  const New_Box({Key?key,required this.child}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade600,
                blurRadius: 15,
                offset: const Offset(5,5,),
                
              ),
             const BoxShadow(
                color: Colors.white,
                blurRadius: 15,
                offset: Offset(-5,-5,),
                
              ),
            ]

          ),
      child: Center(child: child,),
      );
  }
}