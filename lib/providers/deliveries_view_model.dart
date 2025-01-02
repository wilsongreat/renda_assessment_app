import 'dart:convert';
import 'dart:core';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:renda_assessment/model/deliveries_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

part 'deliveries_view_model.g.dart';

@riverpod
class DeliveriesViewModel extends _$DeliveriesViewModel {
  Database? _database;

  String databaseName = 'transaction.db';
  static const int versionNumber = 1;
  String tableNotes = 'Users';
  String colId = 'id';
  String colDate = 'date';
  String colDescription = 'description';
  String colTitle = 'title';
  String colType = 'type';
  String colStatus = 'status';
  String colAmount = 'amount';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    var db =
        await openDatabase(path, version: versionNumber, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE IF NOT EXISTS $tableNotes ("
        "$colId INTEGER PRIMARY KEY,"
        "$colDate TEXT,"
        "$colDescription TEXT,"
        "$colTitle TEXT,"
        "$colType TEXT,"
        "$colStatus TEXT,"
        "$colAmount TEXT"
        ")");
  }

  Future<List<DeliveryResponseModel>> getAll() async {
    final db = await database;
    final result = await db.query(tableNotes, orderBy: '$colDate DESC');
    return result.map((json) => DeliveryResponseModel.fromJson(json)).toList();
  }

  Future<DeliveryResponseModel?> read(int id) async {
    final db = await database;
    final maps = await db.query(
      tableNotes,
      where: '$colId = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return DeliveryResponseModel.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<void> insert(DeliveryResponseModel note) async {
    final db = await database;
    await db.insert(tableNotes, note.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> codeUpdate(DeliveryResponseModel note) async {
    final db = await database;
    var res = await db.update(tableNotes, note.toJson(),
        where: '$colId = ?', whereArgs: [note.id]);
    return res;
  }

  Future<void> delete(int id) async {
    final db = await database;
    try {
      await db.delete(tableNotes, where: "$colId = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  Future close() async {
    final db = await database;
    db.close();
  }

  @override
  FutureOr<dynamic> build() {
    return state;
  }

  static const String baseUrl = 'https://run.mocky.io/v3';
  final url = '$baseUrl/f7f73f19-054d-41f7-94bb-c2d3d33524bd';

  List<DeliveryResponseModel> deliveryList = [];

  Future<void> fetchDeliveries() async {
    debugPrint(url);

    // Show loading state
    state = const AsyncLoading();

    // Fetch and parse deliveries

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        String rawJson = response.body;
        // Fix trailing commas in the JSON
        String fixedJson =
            rawJson.replaceAllMapped(RegExp(r',\s*[}\]]'), (match) {
          // Remove the comma
          return match.group(0)!.replaceFirst(',', '');
        });
        List<dynamic> jsonData = json.decode(fixedJson);
        deliveryList.clear();
        for (var i = 0; i < jsonData.length; i++) {
          // deliveryList.add(DeliveryResponseModel.fromJson(jsonData[i]));
          insert(DeliveryResponseModel.fromJson(jsonData[i]));
        }
        deliveryList = await getAll();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
    // state = await AsyncValue.guard(() async {

    // });

    return;
  }
}

// final apiLost = [
//   {
//     "id": "676566ed43cea4b1c57b729f",
//     "business_id": "MOCK-708031195-NG-SUB",
//     "business_id_no": "MOCK-708031195-NG-SUB",
//     "business_name": "dell",
//     "country": "Nigeria",
//     "delivery_id": "MOCK-MK-41890837",
//     "batch_id": "MK-00000495",
//     "shipment_id": "MKSH-1-00001500",
//     "partner_id": "MKDP-000850-NG",
//     "driver_id": "MKDP00000826",
//     "created_at": "2024-12-20T12:45:33.139Z",
//     "picked_up_time": "2024-12-23T09:43:01.075Z",
//     "in_transit_time": "2024-12-23T09:57:36.519Z",
//     "delivered_at": "2024-12-23T09:57:44.72Z",
//     "updated_at": "2024-12-23T09:57:44.72Z",
//     "status": "Accepted",
//     "prev_status": [],
//     "pick_up_address": "Ikotun Roundabout, Egbe Road, Lagos, Nigeria",
//     "delivery_address": "Ikorodu agric, Olubayo Osokoya St, Ikorodu, Nigeria",
//     "pick_up_area": "alimosho - ijegun ikotun",
//     "delivery_area": "ikorodu - agric",
//     "sender_name": "Rabbi",
//     "sender_phone": "2348066782877",
//     "recipient_name": "Oceanic",
//     "recipient_phone": "2349077666589",
//     "delivery_items": [
//       {
//         "category": "Electrical & Industrial Equipments",
//         "sub_category": "Industrial Machinery",
//         "item_name": "Turning machines",
//         "weight": 6,
//         "quantity": 100,
//         "unit_price": 5000000
//       }
//     ],
//     "total_items_cost": 500000000,
//     "total_item_weight": 6,
//     "delivery_cost": 604250,
//     "payment_type": "POD",
//     "save_for_later": false,
//     "cash_collection": 0,
//     "schedule_delivery": "2024-12-20T12:45:32.547Z",
//     "tracking_id": "MKT-1718-2038",
//     "payment_method": "POD",
//     "cash_collected": 0,
//     "return_delivery_cost": 0,
//     "partner_payout": 100000,
//     "mock_commission": 504250,
//     "margin": 83.45055854364915,
//     "otp": "2885",
//     "country_code": "NG"
//   },
// ];
