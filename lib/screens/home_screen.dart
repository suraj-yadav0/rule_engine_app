// lib/screens/home_screen.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/rule_engine.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ruleController = TextEditingController();
  final _dataController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('R U L E   E N G I N E'),centerTitle: true,),
      body: Consumer<RuleEngine>(
        builder: (context, ruleEngine, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _ruleController,
                    decoration: const InputDecoration(labelText: 'Enter Rule'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a rule';
                      }
                      return null;
                    },
                  ),
                 const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ruleEngine.combineRules([_ruleController.text]);
                        ScaffoldMessenger.of(context).showSnackBar(
                        const  SnackBar(content: Text('Rule added')),
                        );
                      }
                    },
                    child: const Text('Add Rule'),
                  ),
                const  SizedBox(height: 32),
                  TextFormField(
                    controller: _dataController,
                    decoration: const InputDecoration(labelText: 'Enter Data (JSON format)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter data';
                      }
                      try {
                        Map<String, dynamic> data = Map<String, dynamic>.from(
                          Map.from(json.decode(value))
                        );
                      } catch (e) {
                        return 'Invalid JSON format';
                      }
                      return null;
                    },
                  ),
                const  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> data = Map<String, dynamic>.from(
                          Map.from(json.decode(_dataController.text))
                        );
                        bool result = ruleEngine.evaluateRule(data);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Evaluation result: $result')),
                        );
                      }
                    },
                    child: const Text('Evaluate Rule'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _ruleController.dispose();
    _dataController.dispose();
    super.dispose();
  }
}