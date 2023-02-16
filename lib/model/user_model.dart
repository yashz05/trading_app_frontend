class user_model {
  bool? error;
  String? uid;
  String? firstName;
  String? lastName;

  user_model({this.error, this.uid, this.firstName, this.lastName});

  user_model.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    uid = json['uid'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['uid'] = this.uid;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}
