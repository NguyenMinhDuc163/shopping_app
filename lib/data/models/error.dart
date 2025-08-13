class Error {
  Error({
    required this.code,
    required this.messages,
  });

  int code;
  String messages;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        code: json["error_code"] ?? 0,
        messages: (json["messages"] ?? json["message"]).toString(),
      );

  Map<String, dynamic> toJson() => {
        "error_code": code,
        "messages": messages,
      };

  @override
  String toString() {
    return "code: $code, messages: $messages";
  }
}
