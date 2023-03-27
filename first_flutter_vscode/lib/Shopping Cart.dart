import 'package:flutter/material.dart';
import 'globals.dart' as globals;

void remove_from_menu(String item){
  if (globals.menu.containsKey(item)){
    globals.menu[item]-=1;
  }if (globals.menu[item]==0){
    globals.menu.removeWhere((key, value) => key == item);
  }
}

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the ShoppingCartPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  for (String key in globals.menu.keys) ListTile(
                    title: Text(
                      '${globals.menu[key]}x ${key}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: IconButton(
                      onPressed: (){
                        remove_from_menu(key);
                        _incrementCounter();
                      }, 
                      icon: const Icon(
                        Icons.cancel,
                        color: Color(0xFF303030),
                        size: 20,
                    ),
                    ),
                    tileColor: const Color(0xFFF5F5F5),
                    dense: false,
                  )
                  
                  /*ListTile(
                    title: Text(
                      '1 Beef Wellington',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: const Icon(
                      Icons.cancel,
                      color: Color(0xFF303030),
                      size: 20,
                    ),
                    tileColor: const Color(0xFFF5F5F5),
                    dense: false,
                  ),
                  ListTile(
                    title: Text(
                      '1 Lamb Sauce',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: const Icon(
                      Icons.cancel,
                      color: Color(0xFF303030),
                      size: 20,
                    ),
                    tileColor: const Color(0xFFF5F5F5),
                    dense: false,
                  ),
                  ListTile(
                    title: Text(
                      '3 French Fries Sets',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: const Icon(
                      Icons.cancel,
                      color: Color(0xFF303030),
                      size: 20,
                    ),
                    tileColor: const Color(0xFFF5F5F5),
                    dense: false,
                  ),
                  ListTile(
                    title: Text(
                      '1 Onion Soup',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: const Icon(
                      Icons.cancel,
                      color: Color(0xFF303030),
                      size: 20,
                    ),
                    tileColor: const Color(0xFFF5F5F5),
                    dense: false,
                  ),
                  ListTile(
                    title: Text(
                      '1 Cheeseburger',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: const Icon(
                      Icons.cancel,
                      color: Color(0xFF303030),
                      size: 20,
                    ),
                    tileColor: const Color(0xFFF5F5F5),
                    dense: false,
                  ),*/
                ],
              ),
            ]),
      ),

      floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Speak',
          child: const Icon(Icons.mic),
          elevation:
              8), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
