class user_model {
  bool? error;
  Id? id;
  String? firstName;
  String? lastName;

  user_model({this.error, this.id, this.firstName, this.lastName});

  user_model.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    id = json['id'] != null ? new Id.fromJson(json['id']) : null;
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.id != null) {
      data['id'] = this.id!.toJson();
    }
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}

class Id {
  String? oid;

  Id({this.oid});

  Id.fromJson(Map<String, dynamic> json) {
    oid = json['$oid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$oid'] = this.oid;
    return data;
  }
}
