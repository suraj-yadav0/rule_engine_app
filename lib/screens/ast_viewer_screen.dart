// lib/screens/ast_viewer_screen.dart
import 'package:flutter/material.dart';
import '../models/ast_node.dart';

class ASTViewerScreen extends StatelessWidget {
  final ASTNode rootNode;

  ASTViewerScreen({required this.rootNode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AST Viewer')),
      body: SingleChildScrollView(
        child: Center(
          child: _buildTree(rootNode),
        ),
      ),
    );
  }

  Widget _buildTree(ASTNode node) {
    return ExpansionTile(
      title: Text(node.type),
      subtitle: Text(node.value.toString()),
      children: [
        if (node.left != null) _buildTree(node.left!),
        if (node.right != null) _buildTree(node.right!),
      ],
    );
  }
}