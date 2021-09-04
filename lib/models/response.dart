class ResponseData {
    ResponseData({
        this.responseCode,
        this.result,
        this.responseMsg,
    });

    String responseCode;
    String result;
    String responseMsg;

    factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
    );

    Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
    };
}
