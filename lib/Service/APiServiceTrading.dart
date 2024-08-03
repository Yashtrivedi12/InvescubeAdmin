import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invescube_admin/Provider/DataProvider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;



class ApiService {
  static const String _authorizationHeader = 'yp7280uvfkvdirgjkpo';

  static Future<void> updateStatus(
      String id, String endpoint, BuildContext context) async {
    var url = Uri.parse('https://admin.invescube.com/admin_api/$endpoint');
    var headers = {'Authorization': _authorizationHeader};

    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields['t_id'] = id
      
      ..fields['type'] = 'trading'
      ..fields['status'] = '1';

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        String newUpdate = DateTime.now().toString();

        if (endpoint.contains('update_t1')) {
          Provider.of<DataProvider>(context, listen: false)
              .updateT1Update(newUpdate);
        } else if (endpoint.contains('update_t2')) {
          Provider.of<DataProvider>(context, listen: false)
              .updateT2Update(newUpdate);
        } else if (endpoint.contains('update_t3')) {
          Provider.of<DataProvider>(context, listen: false)
              .updateT3Update(newUpdate);
        }

        Fluttertoast.showToast(
          msg: "Target Achieved successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        print('Failed to call API: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during API call: $e');
    }
  }
}
