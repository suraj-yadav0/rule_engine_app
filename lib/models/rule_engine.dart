// lib/models/rule_engine.dart
import 'package:flutter/foundation.dart';
import 'ast_node.dart';
import '../services/rule_parser.dart';

class RuleEngine extends ChangeNotifier {
  ASTNode? _combinedRule;
  final RuleParser _parser = RuleParser();

  ASTNode? get combinedRule => _combinedRule;

  ASTNode? createRule(String ruleString) {
    try {
      return _parser.parse(ruleString);
    } catch (e) {
      print('Error creating rule: ${e.toString()}');
      return null;
    }
  }


  void combineRules(List<String> rules) {
    try {
      if (rules.isEmpty) {
        _combinedRule = null;
      } else if (rules.length == 1) {
        _combinedRule = createRule(rules[0]);
      } else {
        _combinedRule = rules.map((r) => createRule(r))
            .where((r) => r != null)
            .reduce((a, b) => 
              ASTNode(type: 'operator', value: 'AND', left: a, right: b));
      }
      notifyListeners();
    } catch (e) {
      print('Error combining rules: ${e.toString()}');
      _combinedRule = null;
      notifyListeners();
    }
  }

  bool evaluateRule(Map<String, dynamic> data) {
    if (_combinedRule == null) return false;
    return _evaluateNode(_combinedRule!, data);
  }

  bool _evaluateNode(ASTNode node, Map<String, dynamic> data) {
    if (node.type == 'operator') {
      bool leftResult = _evaluateNode(node.left!, data);
      bool rightResult = _evaluateNode(node.right!, data);
      return node.value == 'AND' ? leftResult && rightResult : leftResult || rightResult;
    } else if (node.type == 'comparison') {
      String field = node.value['field'];
      String op = node.value['op'];
      dynamic value = node.value['value'];
      
      if (!data.containsKey(field)) return false;
      
      switch (op) {
        case '=':
          return data[field].toString() == value;
        case '>':
          return (data[field] as num) > num.parse(value);
        case '<':
          return (data[field] as num) < num.parse(value);
        case '>=':
          return (data[field] as num) >= num.parse(value);
        case '<=':
          return (data[field] as num) <= num.parse(value);
        default:
          return false;
      }
    }
    return false;
  }
}