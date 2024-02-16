part of 'api_catch.dart';

class PayloadData {
  Future<Map?> catchPayloadData(http.Response response) async {
    debugPrint('status code payload data : ${response.statusCode.toString()}');
    dynamic jsonResponse;
    try {
      switch (response.statusCode) {
        case 200:
          final jsonResponse = json.decode(response.body);
          return jsonResponse;
        case 301:
         jsonResponse = {
            "error": true,
            "status": false,
            "statusCode": 301,
            "message": response.body
          };
          return jsonResponse;
        case 405:
         jsonResponse = {
            "error": true,
            "status": false,
            "statusCode": 301,
            "message": response.body
          };
          return jsonResponse;
        case 502:
          final jsonResponse = json.decode(response.body);
          return jsonResponse;
        case 400:
          final jsonResponse = json.decode(response.body);
          return jsonResponse;
        case 401:
          final jsonResponse = json.decode(response.body);
          return jsonResponse;
        case 403:
          jsonResponse = {
            "error": true,
            "status": false,
            "statusCode": 403,
            "message": "Forbidden"
          };
          return jsonResponse;
        case 404:
          jsonResponse = {
            "error": true,
            "status": false,
            "statusCode": 404,
            "message": "Page not found"
          };
          return jsonResponse;
        case 408:
          jsonResponse = {
            "error": true,
            "status": false,
            "statusCode": 408,
            "message": "Request timeout please try again"
          };
          return jsonResponse;
        case 500:
          jsonResponse = {
            "error": true,
            "status": false,
            "statusCode": 500,
            "message": "Internal server error"
          };
          return jsonResponse;
      }
    } on SocketException {
      Get.snackbar('Notification', 'Invalid link');
    }
    return {"error": true, "data": []};
  }
}
