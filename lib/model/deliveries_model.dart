class DeliveryListData {
  List<DeliveryResponseModel>? deliveries;

  DeliveryListData({this.deliveries});

  DeliveryListData.fromJson(Map<String, dynamic> json) {
    if (json['deliveries'] != null) {
      deliveries = <DeliveryResponseModel>[];
      json['deliveries'].forEach((v) {
        deliveries!.add(DeliveryResponseModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.deliveries != null) {
      data['deliveries'] = this.deliveries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
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
    data['id'] = this.id;
    data['business_id'] = this.businessId;
    data['business_name'] = this.businessName;
    data['country'] = this.country;
    data['delivery_id'] = this.deliveryId;
    data['batch_id'] = this.batchId;
    data['shipment_id'] = this.shipmentId;
    data['driver_id'] = this.driverId;
    data['status'] = this.status;
    data['pick_up_address'] = this.pickUpAddress;
    data['delivery_address'] = this.deliveryAddress;
    data['pick_up_area'] = this.pickUpArea;
    data['delivery_area'] = this.deliveryArea;
    data['sender_name'] = this.senderName;
    data['sender_phone'] = this.senderPhone;
    data['recipient_name'] = this.recipientName;
    data['recipient_phone'] = this.recipientPhone;
    if (this.deliveryItems != null) {
      data['delivery_items'] =
          this.deliveryItems!.map((v) => v.toJson()).toList();
    }
    data['total_items_cost'] = this.totalItemsCost;
    data['total_item_weight'] = this.totalItemWeight;
    data['delivery_cost'] = this.deliveryCost;
    data['payment_type'] = this.paymentType;
    data['schedule_delivery'] = this.scheduleDelivery?.toIso8601String();
    data['tracking_id'] = this.trackingId;
    data['payment_method'] = this.paymentMethod;
    data['cash_collected'] = this.cashCollected;
    data['return_delivery_cost'] = this.returnDeliveryCost;
    data['partner_payout'] = this.partnerPayout;
    data['mock_commission'] = this.mockCommission;
    data['margin'] = this.margin;
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
    data['category'] = this.category;
    data['sub_category'] = this.subCategory;
    data['item_name'] = this.itemName;
    data['weight'] = this.weight;
    data['quantity'] = this.quantity;
    data['unit_price'] = this.unitPrice;
    return data;
  }
}
