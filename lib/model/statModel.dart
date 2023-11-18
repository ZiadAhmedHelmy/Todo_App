class statModel {
  Data? data;
  String? message;
  List<Null>? error;
  int? status;

  statModel({this.data, this.message, this.error, this.status});

  statModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    message = json['message'];
    if (json['error'] != null) {
      error = <Null>[];
      json['error'].forEach((v) { error!.add(v); });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson(Object? v) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    if (this.error != null) {
      data['error'] = this.error!.map((v) => toJson(v)).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? newTask;
  int? outdated;
  int? doing;
  int? compeleted;

  Data({this.newTask, this.outdated, this.doing, this.compeleted});

Data.fromJson(Map<String, dynamic> json) {
newTask = json['new'];
outdated = json['outdated'];
doing = json['doing'];
compeleted = json['compeleted'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = <String, dynamic>{};
data['new'] = newTask;
data['outdated'] = outdated;
data['doing'] = doing;
data['compeleted'] = compeleted;
return data;
}
}