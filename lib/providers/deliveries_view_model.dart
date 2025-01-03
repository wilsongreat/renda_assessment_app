import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:renda_assessment/model/deliveries_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'deliveries_view_model.g.dart';

@riverpod
class DeliveriesViewModel extends _$DeliveriesViewModel {
  @override
  FutureOr<dynamic> build() {
    return state;
  }

  static const String baseUrl = 'https://run.mocky.io/v3';
  final url = '$baseUrl/f7f73f19-054d-41f7-94bb-c2d3d33524bd';

  List<DeliveryResponseModel> deliveryList = [];

  List<DeliveryResponseModel> searchList = [];

  Future<void> searchDeliveries(String search) async {
    searchList = deliveryList.where((element) {
      var name =
          element.senderName!.toLowerCase().contains(search.toLowerCase());
      var id = element.id!.toLowerCase().contains(search.toLowerCase());
      return id || name;
    }).toList();
    print(searchList.length);
  }

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
          deliveryList.add(DeliveryResponseModel.fromJson(jsonData[i]));
          SharedPreferences prefs = await SharedPreferences.getInstance();
          List<String> val = [];
          val
            ..add(deliveryList[i].country!)
            ..add(deliveryList[i].trackingId!)
            ..add(deliveryList[i].status!)
            ..add(deliveryList[i].deliveryCost.toString())
            ..add(deliveryList[i].driverId!)
            ..add(deliveryList[i].batchId!);
          prefs.setStringList(deliveryList[i].id ?? '', val);
        }
        searchList = deliveryList;
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

  Future<void> updateList(String id, String status) async {
    final val = deliveryList.firstWhere((element) => element.id == id);

    List<String> list = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();

    list
      ..add(val.country!)
      ..add(val.trackingId!)
      ..add(status)
      ..add(val.deliveryCost.toString())
      ..add(val.driverId!)
      ..add(val.batchId!);
    prefs.setStringList(val.id ?? '', list);
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
