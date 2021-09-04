/// ResponseCode : "200"
/// Result : "true"
/// ResponseMsg : "Banner List Get Successfully!!"
/// Catlist : [{"frontend_settings_id":"1","type":"home_slider_image","value":"[{\"index\":0,\"img\":\"slider_image_1.jpg\"},{\"index\":1,\"img\":\"slider_image_2.jpg\"},{\"index\":2,\"img\":\"slider_image_3.jpg\"}]","count":null}]

class Banners {
  String _responseCode;
  String _result;
  String _responseMsg;
  List<Catlist> _catlist;

  String get responseCode => _responseCode;
  String get result => _result;
  String get responseMsg => _responseMsg;
  List<Catlist> get catlist => _catlist;

  Banners({
      String responseCode, 
      String result, 
      String responseMsg, 
      List<Catlist> catlist}){
    _responseCode = responseCode;
    _result = result;
    _responseMsg = responseMsg;
    _catlist = catlist;
}

  Banners.fromJson(dynamic json) {
    _responseCode = json["ResponseCode"];
    _result = json["Result"];
    _responseMsg = json["ResponseMsg"];
    if (json["Catlist"] != null) {
      _catlist = [];
      json["Catlist"].forEach((v) {
        _catlist.add(Catlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["ResponseCode"] = _responseCode;
    map["Result"] = _result;
    map["ResponseMsg"] = _responseMsg;
    if (_catlist != null) {
      map["Catlist"] = _catlist.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// frontend_settings_id : "1"
/// type : "home_slider_image"
/// value : "[{\"index\":0,\"img\":\"slider_image_1.jpg\"},{\"index\":1,\"img\":\"slider_image_2.jpg\"},{\"index\":2,\"img\":\"slider_image_3.jpg\"}]"
/// count : null

class Catlist {
  String _frontendSettingsId;
  String _type;
  String _value;
  dynamic _count;

  String get frontendSettingsId => _frontendSettingsId;
  String get type => _type;
  String get value => _value;
  dynamic get count => _count;

  Catlist({
      String frontendSettingsId, 
      String type, 
      String value, 
      dynamic count}){
    _frontendSettingsId = frontendSettingsId;
    _type = type;
    _value = value;
    _count = count;
}

  Catlist.fromJson(dynamic json) {
    _frontendSettingsId = json["frontend_settings_id"];
    _type = json["type"];
    _value = json["value"];
    _count = json["count"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["frontend_settings_id"] = _frontendSettingsId;
    map["type"] = _type;
    map["value"] = _value;
    map["count"] = _count;
    return map;
  }

}