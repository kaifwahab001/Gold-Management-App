import 'package:image_picker/image_picker.dart';

class AddClientModel {
  final String firstName;
  final String lastName;
  final String contact_number;
  final String email;
  final String address;
  final String business_name;
  final String office_address;
  final XFile bussiness_logo;
  final XFile profile_picture;
  final String password;
  final String password_confirmation;

  const AddClientModel({
    required this.firstName,
    required this.lastName,
    required this.contact_number,
    required this.address,
    required this.office_address,
    required this.email,
    required this.business_name,
    required this.bussiness_logo,
    required this.profile_picture,
    required this.password,
    required this.password_confirmation,
  });



  factory AddClientModel.fromMap(Map<String, dynamic> map) {
    return AddClientModel(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      contact_number: map['contact_number'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      business_name: map['business_name'] ?? '',
      office_address: map['office_address'] ?? '',
      bussiness_logo: map['bussiness_logo'] as XFile,
      profile_picture: map['profile_picture'] as XFile,
      password: map['password'] ?? '',
      password_confirmation: map['password_confirmation'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'contact_number': contact_number,
      'email': email,
      'address': address,
      'business_name': business_name,
      'office_address': office_address,
      'bussiness_logo': bussiness_logo,
      'profile_picture': profile_picture,
      'password': password,
      'password_confirmation': password_confirmation,
    };
  }
}
