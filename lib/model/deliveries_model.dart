class DeliveryListData {
  List<DeliveryResponseModel>? deliveries;

  DeliveryListData(this.deliveries);

  
}

class DeliveryResponseModel {
  String? id;
  String? businessId;
  String? businessName;
  String? country;
  String? deliveryId;
  String? batchId;
  String? shipmentId;
  String? driverId;
  String? status;
  String? pickUpAddress;
  String? deliveryAddress;
  String? pickUpArea;
  String? deliveryArea;
  String? senderName;
  String? senderPhone;
  String? recipientName;
  String? recipientPhone;
  List<DeliveryItem>? deliveryItems;
  int? totalItemsCost;
  int? totalItemWeight;
  int? deliveryCost;
  String? paymentType;
  DateTime? scheduleDelivery;
  String? trackingId;
  String? paymentMethod;
  int? cashCollected;
  int? returnDeliveryCost;
  int? partnerPayout;
  int? mockCommission;
  double? margin;

  DeliveryResponseModel({
    this.id,
    this.businessId,
    this.businessName,
    this.country,
    this.deliveryId,
    this.batchId,
    this.shipmentId,
    this.driverId,
    this.status,
    this.pickUpAddress,
    this.deliveryAddress,
    this.pickUpArea,
    this.deliveryArea,
    this.senderName,
    this.senderPhone,
    this.recipientName,
    this.recipientPhone,
    this.deliveryItems,
    this.totalItemsCost,
    this.totalItemWeight,
    this.deliveryCost,
    this.paymentType,
    this.scheduleDelivery,
    this.trackingId,
    this.paymentMethod,
    this.cashCollected,
    this.returnDeliveryCost,
    this.partnerPayout,
    this.mockCommission,
    this.margin,
  });

  DeliveryResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessId = json['business_id'];
    businessName = json['business_name'];
    country = json['country'];
    deliveryId = json['delivery_id'];
    batchId = json['batch_id'];
    shipmentId = json['shipment_id'];
    driverId = json['driver_id'];
    status = json['status'];
    pickUpAddress = json['pick_up_address'];
    deliveryAddress = json['delivery_address'];
    pickUpArea = json['pick_up_area'];
    deliveryArea = json['delivery_area'];
    senderName = json['sender_name'];
    senderPhone = json['sender_phone'];
    recipientName = json['recipient_name'];
    recipientPhone = json['recipient_phone'];
    if (json['delivery_items'] != null) {
      deliveryItems = <DeliveryItem>[];
      json['delivery_items'].forEach((v) {
        deliveryItems!.add(DeliveryItem.fromJson(v));
      });
    }
    totalItemsCost = json['total_items_cost'];
    totalItemWeight = json['total_item_weight'];
    deliveryCost = json['delivery_cost'];
    paymentType = json['payment_type'];
    scheduleDelivery = json['schedule_delivery'] != null
        ? DateTime.parse(json['schedule_delivery'])
        : null;
    trackingId = json['tracking_id'];
    paymentMethod = json['payment_method'];
    cashCollected = json['cash_collected'];
    returnDeliveryCost = json['return_delivery_cost'];
    partnerPayout = json['partner_payout'];
    mockCommission = json['mock_commission'];
    margin = json['margin']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['business_id'] = businessId;
    data['business_name'] = businessName;
    data['country'] = country;
    data['delivery_id'] = deliveryId;
    data['batch_id'] = batchId;
    data['shipment_id'] = shipmentId;
    data['driver_id'] = driverId;
    data['status'] = status;
    data['pick_up_address'] = pickUpAddress;
    data['delivery_address'] = deliveryAddress;
    data['pick_up_area'] = pickUpArea;
    data['delivery_area'] = deliveryArea;
    data['sender_name'] = senderName;
    data['sender_phone'] = senderPhone;
    data['recipient_name'] = recipientName;
    data['recipient_phone'] = recipientPhone;
    if (deliveryItems != null) {
      data['delivery_items'] = deliveryItems!.map((v) => v.toJson()).toList();
    }
    data['total_items_cost'] = totalItemsCost;
    data['total_item_weight'] = totalItemWeight;
    data['delivery_cost'] = deliveryCost;
    data['payment_type'] = paymentType;
    data['schedule_delivery'] = scheduleDelivery?.toIso8601String();
    data['tracking_id'] = trackingId;
    data['payment_method'] = paymentMethod;
    data['cash_collected'] = cashCollected;
    data['return_delivery_cost'] = returnDeliveryCost;
    data['partner_payout'] = partnerPayout;
    data['mock_commission'] = mockCommission;
    data['margin'] = margin;
    return data;
  }
}

class DeliveryItem {
  String? category;
  String? subCategory;
  String? itemName;
  int? weight;
  int? quantity;
  int? unitPrice;

  DeliveryItem({
    this.category,
    this.subCategory,
    this.itemName,
    this.weight,
    this.quantity,
    this.unitPrice,
  });

  DeliveryItem.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    subCategory = json['sub_category'];
    itemName = json['item_name'];
    weight = json['weight'];
    quantity = json['quantity'];
    unitPrice = json['unit_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['sub_category'] = subCategory;
    data['item_name'] = itemName;
    data['weight'] = weight;
    data['quantity'] = quantity;
    data['unit_price'] = unitPrice;
    return data;
  }
}
