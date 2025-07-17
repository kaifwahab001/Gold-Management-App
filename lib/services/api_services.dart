import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:gold_app/config/apiconfig.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class MyApiServices {
  final storage = GetStorage();

  // client listing
  Future<dynamic> getClients() async {
    try {
      final token = storage.read('token');

      if (token == null || token
          .toString()
          .isEmpty) {
        return {
          'success': false,
          'message': 'Token not found. Please login again.',
        };
      }

      final response = await http.get(
        Uri.parse(ApiConfig.clientListing),
        headers: {'Auth-Token': token},
      );
      if (response.statusCode == 500) {
        return response.body; // Return the error HTML
      }
      // print(response.body);
      if (response.statusCode == 401 || response.statusCode == 422) {
        return {
          'success': false,
          'message': 'Authentication failed. Please login again.',
        };
      }
      print(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      // print('Error: $e');
      return {'success': false, 'message': 'Connection error'};
    }
  }

  // client listing
  Future<dynamic> getSupplier() async {
    try {
      final token = storage.read('token');

      if (token == null || token
          .toString()
          .isEmpty) {
        return {
          'success': false,
          'message': 'Token not found. Please login again.',
        };
      }

      final response = await http.get(
        Uri.parse(ApiConfig.supplierListing),
        headers: {'Auth-Token': token},
      );

      print(response.body);
      if (response.statusCode == 401 || response.statusCode == 422) {
        return {
          'success': false,
          'message': 'Authentication failed. Please login again.',
        };
      }
      if (response.statusCode == 500) {
        return {
          'success': false,
          'message': 'Server error occurred. Please try again later.',
          'error': response.body,
        };
      }
      return jsonDecode(response.body);
    } catch (e) {
      print('Error: $e');
      return {'success': false, 'message': 'Connection error'};
    }
  }


  Future<Map<String, dynamic>> createClientusingMultirequest2({
    XFile? profileImage,
    XFile? businessLogo,
    required String lastname,
    required String firstname,
    required String phone,
    // required String password,
    required String email,
    required String address,
    required String businessName,
    required String businessAddress,
  }) async {
    try {
      final token = storage.read('token');
      // final userData = storage.read('userData');
      // print(userData);
      if (token == null) {
        return {
          'success': false,
          'message': 'Token not found. Please login again.',
        };
      }

      // Use the same endpoint as getClients()
      var url = Uri.parse('${ApiConfig.base_url}/api/v1/clients');
      var request = http.MultipartRequest('POST', url);

      // Add headers
      request.headers.addAll({
        // 'Authorization': 'Bearer ${token.toString().trim()}',
        'Auth-Token': token.toString().trim(),
        'Accept': 'application/json',
      });

      // Add form fields with correct field names
      request.fields.addAll({
        'first_name': firstname,
        'last_name': lastname,
        'contact_number': phone,
        // 'password': password??'',
        // 'password_confirmation': password,
        'email': email,
        'address': address,
        'busniess_name': businessName,
        'office_address': businessAddress,
      });

      // Add files with correct field names
      // if (password != null && password.isNotEmpty) {
      //   request.fields['password'] = password;
      //   request.fields['password_confirmation'] = password;
      // }

      // Add optional profile image
      if (profileImage?.path != null) {
        try {
          request.files.add(
            await http.MultipartFile.fromPath(
              'profile_picture',
              profileImage!.path ?? '',
            ),
          );
        } catch (e) {
          print('Error adding profile picture: $e');
        }
      }

      // Add optional business logo
      if (businessLogo?.path != null) {
        try {
          request.files.add(
            await http.MultipartFile.fromPath(
              'busniess_logo',
              businessLogo!.path ?? '',
            ),
          );
        } catch (e) {
          print('Error adding business logo: $e');
        }
      }

      print('Request URL: ${request.url}');
      print('Request headers: ${request.headers}');

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 404) {
        return {
          'success': false,
          'message': 'API endpoint not found. Please check the URL.',
        };
      }

      return jsonDecode(response.body);
    } catch (e) {
      print('Error: $e');
      return {'success': false, 'message': e.toString()};
    }
  }


  /// update data in database using api
  Future<Map<String, dynamic>> UpdateClientInfo({
    XFile? profileImage,
    XFile? businessLogo,
    required String id,
    required String lastname,
    required String firstname,
    required String phone,
    String? password,
    required String email,
    required String address,
    required String businessName,
    required String businessAddress,
  }) async {
    try {
      final token = storage.read('token');
      // final userData = storage.read('userData');
      // print(userData);
      if (token == null) {
        return {
          'success': false,
          'message': 'Token not found. Please login again.',
        };
      }

      // Use the same endpoint as getClients()
      var url = Uri.parse(
        '${ApiConfig.base_url}/api/v1/clients/${int.parse(id)}',
      );
      var request = http.MultipartRequest('PATCH', url);

      // Add headers
      request.headers.addAll({
        // 'Authorization': 'Bearer ${token.toString().trim()}',
        'Auth-Token': token.toString().trim(),
        'Accept': 'application/json',
      });

      // Add form fields with correct field names
      request.fields.addAll({
        'id': id,
        'first_name': firstname,
        'last_name': lastname,
        'contact_number': phone,
        // 'password': password,
        // 'password_confirmation': password,
        'email': email,
        'address': address,
        'busniess_name': businessName,
        'office_address': businessAddress,
      });

      if (password != null && password.isNotEmpty) {
        request.fields['password'] = password;
        request.fields['password_confirmation'] = password;
      }

      // Add profile image if provided
      if (profileImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'profile_picture',
            profileImage.path,
          ),
        );
      }

      // Add business logo if provided
      if (businessLogo != null) {
        request.files.add(
          await http.MultipartFile.fromPath('busniess_logo', businessLogo.path),
        );
      }
      print('Request URL: ${request.url}');
      print('Request headers: ${request.headers}');

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 404) {
        return {
          'success': false,
          'message': 'API endpoint not found. Please check the URL.',
        };
      }

      return jsonDecode(response.body);
    } catch (e) {
      print('Error: $e');
      return {'success': false, 'message': e.toString()};
    }
  }


  /// delete client api
  Future<Map<String, dynamic>> deleteClient(int clientId) async {
    try {
      final token = storage.read('token');
      // final userData = storage.read('userData');
      print(token);
      if (token == null) {
        return {
          'success': false,
          'message': 'Token not found. Please login again.',
        };
      }

      final response = await http.delete(
        Uri.parse('${ApiConfig.base_url}/api/v1/clients/$clientId}'),
        headers: {
          'Auth-Token': token.toString().trim(),
          'Accept': 'application/json',
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'data': jsonDecode(response.body)};
      } else {
        return {'success': false, 'message': 'Failed to delete client'};
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }


  // get client details using client id for gold screen
  Future<Map<String, dynamic>> goldClientDetails(int clinetID) async {
    try {
      final token = storage.read('token');

      if (token == null || token
          .toString()
          .isEmpty) {
        return {
          'success': false,
          'message': 'Token not found. Please login again.',
        };
      }

      final response = await http.get(
        Uri.parse('${ApiConfig.goldClientData}${clinetID.toString()}'),
        headers: {'Auth-Token': token},
      );

      if (response.statusCode == 500) {
        return {
          'success': false,
          'message': 'Server error',
          'error': response.body,
        };
      }

      if (response.statusCode == 401 || response.statusCode == 422) {
        return {
          'success': false,
          'message': 'Authentication failed. Please login again.',
        };
      }

      final decodedResponse = jsonDecode(response.body);
      return {
        'success': true,
        'data': decodedResponse,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Connection error',
      };
    }
  }


  // create gold for client
  Future<Map<String, dynamic>> createGoldApi({
    String? picture,
    required String client_id,
    required String gold_type,
    required String recieved_at,
    required String deliver_at,
    required String gold_recieve,
    required String gold_given,
    required String net_weight,
    required String delivery_netWeight,
    required String tahleel,
    required String delivery_tehleel,
    required String gold_karat,
    required String rate_per_gram,
    required String total_value,
    required String supplier_id,
  }) async {
    try {
      final token = storage.read('token');
      // final userData = storage.read('userData');
      // print(userData);
      if (token == null) {
        return {
          'success': false,
          'message': 'Token not found. Please login again.',
        };
      }

      // Use the same endpoint as getClients()
      var url = Uri.parse(
        '${ApiConfig.createGoldApi}',
      );
      var request = http.MultipartRequest('POST', url);

      // Add headers
      request.headers.addAll({
        // 'Authorization': 'Bearer ${token.toString().trim()}',
        'Auth-Token': token.toString().trim(),
        'Accept': 'application/json',
      });

      // Add form fields with correct field names
      request.fields.addAll({
        'gold[client_id]': client_id,
        'gold[gold_type]': gold_type,
        'gold[recieved_at]': recieved_at,
        'gold[returned_at]': deliver_at,
        'gold[gold_recieve]': gold_recieve,
        'gold[gold_given]': gold_given,
        'gold[net_weight]': net_weight,
        'gold[returned_net_weight]': delivery_netWeight,
        'gold[tahleel]': tahleel,
        'gold[returned_tahleel]': delivery_tehleel,
        'gold[gold_karat]': gold_karat,
        'gold[rate_per_gram]': rate_per_gram,
        'gold[total_value]': total_value,
        'gold[supplier_id]': supplier_id,
      });


      // Add profile image if provided
      if (picture != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'gold[picture]',
            picture,
          ),
        );
      }


      print('Request URL: ${request.url}');
      print('Request headers: ${request.headers}');

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 404) {
        return {
          'success': false,
          'message': 'API endpoint not found. Please check the URL.',
        };
      }

      return jsonDecode(response.body);
    } catch (e) {
      print('Error: $e');
      return {'success': false, 'message': e.toString()};
    }
  }


  //update gold api
  Future<Map<String, dynamic>> updateGoldApi({
    String? picture,
    required String gold_id,
    required String client_id,
    required String gold_type,
    required String recieved_at,
    required String deliver_at,
    required String gold_recieve,
    required String gold_given,
    required String net_weight,
    required String delivery_netWeight,
    required String tahleel,
    required String delivery_tehleel,
    required String gold_karat,
    required String rate_per_gram,
    required String total_value,
    required String supplier_id,
  }) async {
    try {
      final token = storage.read('token');
      // final userData = storage.read('userData');
      // print(userData);
      if (token == null) {
        return {
          'success': false,
          'message': 'Token not found. Please login again.',
        };
      }

      // Use the same endpoint as getClients()
      var url = Uri.parse(
        '${ApiConfig.updateGoldApi}$gold_id',
      );
      var request = http.MultipartRequest('PATCH', url);

      // Add headers
      request.headers.addAll({
        // 'Authorization': 'Bearer ${token.toString().trim()}',
        'Auth-Token': token.toString().trim(),
        'Accept': 'application/json',
      });

      // Add form fields with correct field names
      request.fields.addAll({
        'gold[client_id]': client_id,
        'gold[gold_type]': gold_type,
        'gold[recieved_at]': recieved_at,
        'gold[returned_at]': deliver_at,
        'gold[gold_recieve]': gold_recieve,
        'gold[gold_given]': gold_given,
        'gold[net_weight]': net_weight,
        'gold[returned_net_weight]': delivery_netWeight,
        'gold[tahleel]': tahleel,
        'gold[returned_tahleel]': delivery_tehleel,
        'gold[gold_karat]': gold_karat,
        'gold[rate_per_gram]': rate_per_gram,
        'gold[total_value]': total_value,
        'gold[supplier_id]': supplier_id,
      });


      // Add profile image if provided
      if (picture != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'gold[picture]',
            picture,
          ),
        );
      }


      print('Request URL: ${request.url}');
      print('Request headers: ${request.headers}');

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 404) {
        return {
          'success': false,
          'message': 'API endpoint not found. Please check the URL.',
        };
      }

      return jsonDecode(response.body);
    } catch (e) {
      print('Error: $e');
      return {'success': false, 'message': e.toString()};
    }
  }


  //delete gold
  //delete gold
  Future<Map<String, dynamic>> deleteGold(int clientId) async {
    try {
      final token = storage.read('token');
      if (token == null) {
        return {
          'success': false,
          'message': 'Token not found. Please login again.',
        };
      }

      var url = Uri.parse('${ApiConfig.updateGoldApi}$clientId');
      final response = await http.delete(
        url,
        headers: {
          'Auth-Token': token.toString().trim(),
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 404) {
        return {
          'success': false,
          'message': 'API endpoint not found. Please check the URL.',
        };
      }

      return jsonDecode(response.body);
    } catch (e) {
      print('Error: $e');
      return {'success': false, 'message': e.toString()};
    }
  }


  Future<Map<String, dynamic>> getPdfFile(String clientId) async {
    try {
      final token = storage.read('token');

      if (token == null || token.toString().isEmpty) {
        return {
          'success': false,
          'message': 'Token not found. Please login again.',
        };
      }

      print(clientId);
      final url = '${ApiConfig.base_url}/api/v1/clients/$clientId/print';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Auth-Token': token,
          // 'Accept': 'application/json',
        },
      );

      print(response.body);
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': jsonDecode(response.body),
        };
      }

      return {
        'success': false,
        'message': 'Failed to download PDF file',
        'statusCode': response.statusCode,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error downloading PDF: ${e.toString()}',
      };
    }
  }


}