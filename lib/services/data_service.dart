import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:ikinyarwanda/models/igisakuzo.dart';
import 'package:ikinyarwanda/models/ikeshamvugo.dart';
import 'package:ikinyarwanda/models/incamarenga.dart';

class DataService {
  Future<String> _loadFromAsset(String fileAssetPath) async {
    return await rootBundle.loadString(fileAssetPath);
  }

  Future<dynamic> _parseJson(String fileAssetPath) async {
    String jsonString = await _loadFromAsset(fileAssetPath);
    final jsonResponse = jsonDecode(jsonString);
    return jsonResponse;
  }

  Future<List<Igisakuzo>> getIbisakuzo(int level, int randomId) async {
    final filePath = 'assets/imikino_json/ibisakuzo_$level/$randomId.json';
    final parsedIbisakuzo = await _parseJson(filePath) as List<dynamic>;
    var ibisakuzo = <Igisakuzo>[];

    for (var i = 1; i < parsedIbisakuzo.length; i++) {
      ibisakuzo.add(Igisakuzo.fromMap(parsedIbisakuzo[i]['sakwe_$i']));
    }

    return ibisakuzo;
  }

  Future<List<NtibavugaBavuga>> getIkeshamvugo(int randomId) async {
    final filePath = 'assets/imikino_json/ikeshamvugo/$randomId.json';
    final parsedIbisakuzo = await _parseJson(filePath) as List<dynamic>;
    var ikeshamvugo = <NtibavugaBavuga>[];

    for (var i = 1; i < parsedIbisakuzo.length; i++) {
      ikeshamvugo.add(
        NtibavugaBavuga.fromMap(parsedIbisakuzo[i]['ntibavuga_$i']),
      );
    }
    return ikeshamvugo;
  }

  Future<List<Incamarega>> getIncamarenga() async {
    const filePath = 'assets/imikino_json/incamarenga/incamarenga.json';
    final parsedIbisakuzo = await _parseJson(filePath) as List<dynamic>;
    var incamarenga = <Incamarega>[];
    for (var i = 0; i < parsedIbisakuzo.length; i++) {
      incamarenga.add(
        Incamarega.fromMap(parsedIbisakuzo[i]['incamarenga_${i + 1}']),
      );
    }
    return incamarenga;
  }

  Future<List<String>> getImiganiMigufi(int randomId) async {
    final filePath = 'assets/imikino_json/imiganimigufi/$randomId.json';
    final parsedIbisakuzo = await _parseJson(filePath) as List<dynamic>;
    var imigani = <String>[];
    for (var i = 1; i < parsedIbisakuzo.length; i++) {
      imigani.add(parsedIbisakuzo[i]['umugani_$i'] ?? '-');
    }
    return imigani;
  }
}
