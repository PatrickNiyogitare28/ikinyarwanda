import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:ikinyarwanda/models/igisakuzo.dart';
import 'package:ikinyarwanda/models/ikeshamvugo.dart';
import 'package:ikinyarwanda/models/incamarenga.dart';
import 'package:ikinyarwanda/models/inkuru.dart';

class DataService {
  Future<String> _loadFromAsset(String fileAssetPath) async {
    return await rootBundle.loadString(fileAssetPath);
  }

  Future<dynamic> _parseJson(String fileAssetPath) async {
    try {
      final jsonString = await _loadFromAsset(fileAssetPath);
      final jsonResponse = jsonDecode(jsonString);
      return jsonResponse;
    } catch (e) {
      return null;
    }
  }

  Future<Inkuru?> getInkuruById(String id) async {
    final filePath = 'assets/isomero_json/$id.json';
    final parsed = await _parseJson(filePath) as Map<String, dynamic>;
    return Inkuru.fromMap(parsed);
  }

  Future<List<Inkuru>> getInkurus([String? tag]) async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final manifestMap = json.decode(manifestContent);
    final inkurusPaths = manifestMap.keys
        .where((String key) => key.contains('isomero_json/'))
        .where((String key) => key.contains('.json'))
        .toList();
    final inkurus = <Inkuru>[];
    for (var path in inkurusPaths) {
      final parsed = await _parseJson(path) as Map<String, dynamic>;
      if (tag != null) {
        if (parsed['author'] == tag || (parsed['tags'] as List).contains(tag)) {
          inkurus.add(Inkuru.fromMap(parsed));
        } else {
          continue;
        }
      }
      inkurus.add(Inkuru.fromMap(parsed));
    }
    return inkurus;
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
