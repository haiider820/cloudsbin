// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bandwidth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BandwidthImpl _$$BandwidthImplFromJson(Map<String, dynamic> json) =>
    _$BandwidthImpl(
      inGb: (json['in_gb'] as num?)?.toDouble(),
      outGb: (json['out_gb'] as num?)?.toDouble(),
      totalGb: (json['total_gb'] as num?)?.toDouble(),
      resetDay: (json['reset_day'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$BandwidthImplToJson(_$BandwidthImpl instance) =>
    <String, dynamic>{
      'in_gb': instance.inGb,
      'out_gb': instance.outGb,
      'total_gb': instance.totalGb,
      'reset_day': instance.resetDay,
    };
