// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryModelImpl _$$CategoryModelImplFromJson(Map<String, dynamic> json) =>
    _$CategoryModelImpl(
      name: json['name'] as String,
      description: json['description'] as String,
      iconUrl: json['iconUrl'] as String,
      categoryId: json['categoryId'] as String,
      imageUrl: json['imageUrl'] as String? ?? "",
      subCategoryInfoList: (json['subCategoryInfoList'] as List<dynamic>)
          .map((e) => SubCategoryInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      bgColor: json['bgColor'] as String?,
      onBgColor: json['onBgColor'] as String?,
      borderColor: json['borderColor'] as String?,
    );

Map<String, dynamic> _$$CategoryModelImplToJson(_$CategoryModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'iconUrl': instance.iconUrl,
      'categoryId': instance.categoryId,
      'imageUrl': instance.imageUrl,
      'subCategoryInfoList': instance.subCategoryInfoList,
      'bgColor': instance.bgColor,
      'onBgColor': instance.onBgColor,
      'borderColor': instance.borderColor,
    };

_$SubCategoryInfoImpl _$$SubCategoryInfoImplFromJson(
  Map<String, dynamic> json,
) => _$SubCategoryInfoImpl(
  name: json['name'] as String,
  description: json['description'] as String,
  subCategoryId: json['subCategoryId'] as String,
  iconUrl: json['iconUrl'] as String,
  imageUrl: json['imageUrl'] as String?,
  hashTag: json['hashTag'] as String?,
  prompt: json['prompt'] as String?,
);

Map<String, dynamic> _$$SubCategoryInfoImplToJson(
  _$SubCategoryInfoImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'subCategoryId': instance.subCategoryId,
  'iconUrl': instance.iconUrl,
  'imageUrl': instance.imageUrl,
  'hashTag': instance.hashTag,
  'prompt': instance.prompt,
};
