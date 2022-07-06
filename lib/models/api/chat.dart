class ChatModel {
  String? name;
  int? enableNotify;
  String? role;
  String? avatar;
  int? id;
  int? groupLevel;
  int? messageCount;
  int? memberCount;
  int? banCount;
  String? folder;
  int? pinnedMessageId;
  int? readCount;
  String? type;
  String? link;
  Partner? partner;
  String? partnerId;
  LastMessage? lastMessage;
  int? pinnedAt;
  int? pinnedCount;
  int? unreadCount;
  int? canSendMessage;
  Settings? settings;

  ChatModel(
      {this.name,
        this.enableNotify,
        this.role,
        this.avatar,
        this.id,
        this.groupLevel,
        this.messageCount,
        this.memberCount,
        this.banCount,
        this.folder,
        this.pinnedMessageId,
        this.readCount,
        this.type,
        this.link,
        this.partner,
        this.partnerId,
        this.lastMessage,
        this.pinnedAt,
        this.pinnedCount,
        this.unreadCount,
        this.canSendMessage,
        this.settings});

  ChatModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    enableNotify = json['enable_notify'];
    role = json['role'];
    avatar = json['avatar'];
    id = json['id'];
    groupLevel = json['group_level'];
    messageCount = json['message_count'];
    memberCount = json['member_count'];
    banCount = json['ban_count'];
    folder = json['folder'];
    pinnedMessageId = json['pinned_message_id'];
    readCount = json['read_count'];
    type = json['type'];
    link = json['link'];
    partner =
    json['partner'] != null ? Partner.fromJson(json['partner']) : null;
    partnerId = json['partner_id'];
    lastMessage = json['last_message'] != null
        ? LastMessage.fromJson(json['last_message'])
        : null;
    pinnedAt = json['pinned_at'];
    pinnedCount = json['pinned_count'];
    if (json['tags'] != null) {
      json['tags'].forEach((v) {
      });
    }
    unreadCount = json['unread_count'];
    canSendMessage = json['can_send_message'];
    settings = json['settings'] != null
        ? Settings.fromJson(json['settings'])
        : null;
  }

}

class Partner {
  String? id;
  String? name;
  String? avatar;
  int? statusVerify;
  String? type;
  int? readCount;

  Partner(
      {this.id,
        this.name,
        this.avatar,
        this.statusVerify,
        this.type,
        this.readCount});

  Partner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    statusVerify = json['status_verify'];
    type = json['type'];
    readCount = json['read_count'];
  }

}

class LastMessage {
  int? id;
  String? body;
  RawBody? rawBody;
  Sender? sender;
  int? createdAt;
  String? userId;

  LastMessage(
      {this.id,
        this.body,
        this.rawBody,
        this.sender,
        this.createdAt,
        this.userId});

  LastMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    rawBody = json['raw_body'] != null
        ? RawBody.fromJson(json['raw_body'])
        : null;
    sender =
    json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    createdAt = json['created_at'];
    userId = json['user_id'];
  }

}

class RawBody {
  String? text;
  String? type;
  Metadata? metadata;
  bool? isMarkdownText;

  RawBody(
      {this.text,
        this.type,
        this.metadata,
        this.isMarkdownText});

  RawBody.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    type = json['type'];
    isMarkdownText = json['is_markdown_text'];
  }

}

class Metadata {
  AuthInformation? authInformation;

  Metadata({this.authInformation});

  Metadata.fromJson(Map<String, dynamic> json) {
    authInformation = json['auth_information'] != null
        ? AuthInformation.fromJson(json['auth_information'])
        : null;
  }
}

class AuthInformation {
  String? deviceId;
  int? createdAt;
  String? requestIp;
  String? userAgent;

  AuthInformation(
      {this.deviceId, this.createdAt, this.requestIp, this.userAgent});

  AuthInformation.fromJson(Map<String, dynamic> json) {
    deviceId = json['device_id'];
    createdAt = json['created_at'];
    requestIp = json['request_ip'];
    userAgent = json['user_agent'];
  }

}

class Sender {
  String? id;
  String? name;
  String? avatar;
  int? statusVerify;
  String? type;

  Sender({this.id, this.name, this.avatar, this.statusVerify, this.type});

  Sender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    statusVerify = json['status_verify'];
    type = json['type'];
  }

}

class Settings {
  int? isPublic;
  int? disableMemberSendMessage;

  Settings({this.isPublic, this.disableMemberSendMessage});

  Settings.fromJson(Map<String, dynamic> json) {
    isPublic = json['is_public'];
    disableMemberSendMessage = json['disable_member_send_message'];
  }

}
