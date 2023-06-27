import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MenuApp());
}

class MenuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterTts flutterTts = FlutterTts();
  Database? _database;
  List<MenuItem> _menuItems = [];

  @override
  void initState() {
    super.initState();
    openDatabaseAndLoadItems();
  }

  Future<void> openDatabaseAndLoadItems() async {
    _database = await openDatabase(
      'menu_database.db',
      version: 1,
      onCreate: (Database db, int version) {
        db.execute(
          'CREATE TABLE menu_items (id INTEGER PRIMARY KEY, name TEXT, price REAL)',
        );
      },
    );
    loadMenuItems();
  }

  Future<void> loadMenuItems() async {
    final List<Map<String, dynamic>> maps = await _database!.query('menu_items');
    setState(() {
      _menuItems = List.generate(maps.length, (i) {
        return MenuItem(
          id: maps[i]['id'],
          name: maps[i]['name'],
          price: maps[i]['price'],
        );
      });
    });
  }

  Future<void> addMenuItem(String name, double price) async {
    final menuItem = MenuItem(name: name, price: price);
    await _database!.insert(
      'menu_items',
      menuItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    loadMenuItems();
  }

  Future<void> updateMenuItem(MenuItem menuItem) async {
    await _database!.update(
      'menu_items',
      menuItem.toMap(),
      where: 'id = ?',
      whereArgs: [menuItem.id],
    );
    loadMenuItems();
  }

  Future<void> deleteMenuItem(int id) async {
    await _database!.delete(
      'menu_items',
      where: 'id = ?',
      whereArgs: [id],
    );
    loadMenuItems();
  }

  void speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(text);
  }

  void navigateToMenuApp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MenuApp()),
    );
  }

  Future<void> takePhoto() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      // Process the image (if needed)
      // For blind functionality, you can skip image processing

      navigateToMenuApp();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: takePhoto,
          child: Text('Take Photo'),
        ),
      ),
    );
  }
}

class MenuItem {
  final int? id;
  final String name;
  final double price;

  MenuItem({this.id, required this.name, required this.price});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'price': price};
  }
}