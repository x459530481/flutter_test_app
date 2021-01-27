// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TDCBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TDCBean _$TDCBeanFromJson(Map<String, dynamic> json) {
  return TDCBean(
    json['command'] as String,
    json['deviceCode'] as String,
    json['data'] as String,
    json['code'] as int,
    json['errMsg'] as String,
  );
}

Map<String, dynamic> _$TDCBeanToJson(TDCBean instance) {
  final val = <String, dynamic>{
    'command': instance.command,
    'deviceCode': instance.deviceCode,
    'data': instance.data,
    'code': instance.code,
    'errMsg': instance.errMsg,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data);
  writeNotNull('code', instance.code);
  writeNotNull('errMsg', instance.errMsg);
  return val;
}
