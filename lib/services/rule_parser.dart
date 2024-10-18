// lib/services/rule_parser.dart
import '../models/ast_node.dart';

class RuleParser {
  int _index = 0;
  late String _input;

  ASTNode parse(String input) {
    _input = input.replaceAll(' ', '');
    _index = 0;
    return _parseExpression();
  }

  ASTNode _parseExpression() {
    ASTNode left = _parseTerm();
    while (_index < _input.length && (_input[_index] == 'A' || _input[_index] == 'O')) {
      String op = _input.substring(_index, _index + 3);
      _index += 3;
      ASTNode right = _parseTerm();
      left = ASTNode(type: 'operator', value: op, left: left, right: right);
    }
    return left;
  }

  ASTNode _parseTerm() {
    if (_input[_index] == '(') {
      _index++;
      ASTNode node = _parseExpression();
      _index++; // Skip closing parenthesis
      return node;
    } else {
      return _parseComparison();
    }
  }

  ASTNode _parseComparison() {
    int start = _index;
    while (_index < _input.length && _input[_index] != '=' && _input[_index] != '<' && _input[_index] != '>') {
      _index++;
    }
    String field = _input.substring(start, _index);
    String op = _input[_index] == '=' ? '=' : _input.substring(_index, _index + 2);
    _index += op.length;
    String value = _parseValue();
    return ASTNode(type: 'comparison', value: {'field': field, 'op': op, 'value': value});
  }

  String _parseValue() {
    int start = _index;
    if (_input[_index] == '\'') {
      start++;
      _index++;
      while (_index < _input.length && _input[_index] != '\'') {
        _index++;
      }
      _index++;
      return _input.substring(start, _index - 1);
    } else {
      while (_index < _input.length && _input[_index] != ')' && _input[_index] != 'A' && _input[_index] != 'O') {
        _index++;
      }
      return _input.substring(start, _index);
    }
  }
}