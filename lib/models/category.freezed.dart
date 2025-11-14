// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) {
  return _CategoryModel.fromJson(json);
}

/// @nodoc
mixin _$CategoryModel {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get iconUrl => throw _privateConstructorUsedError;
  String get categoryId => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  List<SubCategoryInfo> get subCategoryInfoList =>
      throw _privateConstructorUsedError;
  String? get bgColor => throw _privateConstructorUsedError;
  String? get onBgColor => throw _privateConstructorUsedError;
  String? get borderColor => throw _privateConstructorUsedError;

  /// Serializes this CategoryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoryModelCopyWith<CategoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryModelCopyWith<$Res> {
  factory $CategoryModelCopyWith(
    CategoryModel value,
    $Res Function(CategoryModel) then,
  ) = _$CategoryModelCopyWithImpl<$Res, CategoryModel>;
  @useResult
  $Res call({
    String name,
    String description,
    String iconUrl,
    String categoryId,
    String? imageUrl,
    List<SubCategoryInfo> subCategoryInfoList,
    String? bgColor,
    String? onBgColor,
    String? borderColor,
  });
}

/// @nodoc
class _$CategoryModelCopyWithImpl<$Res, $Val extends CategoryModel>
    implements $CategoryModelCopyWith<$Res> {
  _$CategoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? iconUrl = null,
    Object? categoryId = null,
    Object? imageUrl = freezed,
    Object? subCategoryInfoList = null,
    Object? bgColor = freezed,
    Object? onBgColor = freezed,
    Object? borderColor = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            iconUrl: null == iconUrl
                ? _value.iconUrl
                : iconUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            subCategoryInfoList: null == subCategoryInfoList
                ? _value.subCategoryInfoList
                : subCategoryInfoList // ignore: cast_nullable_to_non_nullable
                      as List<SubCategoryInfo>,
            bgColor: freezed == bgColor
                ? _value.bgColor
                : bgColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            onBgColor: freezed == onBgColor
                ? _value.onBgColor
                : onBgColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            borderColor: freezed == borderColor
                ? _value.borderColor
                : borderColor // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CategoryModelImplCopyWith<$Res>
    implements $CategoryModelCopyWith<$Res> {
  factory _$$CategoryModelImplCopyWith(
    _$CategoryModelImpl value,
    $Res Function(_$CategoryModelImpl) then,
  ) = __$$CategoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String description,
    String iconUrl,
    String categoryId,
    String? imageUrl,
    List<SubCategoryInfo> subCategoryInfoList,
    String? bgColor,
    String? onBgColor,
    String? borderColor,
  });
}

/// @nodoc
class __$$CategoryModelImplCopyWithImpl<$Res>
    extends _$CategoryModelCopyWithImpl<$Res, _$CategoryModelImpl>
    implements _$$CategoryModelImplCopyWith<$Res> {
  __$$CategoryModelImplCopyWithImpl(
    _$CategoryModelImpl _value,
    $Res Function(_$CategoryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? iconUrl = null,
    Object? categoryId = null,
    Object? imageUrl = freezed,
    Object? subCategoryInfoList = null,
    Object? bgColor = freezed,
    Object? onBgColor = freezed,
    Object? borderColor = freezed,
  }) {
    return _then(
      _$CategoryModelImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        iconUrl: null == iconUrl
            ? _value.iconUrl
            : iconUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        subCategoryInfoList: null == subCategoryInfoList
            ? _value._subCategoryInfoList
            : subCategoryInfoList // ignore: cast_nullable_to_non_nullable
                  as List<SubCategoryInfo>,
        bgColor: freezed == bgColor
            ? _value.bgColor
            : bgColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        onBgColor: freezed == onBgColor
            ? _value.onBgColor
            : onBgColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        borderColor: freezed == borderColor
            ? _value.borderColor
            : borderColor // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CategoryModelImpl implements _CategoryModel {
  const _$CategoryModelImpl({
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.categoryId,
    this.imageUrl = "",
    required final List<SubCategoryInfo> subCategoryInfoList,
    this.bgColor,
    this.onBgColor,
    this.borderColor,
  }) : _subCategoryInfoList = subCategoryInfoList;

  factory _$CategoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryModelImplFromJson(json);

  @override
  final String name;
  @override
  final String description;
  @override
  final String iconUrl;
  @override
  final String categoryId;
  @override
  @JsonKey()
  final String? imageUrl;
  final List<SubCategoryInfo> _subCategoryInfoList;
  @override
  List<SubCategoryInfo> get subCategoryInfoList {
    if (_subCategoryInfoList is EqualUnmodifiableListView)
      return _subCategoryInfoList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subCategoryInfoList);
  }

  @override
  final String? bgColor;
  @override
  final String? onBgColor;
  @override
  final String? borderColor;

  @override
  String toString() {
    return 'CategoryModel(name: $name, description: $description, iconUrl: $iconUrl, categoryId: $categoryId, imageUrl: $imageUrl, subCategoryInfoList: $subCategoryInfoList, bgColor: $bgColor, onBgColor: $onBgColor, borderColor: $borderColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(
              other._subCategoryInfoList,
              _subCategoryInfoList,
            ) &&
            (identical(other.bgColor, bgColor) || other.bgColor == bgColor) &&
            (identical(other.onBgColor, onBgColor) ||
                other.onBgColor == onBgColor) &&
            (identical(other.borderColor, borderColor) ||
                other.borderColor == borderColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    description,
    iconUrl,
    categoryId,
    imageUrl,
    const DeepCollectionEquality().hash(_subCategoryInfoList),
    bgColor,
    onBgColor,
    borderColor,
  );

  /// Create a copy of CategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryModelImplCopyWith<_$CategoryModelImpl> get copyWith =>
      __$$CategoryModelImplCopyWithImpl<_$CategoryModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryModelImplToJson(this);
  }
}

abstract class _CategoryModel implements CategoryModel {
  const factory _CategoryModel({
    required final String name,
    required final String description,
    required final String iconUrl,
    required final String categoryId,
    final String? imageUrl,
    required final List<SubCategoryInfo> subCategoryInfoList,
    final String? bgColor,
    final String? onBgColor,
    final String? borderColor,
  }) = _$CategoryModelImpl;

  factory _CategoryModel.fromJson(Map<String, dynamic> json) =
      _$CategoryModelImpl.fromJson;

  @override
  String get name;
  @override
  String get description;
  @override
  String get iconUrl;
  @override
  String get categoryId;
  @override
  String? get imageUrl;
  @override
  List<SubCategoryInfo> get subCategoryInfoList;
  @override
  String? get bgColor;
  @override
  String? get onBgColor;
  @override
  String? get borderColor;

  /// Create a copy of CategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryModelImplCopyWith<_$CategoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubCategoryInfo _$SubCategoryInfoFromJson(Map<String, dynamic> json) {
  return _SubCategoryInfo.fromJson(json);
}

/// @nodoc
mixin _$SubCategoryInfo {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get subCategoryId => throw _privateConstructorUsedError;
  String get iconUrl => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get hashTag => throw _privateConstructorUsedError;
  String? get prompt => throw _privateConstructorUsedError;

  /// Serializes this SubCategoryInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubCategoryInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubCategoryInfoCopyWith<SubCategoryInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubCategoryInfoCopyWith<$Res> {
  factory $SubCategoryInfoCopyWith(
    SubCategoryInfo value,
    $Res Function(SubCategoryInfo) then,
  ) = _$SubCategoryInfoCopyWithImpl<$Res, SubCategoryInfo>;
  @useResult
  $Res call({
    String name,
    String description,
    String subCategoryId,
    String iconUrl,
    String? imageUrl,
    String? hashTag,
    String? prompt,
  });
}

/// @nodoc
class _$SubCategoryInfoCopyWithImpl<$Res, $Val extends SubCategoryInfo>
    implements $SubCategoryInfoCopyWith<$Res> {
  _$SubCategoryInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubCategoryInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? subCategoryId = null,
    Object? iconUrl = null,
    Object? imageUrl = freezed,
    Object? hashTag = freezed,
    Object? prompt = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            subCategoryId: null == subCategoryId
                ? _value.subCategoryId
                : subCategoryId // ignore: cast_nullable_to_non_nullable
                      as String,
            iconUrl: null == iconUrl
                ? _value.iconUrl
                : iconUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            hashTag: freezed == hashTag
                ? _value.hashTag
                : hashTag // ignore: cast_nullable_to_non_nullable
                      as String?,
            prompt: freezed == prompt
                ? _value.prompt
                : prompt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubCategoryInfoImplCopyWith<$Res>
    implements $SubCategoryInfoCopyWith<$Res> {
  factory _$$SubCategoryInfoImplCopyWith(
    _$SubCategoryInfoImpl value,
    $Res Function(_$SubCategoryInfoImpl) then,
  ) = __$$SubCategoryInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String description,
    String subCategoryId,
    String iconUrl,
    String? imageUrl,
    String? hashTag,
    String? prompt,
  });
}

/// @nodoc
class __$$SubCategoryInfoImplCopyWithImpl<$Res>
    extends _$SubCategoryInfoCopyWithImpl<$Res, _$SubCategoryInfoImpl>
    implements _$$SubCategoryInfoImplCopyWith<$Res> {
  __$$SubCategoryInfoImplCopyWithImpl(
    _$SubCategoryInfoImpl _value,
    $Res Function(_$SubCategoryInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubCategoryInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? subCategoryId = null,
    Object? iconUrl = null,
    Object? imageUrl = freezed,
    Object? hashTag = freezed,
    Object? prompt = freezed,
  }) {
    return _then(
      _$SubCategoryInfoImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        subCategoryId: null == subCategoryId
            ? _value.subCategoryId
            : subCategoryId // ignore: cast_nullable_to_non_nullable
                  as String,
        iconUrl: null == iconUrl
            ? _value.iconUrl
            : iconUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        hashTag: freezed == hashTag
            ? _value.hashTag
            : hashTag // ignore: cast_nullable_to_non_nullable
                  as String?,
        prompt: freezed == prompt
            ? _value.prompt
            : prompt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubCategoryInfoImpl implements _SubCategoryInfo {
  const _$SubCategoryInfoImpl({
    required this.name,
    required this.description,
    required this.subCategoryId,
    required this.iconUrl,
    this.imageUrl,
    this.hashTag,
    this.prompt,
  });

  factory _$SubCategoryInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubCategoryInfoImplFromJson(json);

  @override
  final String name;
  @override
  final String description;
  @override
  final String subCategoryId;
  @override
  final String iconUrl;
  @override
  final String? imageUrl;
  @override
  final String? hashTag;
  @override
  final String? prompt;

  @override
  String toString() {
    return 'SubCategoryInfo(name: $name, description: $description, subCategoryId: $subCategoryId, iconUrl: $iconUrl, imageUrl: $imageUrl, hashTag: $hashTag, prompt: $prompt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubCategoryInfoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.subCategoryId, subCategoryId) ||
                other.subCategoryId == subCategoryId) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.hashTag, hashTag) || other.hashTag == hashTag) &&
            (identical(other.prompt, prompt) || other.prompt == prompt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    description,
    subCategoryId,
    iconUrl,
    imageUrl,
    hashTag,
    prompt,
  );

  /// Create a copy of SubCategoryInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubCategoryInfoImplCopyWith<_$SubCategoryInfoImpl> get copyWith =>
      __$$SubCategoryInfoImplCopyWithImpl<_$SubCategoryInfoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SubCategoryInfoImplToJson(this);
  }
}

abstract class _SubCategoryInfo implements SubCategoryInfo {
  const factory _SubCategoryInfo({
    required final String name,
    required final String description,
    required final String subCategoryId,
    required final String iconUrl,
    final String? imageUrl,
    final String? hashTag,
    final String? prompt,
  }) = _$SubCategoryInfoImpl;

  factory _SubCategoryInfo.fromJson(Map<String, dynamic> json) =
      _$SubCategoryInfoImpl.fromJson;

  @override
  String get name;
  @override
  String get description;
  @override
  String get subCategoryId;
  @override
  String get iconUrl;
  @override
  String? get imageUrl;
  @override
  String? get hashTag;
  @override
  String? get prompt;

  /// Create a copy of SubCategoryInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubCategoryInfoImplCopyWith<_$SubCategoryInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
