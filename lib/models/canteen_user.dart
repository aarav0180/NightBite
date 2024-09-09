class CanteenUser {
  CanteenUser({
    required this.image,
    required this.name,
    required this.contact,
    required this.id,
    required this.email,
    required this.pushToken,
  });
  late String image;
  late String name;
  late String contact;
  late String id;
  late String email;
  late String pushToken;

  CanteenUser.fromJson(Map<String, dynamic> json){
    image = json['image'] ?? '';
    name = json['name']?? '';
    contact = json['contact']?? '';
    id = json['id']?? '';
    email = json['email']?? '';
    pushToken = json['push_token']?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image'] = image;
    _data['name'] = name;
    _data['created_at'] = contact;
    _data['id'] = id;
    _data['email'] = email;
    _data['push_token'] = pushToken;
    return _data;
  }
}


