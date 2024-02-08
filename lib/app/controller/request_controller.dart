import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../models/http_response.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

mixin RequestController {
  String url = "http://192.168.1.22/public/api";
  Map<String, String> header = {'Content-Type': 'application/json'};

  //EJEMPLO POST
  Future<http.Response> postResponse(String route, dynamic data) async {
    try {
      Uri ruta = Uri.parse('$url/$route');
      http.Response response = await http.post(ruta,
          headers: header, body: convert.jsonEncode(data));
      return response;
    } catch (error) {
      return http.Response(error.toString(), 512);
    }
  }

  //FUNCTION GET
  Future<HttpResponsse> getResponse(String route) async {
    try {
      Uri ruta = Uri.parse('$url/$route');
      http.Response response = await http.get(ruta);
      HttpResponsse httpResponsse =
          HttpResponsse.fromJson(convert.jsonDecode(response.body));
      return httpResponsse;
    } on Exception catch (e) {
      return HttpResponsse(
          messageError: true,
          message: e.toString(),
          success: false,
          isRequest: false,
          data: []);
    }
  }

  //CARGAR FILE
  Future<HttpResponsse> subirfile(String route, File file, int id) async {
    try {
      HttpResponsse httpResponsse = HttpResponsse();
      var postUri = Uri.parse('$url/$route');
      //var postUri = Uri.parse("http://192.168.88.20/api/users/subirimage");
      var request = http.MultipartRequest("POST", postUri);
      var stream = http.ByteStream(DelegatingStream(file.openRead()));
      var length = await file.length();
      var multipartfile = await http.MultipartFile("file", stream, length,
          filename: basename(id.toString()));
      request.headers.addAll({"Content-Type": "multipart/form-data"});
      request.headers.addAll(header);
      request.files.add(multipartfile);
      request.fields['id'] = id.toString();
      var response = await request.send();
      response.stream.transform(convert.utf8.decoder).listen((value) {
        print(value);
        httpResponsse = HttpResponsse.fromJson(convert.jsonDecode(value));
      });
      return httpResponsse;
    } on Exception catch (e) {
      return HttpResponsse(
          messageError: true,
          message: e.toString(),
          success: false,
          isRequest: false,
          data: []);
    }
  }

  Future<HttpResponsse> consulta(String route, dynamic data) async {
    try {
      Uri ruta = Uri.parse('$url/$route');
      http.Response response = await http.post(ruta,
          headers: header, body: convert.jsonEncode(data));

      HttpResponsse httpResponsse =
          HttpResponsse.fromJson(convert.jsonDecode(response.body));
      return httpResponsse;
    } on Exception catch (e) {
      return HttpResponsse(
          messageError: true,
          message: e.toString(),
          success: false,
          isRequest: false,
          data: []);
    }
  }

  //INSERTAR UNA TUPLA
  Future<HttpResponsse> insertResponse(String route, dynamic data) async {
    try {
      http.Response response = await http.post(Uri.parse('$url/$route'),
          headers: header, body: convert.jsonEncode(data));
      print(response.statusCode.toString());
      print(convert.jsonDecode(response.body));
      if (response.statusCode == 200) {
        HttpResponsse httpResponsse =
            HttpResponsse.fromJson(convert.jsonDecode(response.body));
        return httpResponsse;
      } else {
        return HttpResponsse(
            messageError: true,
            message:
                "Error: ${response.statusCode.toString()} Message: ${convert.jsonDecode(response.body).toString()}",
            success: false,
            isRequest: true,
            data: "");
      }
    } on Exception catch (e) {
      return HttpResponsse(
          messageError: true,
          message: e.toString(),
          success: false,
          isRequest: false,
          data: "No se pudo completar el envio");
    }
  }

  //UPDATE TUPLA
  Future<HttpResponsse> actualizarResponse(
      String route, dynamic data, int id) async {
    try {
      print(route);
      http.Response response = await http.put(
          Uri.parse('$url/$route/${id.toString()}'),
          headers: {'Content-Type': 'application/json;charset=utf-8'},
          body: convert.jsonEncode(data));
      print(response.statusCode.toString());
      print(convert.jsonDecode(response.body));
      if (response.statusCode == 200) {
        HttpResponsse httpResponsse =
            HttpResponsse.fromJson(convert.jsonDecode(response.body));
        return httpResponsse;
      } else {
        return HttpResponsse(
            success: false,
            isRequest: true,
            message:
                "Error: ${response.statusCode.toString()} Message: ${convert.jsonDecode(response.body).toString()}",
            data: "");
      }
    } on Exception catch (e) {
      print(e.toString());
      return HttpResponsse(
          messageError: true,
          success: false,
          isRequest: false,
          message: e.toString(),
          data: "No se pudo completar el envio");
    }
  }

  //ELIMINAR UNA TUPLA
  Future<HttpResponsse> deleteResponse(String route) async {
    try {
      http.Response response =
          await http.delete(Uri.parse('$url/$route'), headers: header);
      HttpResponsse httpResponsse =
          HttpResponsse.fromJson(convert.jsonDecode(response.body));
      return httpResponsse;
    } on Exception catch (e) {
      return HttpResponsse(
          messageError: true,
          message: e.toString(),
          success: false,
          isRequest: false,
          data: "No se pudo completar el envio");
    }
  }
}
