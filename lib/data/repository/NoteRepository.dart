
import 'dart:io';

import 'package:notas/data/models/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'data_source/DatabaseProvider.dart';

class NoteRepository {
  NoteRepository() { }

  getAllNotes() async {
    final db = await DatabaseProvider.databaseProvider.database;
    if(db == null) {
      print("Database is null");
    } else {
      var notes = await db.query("notes");
      final List<Map<String, dynamic>> maps = await db.query("notes");

      return List.generate(maps.length, (i) {
        return Note(
            id: maps[i]['id'],
            title: maps[i]['title'],
            body: maps[i]['body']
        );
      });
    }
  }

  createNote(Note note) async {
    final db = await DatabaseProvider.databaseProvider.database;
    if(db == null) {
      print("Database is null");
    } else {
      await db.insert('notes', note.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

    }
  }
}
