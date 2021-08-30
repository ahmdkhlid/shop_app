//@dart=2.9
class ShopLoginModel {
   bool status;
   String message;
   UserData data;

  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = UserData.fromJson(json['data']);
  }
}

class UserData {
   int id;
   int points;
   int credit;
   String email;
   String name;
   String phone;
   String image;
   String token;

  // UserData
  //     ({
  //   required this.id,
  //   required this.points,
  //   required this.credit,
  //   required this.email,
  //   required this.phone,
  //   required this.image,
  //   required this.token,
  // });

//named constructor

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    points = json['points'];
    credit = json['credit'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
    name = json['name'];
  }
}
