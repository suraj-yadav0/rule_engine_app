// lib/services/database_helper.dart
import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/ast_node.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();


  Future<void> saveCombinedRule(ASTNode? rule) async {
    Database db = await database;
    await db.delete('combined_rule');
    if (rule != null) {
      await db.insert('combined_rule', {'ast': jsonEncode(rule.toJson())});
    }
  }

Future<ASTNode?> getCombinedRule() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('combined_rule');
    if (maps.isNotEmpty) {
      return ASTNode.fromJson(jsonDecode(maps.first['ast']));
    }
    return null;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'rule_engine.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE rules(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            ast TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertRule(ASTNode rule) async {
    Database db = await database;
    return await db.insert('rules', {'ast': rule.toJson().toString()});
  }

  Future<List<ASTNode>> getRules() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('rules');
    return List.generate(maps.length, (i) {
      return ASTNode.fromJson(maps[i]['ast']);
    });
  }
}