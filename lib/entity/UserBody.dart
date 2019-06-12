
class UserResponse {

  String user_name;
  String installed_apps;
  String time_in_apps;
  String coin_count;
  int receive_notifications;
  List<Operations> operations;
  Messages messages;

  UserResponse({
    this.coin_count,
    this.installed_apps,
    this.messages,
    this.operations,
    this.receive_notifications,
    this.time_in_apps,
    this.user_name
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {

    var list = json['operations'] as List;
    List<Operations> operations = list.map((i) => Operations.fromJson(i)).toList();

    return UserResponse(
        coin_count: json["coin_count"] as String,
        installed_apps: json["installed_apps"] as String,
        messages: Messages.fromJson(json["messages"]),
        operations: operations,
        receive_notifications: json["receive_notifications"] as int,
        time_in_apps: json["time_in_apps"] as String,
        user_name: json["user_name"] as String
    );
  }

}


class Operations {

  String coin_change;
  int operation_date;
  String source_name;

  Operations({
    this.coin_change,
    this.operation_date,
    this.source_name
  });

  factory Operations.fromJson(Map<String, dynamic> json) {
    return Operations(
      coin_change: json["coin_change"] as String,
      operation_date: json["operation_date"] as int,
      source_name: json["source_name"] as String,
    );
  }

}

class Messages {

  String last_message_id;
  List<Message> messages;
  Messages({this.messages, this.last_message_id});

  factory Messages.fromJson(Map<String, dynamic> json) {
    var list = json['messages'] as List;
    List<Message> messages = list.map((i) => Message.fromJson(i)).toList();
    return Messages(
      last_message_id: json["last_message_id"] as String,
      messages: messages
    );
  }
}

class Message {
  String message_text;
  String type;
  int time_create;
  String app_id;
  Message({this.message_text, this.type, this.time_create, this.app_id});
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message_text: json["message_text"] as String,
      type: json["type"] as String,
      time_create: json["time_create"] as int,
      app_id: json["app_id"] as String,
    );
  }
}


