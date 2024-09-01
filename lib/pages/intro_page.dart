
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const introPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("I N TR R O P A G E ")),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            //go to home
          }, child: child,
          child: const Text("Go To Home")),
      )
    );
  }
}