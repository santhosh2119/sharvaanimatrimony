class Newmember {
  Newmember({
    this.memberId,
    this.memberProfileId,
    this.status,
    this.firstName,
    this.lastName,
    this.gender,
    this.email,
    this.age,
    this.mobile,
    this.isClosed,
    this.dateOfBirth,
    this.height,
    this.education,
    this.occupation,
    this.income,
    this.profileImage,
    this.profileImageStatus,
    this.package,
    this.maritalStatus,
    this.numberOfChildern,
    this.area,
    this.onbehalf,
    this.introduction,
    this.generalRequirement,
    this.partnerage,
    this.partnerheight,
    this.partnerweight,
    this.partnermaritalstatus,
    this.withchildrenacceptables,
    this.partnerresidence,
    this.partnerreligion,
    this.partnercaste,
    this.partnersubcaste,
    this.partnercomplexions,
    this.partnereducation,
    this.partnerprofession,
    this.partnerdrinkinghabits,
    this.partnersmokinghabits,
    this.partnerdiet,
    this.partnerbodytype,
    this.partnerpersonalvalue,
    this.manglik,
    this.partneranydisability,
    this.partnermothertongue,
    this.partnerfamilyvalue,
    this.preferedCountry,
    this.preferedState,
    this.preferedStatus,
/////new one
    this.reportedBy,
    this.registrationType,
    this.nakshtram,
    this.gothram,
    this.state,
    this.city,
    this.community,
    this.region,
    this.referalCode,
    this.gothram2,
    this.count,
  });

  String memberId;
  String memberProfileId;
  String status;
  String firstName;
  dynamic lastName;
  String gender;
  String email;
  String age;
  String mobile;
  String isClosed;
  String dateOfBirth;
  String height;
  String education;
  String occupation;
  String income;
  String profileImage;
  String profileImageStatus;
  String package;
  String maritalStatus;
  String numberOfChildern;
  String area;
  String onbehalf;
  String introduction;
  String generalRequirement;
  String partnerage;
  String partnerheight;
  String partnerweight;
  String partnermaritalstatus;
  String withchildrenacceptables;
  String partnerresidence;
  String partnerreligion;
  String partnercaste;
  String partnersubcaste;
  String partnercomplexions;
  String partnereducation;
  String partnerprofession;
  String partnerdrinkinghabits;
  String partnersmokinghabits;
  String partnerdiet;
  String partnerbodytype;
  String partnerpersonalvalue;
  String manglik;
  String partneranydisability;
  String partnermothertongue;
  String partnerfamilyvalue;
  String preferedCountry;
  String preferedState;
  String preferedStatus;

//////new one
  String reportedBy;
  dynamic registrationType;
  String nakshtram;
  String gothram;
  String state;
  String city;
  String community;
  String region;
  String referalCode;
  String gothram2;
  dynamic count;

  factory Newmember.fromJson(Map<String, dynamic> json) => Newmember(
        memberId: json["member_id"],
        memberProfileId: json["member_profile_id"],
        status: json["status"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        age: json["age"],
        email: json["email"],
        mobile: json["mobile"],
        isClosed: json["is_closed"],
        dateOfBirth: json["date_of_birth"],
        height: json["height"],
        education: json["education"],
        occupation: json["occupation"],
        income: json["income"],
        profileImage: json["profile_image"],
        profileImageStatus: json["profile_image_status"],
        package: json["package"],
        maritalStatus: json["maritalStatus"],
        numberOfChildern: json["numberOfChildern"],
        area: json["area"],
        onbehalf: json["onbehalf"],
        introduction: json["introduction"],
        generalRequirement: json["generalRequirement"],
        partnerage: json["partnerage"],
        partnerheight: json["partnerheight"],
        partnerweight: json["partnerweight"],
        partnermaritalstatus: json["partnermaritalstatus"],
        withchildrenacceptables: json["withchildrenacceptables"],
        partnerresidence: json["partnerresidence"],
        partnerreligion: json["partnerreligion"],
        partnercaste: json["partnercaste"],
        partnersubcaste: json["partnersubcaste"],
        partnercomplexions: json["partnercomplexions"],
        partnereducation: json["partnereducation"],
        partnerprofession: json["partnerprofession"],
        partnerdrinkinghabits: json["partnerdrinkinghabits"],
        partnersmokinghabits: json["partnersmokinghabits"],
        partnerdiet: json["partnerdiet"],
        partnerbodytype: json["partnerbodytype"],
        partnerpersonalvalue: json["partnerpersonalvalue"],
        manglik: json["manglik"],
        partneranydisability: json["partneranydisability"],
        partnermothertongue: json["partnermothertongue"],
        partnerfamilyvalue: json["partnerfamilyvalue"],
        preferedCountry: json["preferedCountry"],
        preferedState: json["preferedState"],
        preferedStatus: json["preferedStatus"],
        ///// new
        reportedBy: json["reported_by"],
        registrationType: json["registration_type"],
        nakshtram: json["nakshtram"],
        gothram: json["gothram"],
        state: json["state"],
        city: json["city"],
        community: json["community"],
        region: json["region"],
        referalCode: json["referal_code"],
        gothram2: json["gothram2"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "member_id": memberId,
        "member_profile_id": memberProfileId,
        "status": status,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "email": email,
        "age": age,
        "mobile": mobile,
        "is_closed": isClosed,
        "date_of_birth": dateOfBirth,
        "height": height,
        "education": education,
        "occupation": occupation,
        "income": income,
        "profile_image": profileImage,
        "profile_image_status": profileImageStatus,
        "package": package,
        "maritalStatus": maritalStatus,
        "numberOfChildern": numberOfChildern,
        "area": area,
        "onbehalf": onbehalf,
        "introduction": introduction,
        "generalRequirement": generalRequirement,
        "partnerage": partnerage,
        "partnerheight": partnerheight,
        "partnerweight": partnerweight,
        "partnermaritalstatus": partnermaritalstatus,
        "withchildrenacceptables": withchildrenacceptables,
        "partnerresidence": partnerresidence,
        "partnerreligion": partnerreligion,
        "partnercaste": partnercaste,
        "partnersubcaste": partnersubcaste,
        "partnercomplexions": partnercomplexions,
        "partnereducation": partnereducation,
        "partnerprofession": partnerprofession,
        "partnerdrinkinghabits": partnerdrinkinghabits,
        "partnersmokinghabits": partnersmokinghabits,
        "partnerdiet": partnerdiet,
        "partnerbodytype": partnerbodytype,
        "partnerpersonalvalue": partnerpersonalvalue,
        "manglik": manglik,
        "partneranydisability": partneranydisability,
        "partnermothertongue": partnermothertongue,
        "partnerfamilyvalue": partnerfamilyvalue,
        "preferedCountry": preferedCountry,
        "preferedState": preferedState,
        "preferedStatus": preferedStatus,
        /////neww
        "reported_by": reportedBy,
        "registration_type": registrationType,
        "nakshtram": nakshtram,
        "gothram": gothram,
        "state": state,
        "city": city,
        "community": community,
        "region": region,
        "referal_code": referalCode,
        "gothram2": gothram2,
        "count": count,
      };
}
