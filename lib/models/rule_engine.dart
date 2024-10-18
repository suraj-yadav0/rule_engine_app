// lib/models/rule_engine.dart
import 'package:flutter/foundation.dart';
import 'ast_node.dart';

class RuleEngine extends ChangeNotifier {
  ASTNode? _combinedRule;

  ASTNode? get combinedRule => _combinedRule;

  ASTNode createRule(String ruleString) {
    // Implement parsing logic here
    // For simplicity, let's create a dummy node
    return ASTNode(type: 'operator', value: 'AND');
  }

  void combineRules(List<String> rules) {
    // Implement rule combination logic here
    // For simplicity, let's combine using AND
    _combinedRule = ASTNode(type: 'operator', value: 'AND');
    notifyListeners();
  }

  bool evaluateRule(Map<String, dynamic> data) {
    // Implement rule evaluation logic here
    // For simplicity, let's return true
    return true;
  }
}