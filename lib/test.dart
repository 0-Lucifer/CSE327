import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() => runApp(const TestApp());

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Test',
      home: const TestPage(),
    );
  }
}

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<Map<String, dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _addTestData() async {
    final batch = _firestore.batch();
    final testCollection = _firestore.collection('test');

    batch.set(testCollection.doc(), {'name': 'Alice', 'roll': 101});
    batch.set(testCollection.doc(), {'name': 'Bob', 'roll': 102});
    batch.set(testCollection.doc(), {'name': 'Charlie', 'roll': 103});

    await batch.commit();
    _fetchData(); // Refresh data after adding
  }

  Future<void> _fetchData() async {
    final snapshot = await _firestore.collection('test').get();
    setState(() {
      _data.clear();
      _data.addAll(snapshot.docs.map((doc) => doc.data()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _addTestData,
              child: const Text('Add Test Data'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _data.length,
                itemBuilder: (context, index) {
                  final item = _data[index];
                  return ListTile(
                    title: Text('Name: ${item['name']}'),
                    subtitle: Text('Roll: ${item['roll']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}