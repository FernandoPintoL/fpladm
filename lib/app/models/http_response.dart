class HttpResponsse {
  bool isRequest = false;
  bool success = false;
  bool messageError = false;
  dynamic message = "";
  dynamic data;

  HttpResponsse(
      {this.isRequest = false,
      this.success = false,
      this.messageError = false,
      this.message = "",
      this.data});

  HttpResponsse.fromJson(Map<String, dynamic> json)
      : isRequest = json["isRequest"],
        success = json["success"],
        messageError = json["messageError"],
        message = json["message"],
        data = json["data"];

  Map<String, dynamic> toJson() => {
        "isRequest": isRequest,
        "success": success,
        "messageError": messageError,
        "message": message,
        "data": data
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
