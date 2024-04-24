// To parse this JSON data, do
//
//     final houseModel = houseModelFromJson(jsonString);

import 'dart:convert';

HouseModel houseModelFromJson(String str) =>
    HouseModel.fromJson(json.decode(str));

String houseModelToJson(HouseModel data) => json.encode(data.toJson());

class HouseModel {
  bool status;
  String message;
  int? userId;
  Data data;

  HouseModel({
    required this.status,
    required this.message,
    required this.userId,
    required this.data,
  });

  factory HouseModel.fromJson(Map<String, dynamic> json) => HouseModel(
        status: json["status"],
        message: json["message"],
        userId: json["user_id"] != null ? json["user_id"] as int : null,
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user_id": userId,
        "data": data.toJson(),
      };
}

class Data {
  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  String? nextPageUrl; // Make nextPageUrl nullable
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  Data({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl, // Update nextPageUrl to be nullable
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"] ?? 0,
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"] ?? 0,
        lastPage: json["last_page"] ?? 0,
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"], // Update nextPageUrl to be nullable
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] ?? 0,
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  int id;
  String neighborhood;
  int area;
  int width;
  int height;
  String estateType;
  String estateStreet;
  String estateDeed;
  dynamic price;
  String images;
  DateTime createdAt;
  DateTime updatedAt;
  int userId;
  int displayType;
  String note;
  bool isFavorited;

  Datum({
    required this.id,
    required this.neighborhood,
    required this.area,
    required this.width,
    required this.height,
    required this.estateType,
    required this.estateStreet,
    required this.estateDeed,
    required this.price,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.displayType,
    required this.note,
    required this.isFavorited,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        neighborhood: json["neighborhood"],
        area: json["area"],
        width: json["width"],
        height: json["height"],
        estateType: json["estateType"],
        estateStreet: json["estateStreet"],
        estateDeed: json["estateDeed"],
        price: json["price"],
        images: json["images"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
        displayType: json["displayType"],
        note: json["note"],
        isFavorited: json["is_favorited"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "neighborhood": neighborhood,
        "area": area,
        "width": width,
        "height": height,
        "estateType": estateType,
        "estateStreet": estateStreet,
        "estateDeed": estateDeed,
        "price": price,
        "images": images,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_id": userId,
        "displayType": displayType,
        "note": note,
        "is_favorited": isFavorited,
      };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
