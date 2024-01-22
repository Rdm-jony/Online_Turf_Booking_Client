class SpotsTurfModel {
  String? sId;
  List<String>? images;
  String? logo;
  String? name;
  Location? location;
  List<EventList>? eventList;
  List<Anemities>? anemities;
  String? address;
  List<Reviews>? reviews;
  String? division;
  String? ownerMail;

  SpotsTurfModel(
      {this.sId,
      this.images,
      this.logo,
      this.name,
      this.location,
      this.eventList,
      this.anemities,
      this.address,
      this.reviews,
      this.division,
      this.ownerMail});

  SpotsTurfModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    images = json['images'].cast<String>();
    logo = json['logo'];
    name = json['name'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    if (json['eventList'] != null) {
      eventList = <EventList>[];
      json['eventList'].forEach((v) {
        eventList!.add(new EventList.fromJson(v));
      });
    }
    if (json['anemities'] != null) {
      anemities = <Anemities>[];
      json['anemities'].forEach((v) {
        anemities!.add(new Anemities.fromJson(v));
      });
    }
    address = json['address'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    division = json['division'];
    ownerMail = json['ownerMail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['images'] = this.images;
    data['logo'] = this.logo;
    data['name'] = this.name;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.eventList != null) {
      data['eventList'] = this.eventList!.map((v) => v.toJson()).toList();
    }
    if (this.anemities != null) {
      data['anemities'] = this.anemities!.map((v) => v.toJson()).toList();
    }
    data['address'] = this.address;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    data['division'] = this.division;
    data['ownerMail'] = this.ownerMail;
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

class EventList {
  String? eventName;
  String? icon;
  String? groundSize;
  List<String>? weekdayTime;
  String? weekdayPrice;
  List<String>? weekendTime;
  String? weekendPrice;

  EventList(
      {this.eventName,
      this.icon,
      this.groundSize,
      this.weekdayTime,
      this.weekdayPrice,
      this.weekendTime,
      this.weekendPrice});

  EventList.fromJson(Map<String, dynamic> json) {
    eventName = json['eventName'];
    icon = json['icon'];
    groundSize = json['groundSize'];
    weekdayTime = json['weekdayTime'].cast<String>();
    weekdayPrice = json['weekdayPrice'];
    weekendTime = json['weekendTime'].cast<String>();
    weekendPrice = json['weekendPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventName'] = this.eventName;
    data['icon'] = this.icon;
    data['groundSize'] = this.groundSize;
    data['weekdayTime'] = this.weekdayTime;
    data['weekdayPrice'] = this.weekdayPrice;
    data['weekendTime'] = this.weekendTime;
    data['weekendPrice'] = this.weekendPrice;
    return data;
  }
}

class Anemities {
  String? anemitiesName;
  String? icon;

  Anemities({this.anemitiesName, this.icon});

  Anemities.fromJson(Map<String, dynamic> json) {
    anemitiesName = json['anemitiesName'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['anemitiesName'] = this.anemitiesName;
    data['icon'] = this.icon;
    return data;
  }
}

class Reviews {
  String? email;
  String? name;
  String? feedback;
  String? date;
  int? rating;
  String? turfId;

  Reviews(
      {this.email,
      this.name,
      this.feedback,
      this.date,
      this.rating,
      this.turfId});

  Reviews.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    feedback = json['feedback'];
    date = json['date'];
    rating = json['rating'];
    turfId = json['turfId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['feedback'] = this.feedback;
    data['date'] = this.date;
    data['rating'] = this.rating;
    data['turfId'] = this.turfId;
    return data;
  }
}