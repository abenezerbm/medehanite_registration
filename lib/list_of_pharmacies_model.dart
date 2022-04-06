// To parse this JSON data, do
//
//     final pharmaciesModel = pharmaciesModelFromJson(jsonString);

import 'dart:convert';

PharmaciesModel pharmaciesModelFromJson(String str) => PharmaciesModel.fromJson(json.decode(str));

String pharmaciesModelToJson(PharmaciesModel data) => json.encode(data.toJson());

class PharmaciesModel {
    PharmaciesModel({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    int currentPage;
    List<Datum> data;
    String firstPageUrl;
    int from;
    int lastPage;
    String lastPageUrl;
    List<Link> links;
    String nextPageUrl;
    String path;
    int perPage;
    dynamic prevPageUrl;
    int to;
    int total;

    factory PharmaciesModel.fromJson(Map<String, dynamic> json) => PharmaciesModel(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl: json["last_page_url"] == null ? null : json["last_page_url"],
        links: json["links"] == null ? null : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"] == null ? null : json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage == null ? null : currentPage,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "last_page_url": lastPageUrl == null ? null : lastPageUrl,
        "links": links == null ? null : List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl == null ? null : nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
    };
}

class Datum {
    Datum({
        this.id,
        this.name,
        this.description,
        this.logo,
        this.city,
        this.relativeLocation,
        this.longitude,
        this.latitude,
        this.phoneNo,
        this.workingHours,
        this.businessLicense,
        this.tinNumber,
        this.medicalLicense,
        this.type,
        this.userId,
        this.rating,
        this.favorite,
        this.user,
        this.reviewRatings,
    });

    String id;
    String name;
    String description;
    String logo;
    String city;
    String relativeLocation;
    double longitude;
    double latitude;
    dynamic phoneNo;
    dynamic workingHours;
    String businessLicense;
    String tinNumber;
    String medicalLicense;
    String type;
    String userId;
    double rating;
    bool favorite;
    User user;
    List<ReviewRating> reviewRatings;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        logo: json["logo"] == null ? null : json["logo"],
        city: json["city"] == null ? null : json["city"],
        relativeLocation: json["relativeLocation"] == null ? null : json["relativeLocation"],
        longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        phoneNo: json["phoneNo"],
        workingHours: json["workingHours"],
        businessLicense: json["businessLicense"] == null ? null : json["businessLicense"],
        tinNumber: json["tinNumber"] == null ? null : json["tinNumber"],
        medicalLicense: json["medicalLicense"] == null ? null : json["medicalLicense"],
        type: json["type"] == null ? null : json["type"],
        userId: json["userId"] == null ? null : json["userId"],
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
        favorite: json["favorite"] == null ? null : json["favorite"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        reviewRatings: json["review_ratings"] == null ? null : List<ReviewRating>.from(json["review_ratings"].map((x) => ReviewRating.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "logo": logo == null ? null : logo,
        "city": city == null ? null : city,
        "relativeLocation": relativeLocation == null ? null : relativeLocation,
        "longitude": longitude == null ? null : longitude,
        "latitude": latitude == null ? null : latitude,
        "phoneNo": phoneNo,
        "workingHours": workingHours,
        "businessLicense": businessLicense == null ? null : businessLicense,
        "tinNumber": tinNumber == null ? null : tinNumber,
        "medicalLicense": medicalLicense == null ? null : medicalLicense,
        "type": type == null ? null : type,
        "userId": userId == null ? null : userId,
        "rating": rating == null ? null : rating,
        "favorite": favorite == null ? null : favorite,
        "user": user == null ? null : user.toJson(),
        "review_ratings": reviewRatings == null ? null : List<dynamic>.from(reviewRatings.map((x) => x.toJson())),
    };
}

class ReviewRating {
    ReviewRating({
        this.id,
        this.rating,
        this.review,
        this.medicalCenterId,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    String id;
    int rating;
    String review;
    String medicalCenterId;
    String userId;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;

    factory ReviewRating.fromJson(Map<String, dynamic> json) => ReviewRating(
        id: json["id"] == null ? null : json["id"],
        rating: json["rating"] == null ? null : json["rating"],
        review: json["review"] == null ? null : json["review"],
        medicalCenterId: json["medicalCenterId"] == null ? null : json["medicalCenterId"],
        userId: json["userId"] == null ? null : json["userId"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "rating": rating == null ? null : rating,
        "review": review == null ? null : review,
        "medicalCenterId": medicalCenterId == null ? null : medicalCenterId,
        "userId": userId == null ? null : userId,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
    };
}

class User {
    User({
        this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.userGroup,
        this.isApproved,
        this.isSuspended,
        this.firebaseToken,
    });

    String id;
    dynamic firstName;
    dynamic lastName;
    String email;
    String userGroup;
    bool isApproved;
    bool isSuspended;
    dynamic firebaseToken;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"] == null ? null : json["email"],
        userGroup: json["userGroup"] == null ? null : json["userGroup"],
        isApproved: json["isApproved"] == null ? null : json["isApproved"],
        isSuspended: json["isSuspended"] == null ? null : json["isSuspended"],
        firebaseToken: json["firebaseToken"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email == null ? null : email,
        "userGroup": userGroup == null ? null : userGroup,
        "isApproved": isApproved == null ? null : isApproved,
        "isSuspended": isSuspended == null ? null : isSuspended,
        "firebaseToken": firebaseToken,
    };
}

class WorkingHoursClass {
    WorkingHoursClass({
        this.friday,
        this.monday,
        this.tuesday,
        this.thursday,
        this.wednesday,
    });

    Day friday;
    Day monday;
    Day tuesday;
    Day thursday;
    Day wednesday;

    factory WorkingHoursClass.fromJson(Map<String, dynamic> json) => WorkingHoursClass(
        friday: json["Friday"] == null ? null : Day.fromJson(json["Friday"]),
        monday: json["Monday"] == null ? null : Day.fromJson(json["Monday"]),
        tuesday: json["Tuesday"] == null ? null : Day.fromJson(json["Tuesday"]),
        thursday: json["Thursday"] == null ? null : Day.fromJson(json["Thursday"]),
        wednesday: json["Wednesday"] == null ? null : Day.fromJson(json["Wednesday"]),
    );

    Map<String, dynamic> toJson() => {
        "Friday": friday == null ? null : friday.toJson(),
        "Monday": monday == null ? null : monday.toJson(),
        "Tuesday": tuesday == null ? null : tuesday.toJson(),
        "Thursday": thursday == null ? null : thursday.toJson(),
        "Wednesday": wednesday == null ? null : wednesday.toJson(),
    };
}

class Day {
    Day({
        this.end,
        this.start,
        this.fullTime,
    });

    int end;
    int start;
    bool fullTime;

    factory Day.fromJson(Map<String, dynamic> json) => Day(
        end: json["end"] == null ? null : json["end"],
        start: json["start"] == null ? null : json["start"],
        fullTime: json["fullTime"] == null ? null : json["fullTime"],
    );

    Map<String, dynamic> toJson() => {
        "end": end == null ? null : end,
        "start": start == null ? null : start,
        "fullTime": fullTime == null ? null : fullTime,
    };
}

class Link {
    Link({
        this.url,
        this.label,
        this.active,
    });

    String url;
    dynamic label;
    bool active;

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] == null ? null : json["url"],
        label: json["label"],
        active: json["active"] == null ? null : json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "label": label,
        "active": active == null ? null : active,
    };
}
