import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import '../db/category.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AddService extends StatefulWidget {
  const AddService({super.key});

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  Category _category = Category();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController serviceNameController = TextEditingController();
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  late String _currentCategory;
  Color white = Colors.white;
  Color grey = Colors.grey;
  Color black = Colors.black;
  Color red = Colors.red;

  List<DropdownMenuItem<String>> getCategoriesDropDown() {
    List<DropdownMenuItem<String>> items = [];

    for (int i = 0; i < categories.length; i++) {
      items.add(
        DropdownMenuItem(
          child: Text((categories[i].data() as Map<String, dynamic>)['category'] ?? ''),
          value: (categories[i].data() as Map<String, dynamic>)['category'],
        ),
      );
    }

    return items;
  }


  @override
  void initState() {
    _getCategories();

    //_currentCategory = categoriesDropDown[0].value!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        leading: Icon(Icons.close, color: black),
        title: Text(
          "Add Service",
          style: TextStyle(color: black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 40, 20, 40),
                              child: new Icon(
                                Icons.add,
                                color: grey,
                              )),
                        ))),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 40, 20, 40),
                              child: new Icon(
                                Icons.add,
                                color: grey,
                              )),
                        ))),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 40, 20, 40),
                              child: new Icon(
                                Icons.add,
                                color: grey,
                              )),
                        ))),
              ],
            ),
            Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'enter a service name with atmost 10 characters',
                  style: TextStyle(color: red),
                )),
            Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  controller: serviceNameController,
                  decoration: InputDecoration(hintText: 'Service Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'you must enter service name';
                    } else if (value.length > 10) {
                      return 'service name cant have more than 10 letters';
                    }
                  },
                )),

                 Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Category",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      DropdownButton(
                        items: categoriesDropDown,
                        onChanged: changeSelectedCategory,
                      ),



              ],
            ),


            ElevatedButton(
              child: Text('add product'),
              onPressed: () {
                //validateAndUpload();
              },
            )
          ],
        ),
      ),
    );
  }

  _getCategories() async {
    List<DocumentSnapshot> data = await _category.getCategory();
    print(data.length);
    setState(() {
      categories = data;
      categoriesDropDown = getCategoriesDropDown();
      if (categories.isNotEmpty) {
        _currentCategory =
            (categories[0].data() as Map<String, dynamic>?)?['category'];
      }
    });
  }

  changeSelectedCategory(String? selectedCategory) {
    setState(() {
      _currentCategory = selectedCategory!;
    });
  }
}
