import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class GetListUserGroupCongViecBody {
  final String ID;
  final String groupCode;
  final int userID;
  final int donviID;
  GetListUserGroupCongViecBody({
    required this.ID,
    required this.groupCode,
    required this.userID,
    required this.donviID,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ID': ID,
      'groupCode': groupCode,
      'userID': userID,
      'donviID': donviID,
    };
  }

  factory GetListUserGroupCongViecBody.fromMap(Map<String, dynamic> map) {
    return GetListUserGroupCongViecBody(
      ID: map['ID'] as String,
      groupCode: map['groupCode'] as String,
      userID: map['userID'] as int,
      donviID: map['donviID'] as int,
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory GetListUserGroupCongViecBody.fromJson(String source) =>
      GetListUserGroupCongViecBody.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
