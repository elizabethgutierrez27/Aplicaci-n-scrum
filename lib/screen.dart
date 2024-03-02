import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class ScrumGlossary extends StatefulWidget {
  @override
  _ScrumGlossaryState createState() => _ScrumGlossaryState();
}

class _ScrumGlossaryState extends State<ScrumGlossary> {
  List<Map<String, String>> glossaryItems = [];
  Map<String, String>? selectedTerm;

  @override
  void initState() {
    super.initState();
    loadGlossary();
  }

  Future<void> loadGlossary() async {
    String jsonString = await rootBundle.loadString('assets/data.json');
    List<dynamic> jsonList = json.decode(jsonString);
    setState(() {
      glossaryItems = jsonList.map((item) => Map<String, String>.from(item)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Elementos Scrum',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          
        ),
        backgroundColor: Color.fromARGB(255, 219, 235, 222),
        centerTitle: true,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: glossaryItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(glossaryItems[index]['name']!),
                  onTap: () {
                    setState(() {
                      selectedTerm = glossaryItems[index];
                    });
                  },
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: selectedTerm != null
                ? Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(selectedTerm!['name']!, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Image.asset(selectedTerm!['image']!, scale: 2.5,),
                  SizedBox(height: 8),
                  Text('Descripción:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(selectedTerm!['description']!),
                  SizedBox(height: 8),
                  Text('Ejemplo:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(selectedTerm!['example']!),
                ],
              ),
            )
                : Container(
              padding: EdgeInsets.all(16.0),
              child: Text('Selecciona un término del glosario'),
            ),
          ),
        ],
      ),
    );
  }
}
