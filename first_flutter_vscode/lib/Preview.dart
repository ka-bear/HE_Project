import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'dart:io';

class PreviewPage extends StatelessWidget {
  const PreviewPage({Key? key, required this.picture}) : super(key: key);

  final XFile picture;
  @override
  Widget build(BuildContext context) {
    String detected = "e";
    return Scaffold(
      appBar: AppBar(title: const Text('Preview Page')),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.file(File(picture.path), fit: BoxFit.cover, width: 750),
          const SizedBox(height: 24),
          Text("Detected: "+detected),
          Text("Category: ")
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            try{
              globals.menu[detected]+=1;
            }catch(e){
              
            }
          }, 
          tooltip: 'Complete',
          child: const Icon(Icons.check),
          elevation:
              8),
    );
  }
}