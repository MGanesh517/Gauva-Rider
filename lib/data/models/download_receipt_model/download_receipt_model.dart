class DownloadReceiptModel {
  DownloadReceiptModel({
      this.message, 
      this.data,});

  DownloadReceiptModel.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? message;
  Data? data;
DownloadReceiptModel copyWith({  String? message,
  Data? data,
}) => DownloadReceiptModel(  message: message ?? this.message,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.url,});

  Data.fromJson(dynamic json) {
    url = json['url'];
  }
  String? url;
Data copyWith({  String? url,
}) => Data(  url: url ?? this.url,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    return map;
  }

}