// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/rule_engine.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rule Engine')),
      body: Consumer<RuleEngine>(
        builder: (context, ruleEngine, child) {
          return Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  ruleEngine.combineRules([
                    "((age > 30 AND department = 'Sales') OR (age < 25 AND department = 'Marketing')) AND (salary > 50000 OR experience > 5)",
                    "((age > 30 AND department = 'Marketing')) AND (salary > 20000 OR experience > 5)",
                  ]);
                },
                child: Text('Combine Rules'),
              ),
              ElevatedButton(
                onPressed: () {
                  bool result = ruleEngine.evaluateRule({
                    "age": 35,
                    "department": "Sales",
                    "salary": 60000,
                    "experience": 3,
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Evaluation result: $result')),
                  );
                },
                child: Text('Evaluate Rule'),
              ),
            ],
          );
        },
      ),
    );
  }
}