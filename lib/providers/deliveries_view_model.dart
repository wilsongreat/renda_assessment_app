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

  ///SEARCH DELIVERIES LIST

  Future<void> searchDeliveries(String search) async {
    if(search.isNotEmpty){
      searchList = deliveryList.where((element) {
        var name =
        element.senderName!.toLowerCase().contains(search.toLowerCase());
        var id = element.trackingId!.toLowerCase().contains(search.toLowerCase());
        return name || id;
      }).toList();
    }else{
      searchList = deliveryList;
    }

    print(searchList.length);
  }


  ///FETCH DELIVERIES LIST from api call
  Future<void> fetchDeliveries() async {
    debugPrint(url);

    // Show loading state
    state = const AsyncLoading();
    // Fetch and parse deliveries
      state = await AsyncValue.guard(()async{
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
              ..add(deliveryList[i].senderName!)
              ..add(deliveryList[i].recipientName!)
              ..add(deliveryList[i].deliveryItems!.first.weight!.toString())
              ..add(deliveryList[i].scheduleDelivery.toString())
              ..add(deliveryList[i].deliveryItems!.first.quantity!.toString());
            prefs.setStringList(deliveryList[i].id ?? '', val);
          }
          searchList = deliveryList;
        } else {
          throw Exception('Failed to load data');
        }
      });


    // state = await AsyncValue.guard(() async {

    // });
    return;
  }
  ///UPDATE DELIVERY DATA
  Future<void> updateList(String id, String status) async {
    final val = deliveryList.firstWhere((element) => element.id == id);

    List<String> list = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();

    list
      ..add(val.country!)
      ..add(val.trackingId!)
      ..add(status)
      ..add(val.deliveryCost.toString())
      ..add(val.senderName!)
      ..add(val.recipientName!)
      ..add(val.deliveryItems!.first.weight!.toString())
      ..add(val.deliveryItems!.first.weight!.toString());
    prefs.setStringList(val.id ?? '', list);
  }
}


