import '../common.dart';

class DataRequest<T extends JsonInterface> {
  T? data;
  List<T>? datas;

  DataRequest({this.data, this.datas});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (datas != null) {
      data['datas'] = datas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}