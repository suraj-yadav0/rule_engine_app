// lib/models/ast_node.dart
class ASTNode {
  final String type;
  final ASTNode? left;
  final ASTNode? right;
  final dynamic value;

  ASTNode({
    required this.type,
    this.left,
    this.right,
    this.value,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'left': left?.toJson(),
      'right': right?.toJson(),
      'value': value,
    };
  }

  factory ASTNode.fromJson(Map<String, dynamic> json) {
    return ASTNode(
      type: json['type'],
      left: json['left'] != null ? ASTNode.fromJson(json['left']) : null,
      right: json['right'] != null ? ASTNode.fromJson(json['right']) : null,
      value: json['value'],
    );
  }
}