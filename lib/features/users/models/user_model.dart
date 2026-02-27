// user.dart
class UserModel {
  final int id;
  final String email;
  final String username;
  final Name name;
  final String phone;
  final Address address;
  final int version;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.name,
    required this.phone,
    required this.address,
    required this.version,
  });

  // Most common factory constructor you'll actually use
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      email: json['email'] as String,
      username: json['username'] as String,
      name: Name.fromJson(json['name'] as Map<String, dynamic>),
      phone: json['phone'] as String,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      version: json['__v'] as int? ?? 0,
    );
  }
}

class Name {
  final String firstname;
  final String lastname;

  Name({required this.firstname, required this.lastname});

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
    );
  }

  String get fullName => '$firstname $lastname';
}

class Address {
  final Geolocation geolocation;
  final String city;
  final String street;
  final int number;
  final String zipcode;

  Address({
    required this.geolocation,
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      geolocation: Geolocation.fromJson(
        json['geolocation'] as Map<String, dynamic>,
      ),
      city: json['city'] as String,
      street: json['street'] as String,
      number: json['number'],
      zipcode: json['zipcode'] as String,
    );
  }
}

class Geolocation {
  final double lat;
  final double long;

  Geolocation({required this.lat, required this.long});

  factory Geolocation.fromJson(Map<String, dynamic> json) {
    return Geolocation(
      lat: double.parse(json['lat'].toString()),
      long: double.parse(json['long'].toString()),
    );
  }
}
