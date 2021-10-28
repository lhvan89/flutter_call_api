abstract class ResponseSerializable<T> {
  ResponseSerializable();
  T? fromJson(json);

  List<T> arrayFromJson(jsonArray) {
    List<T> arr = [];
    if (jsonArray is List<dynamic>) {
      jsonArray.forEach((json) {
        if (json is Map<String, dynamic>) {
          var obj = fromJson(json);
          if (obj != null) {
            arr.add(obj);
          }
        }
      });
    }
    return arr;
  }
}

//Success Function return data
typedef SuccessHandler<T> = Function(T? data);
//Error Function return Error code and message
typedef ErrorHandler = Function(int code, String msg);

class ServerResponse<T> {
  int code;
  String message;
  T? data;
  bool onCompleted(
      {required SuccessHandler<T> success, ErrorHandler? error}) {
    if (code == 200) {
      success(this.data);
      return true;
    } else if (error != null) {
      error(this.code, this.message);
    }
    return false;
  }
  ServerResponse({required this.code, required this.message, this.data});

  static ServerResponse parseJson(json, ResponseSerializable? target) {
    try {
      var code = json["Status"]["Code"] ?? 0;
      var msg = json["Status"]["Desc"] ?? "";
      var result = json['data'];
      if (target != null && result != null && result is Map<String, dynamic>) {
        return ServerResponse(
            code: code,
            message: msg,
            data: (result.isNotEmpty ? target.fromJson(result) : null));
      } else {
        return ServerResponse(code: code, message: msg, data: result);
      }
    } catch (e) {
      return ServerResponse(code: 500, message: "Parse object error: ${e.toString()}", data: null);
    }

  }
}

class ServerResponseArray<T> {
  int code;
  String message;
  List<T> datas = [];

  bool onCompleted(
      {required SuccessHandler<List<T>> success, ErrorHandler? error}) {
    if (code == 200) {
      success(this.datas);
      return true;
    } else if (error != null) {
      error(this.code, this.message);
    }
    return false;
  }

  ServerResponseArray(
      {required this.code, required this.message, this.datas = const []});

  static ServerResponseArray parseJson(json, ResponseSerializable? target) {
    final code = 200;//json["Status"]["Code"] ?? 0;
    final msg = "";//json["Status"]["Desc"] ?? "";
    final result = json['data'];
    try {
      if (target != null) {
        if (result != null && result is List<dynamic>) {
          final datas = target.arrayFromJson(result);
          return ServerResponseArray(code: code, message: msg, datas: datas);
        } else if (result is Map<String, dynamic>) {
          final items = result["Items"];
          return ServerResponseArray(
            code: code,
            message: msg,
            datas: (items is List<dynamic>
                ? target.arrayFromJson(items)
                : target.arrayFromJson([])),
          );
        } else {
          return ServerResponseArray(
            code: code,
            message: msg,
            datas: target.arrayFromJson([]),
          );
        }
      } else {
        return ServerResponseArray(
          code: code,
          message: msg,
          datas: result,
        );
      }
    } catch(e) {
      return ServerResponseArray(code: 500, message: "Parse object error: ${e.toString()}", datas: []);
    }

  }
}
