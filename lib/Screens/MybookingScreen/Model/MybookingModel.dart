class MybookingModel {
  String? sId;
  String? turfName;
  String? turfLogo;
  Location? location;
  String? address;
  String? email;
  String? ownerMail;
  String? customerName;
  String? turfId;
  String? date;
  String? slot;
  String? eventName;
  String? totalPrice;
  String? trxId;
  bool? paid;
  String? paymentDate;

  MybookingModel(
      {this.sId,
      this.turfName,
      this.turfLogo,
      this.location,
      this.address,
      this.email,
      this.ownerMail,
      this.customerName,
      this.turfId,
      this.date,
      this.slot,
      this.eventName,
      this.totalPrice,
      this.trxId,
      this.paid,
      this.paymentDate});

  MybookingModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    turfName = json['turfName'];
    turfLogo = json['turfLogo'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    address = json['address'];
    email = json['email'];
    ownerMail = json['ownerMail'];
    customerName = json['customerName'];
    turfId = json['turfId'];
    date = json['date'];
    slot = json['slot'];
    eventName = json['eventName'];
    totalPrice = json['totalPrice'];
    trxId = json['trxId'];
    paid = json['paid'];
    paymentDate = json['paymentDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['turfName'] = this.turfName;
    data['turfLogo'] = this.turfLogo;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['address'] = this.address;
    data['email'] = this.email;
    data['ownerMail'] = this.ownerMail;
    data['customerName'] = this.customerName;
    data['turfId'] = this.turfId;
    data['date'] = this.date;
    data['slot'] = this.slot;
    data['eventName'] = this.eventName;
    data['totalPrice'] = this.totalPrice;
    data['trxId'] = this.trxId;
    data['paid'] = this.paid;
    data['paymentDate'] = this.paymentDate;
    return data;
  }
}

class Location {
  double? latitude;
  double? longitude;

  Location({this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
