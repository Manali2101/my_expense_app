import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'expense.dart';
import 'categories.dart';
import 'dart:async';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart' as u;
import 'package:intl/intl.dart';
import 'package:settings_ui/settings_ui.dart';


generateID() async {
  const uuid = u.Uuid();
  return uuid.v4();
} 


late Realm realm;
void main() async {
  runApp(
    MaterialApp(
      home: Home(),
    )
  );
  realm = await initRealm("realm/initial.realm");

}

Future<Realm> initRealm(String assetKey) async {

  final config = Configuration.local([Expense.schema, Category.schema],
    encryptionKey: null,
    path: p.join(Configuration.defaultStoragePath, "default2.realm")
  );

  final realm = Realm(config);
  return realm;
}

class Home extends StatefulWidget {
   @override
      _Home createState() => _Home();

}


class _Home extends State<Home> {

final _formKeyScreen1 = GlobalKey<FormState>();

List<String> Categories = ['Category', 'Aunty', 'Uncle'];

String selectedValue = 'Category';

  TextEditingController descriptionTextController = TextEditingController();
  TextEditingController dateTextController = TextEditingController();
  TextEditingController categoryTextController = TextEditingController();
  TextEditingController amountTextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    descriptionTextController.dispose();
    dateTextController.dispose();
    // categoryTextController.dispose();
    amountTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('MY EXPENSE TRACKER'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                label: 'Settings',
                icon: Icon(Icons.settings))
          ],
          onTap: (value) {
            if (value == 0) { 
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=> Home())
              );
            };

            if (value == 1) { 
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=> Settings())
              );
            }  
          },
        ),
        body: Center(
          child: Align(
            alignment: Alignment.bottomCenter,
              child: ElevatedButton(
              onPressed: (){
                showDialog(
                  context: context, 
                  builder: (BuildContext context) {
                    return AlertDialog(
                      scrollable: true,
                      title: const Text('Add Expense'),
                      content: Padding(
                        padding: const EdgeInsets.all(0.8),
                        child: Form(
                          key: _formKeyScreen1,
                          child: Column(
                            children: <Widget>[
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Date',
                                    icon: Icon(Icons.calendar_view_month_rounded),
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2100));

                                    if (pickedDate != null) {
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                    setState(() {
                                      dateTextController.text = formattedDate; //set output date to TextField value.
                                    });
                                    } else {}
                                    },
                                    controller: dateTextController,
                                ),
                                DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.blue, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                    ),
                                    border: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.blue, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                    ),
                                    filled: true,
                                    fillColor: Colors.blueAccent,
                                  ),
                                  dropdownColor: Colors.blueAccent,
                                  value: selectedValue,
                                  
                                  onChanged: (String? newValue) {
                                      setState(() {
                                      selectedValue = newValue!;
                                  });
                                  },
                                  items: Categories.map((String items) {
                                      return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                    // onSaved: () {
                                    //   controller: categoryTextController,
                                    // },                                    
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Description',
                                    icon: Icon(Icons.description),
                                  ),
                                  maxLines: 2, 
                                
                                  controller: descriptionTextController,
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Amount',
                                    icon: Icon(Icons.money ),
                                ),
                                maxLines: 1, 
                                controller: amountTextController,
                                ),
                            ],
                          ), 
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          child: const Text("Submit"),
                          onPressed: () async {
                            final id = ObjectId();

                            var expense = Expense( 
                              id, 
                              dateTextController.text, 
                              selectedValue, 
                              description: descriptionTextController.text, 
                              amount: int.parse(amountTextController.text) 
                              );
                            realm.write(() {
                              realm.add(expense);
                            });

                            _formKeyScreen1.currentState?.reset();
                            Navigator.pop(context);

                            showDialog(context: context, builder: (context){
                              return const AlertDialog(
                                content: Text('Submitted!'),
                                
                              );
                            }).then((value) => _formKeyScreen1.currentState?.reset());
                          })
                      ],
                    );
                  });
              },
              child: const Text('ADD')
              )

          )
        )
    );
  }
}


class Settings extends StatefulWidget {
  @override
    _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  final _formKeyScreen2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('MY EXPENSE TRACKER'),
        ),
      body: SettingsList(
      sections: [
        SettingsSection(
          title: Text('Common'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: Icon(Icons.language),
              title: Text('Language'),
              value: Text('English'),
            ),
            SettingsTile.switchTile(
              onToggle: (value) {},
              initialValue: true,
              leading: Icon(Icons.format_paint),
              title: Text('Enable custom theme'),
            ),
          ],
        ),
      ],
    ),
    );
  }  

}