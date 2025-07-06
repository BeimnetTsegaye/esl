// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_grade_usecase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GradeParams {

 String? get semester;
/// Create a copy of GradeParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GradeParamsCopyWith<GradeParams> get copyWith => _$GradeParamsCopyWithImpl<GradeParams>(this as GradeParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GradeParams&&(identical(other.semester, semester) || other.semester == semester));
}


@override
int get hashCode => Object.hash(runtimeType,semester);

@override
String toString() {
  return 'GradeParams(semester: $semester)';
}


}

/// @nodoc
abstract mixin class $GradeParamsCopyWith<$Res>  {
  factory $GradeParamsCopyWith(GradeParams value, $Res Function(GradeParams) _then) = _$GradeParamsCopyWithImpl;
@useResult
$Res call({
 String? semester
});




}
/// @nodoc
class _$GradeParamsCopyWithImpl<$Res>
    implements $GradeParamsCopyWith<$Res> {
  _$GradeParamsCopyWithImpl(this._self, this._then);

  final GradeParams _self;
  final $Res Function(GradeParams) _then;

/// Create a copy of GradeParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? semester = freezed,}) {
  return _then(_self.copyWith(
semester: freezed == semester ? _self.semester : semester // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _GradeParams implements GradeParams {
  const _GradeParams({this.semester});
  

@override final  String? semester;

/// Create a copy of GradeParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GradeParamsCopyWith<_GradeParams> get copyWith => __$GradeParamsCopyWithImpl<_GradeParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GradeParams&&(identical(other.semester, semester) || other.semester == semester));
}


@override
int get hashCode => Object.hash(runtimeType,semester);

@override
String toString() {
  return 'GradeParams(semester: $semester)';
}


}

/// @nodoc
abstract mixin class _$GradeParamsCopyWith<$Res> implements $GradeParamsCopyWith<$Res> {
  factory _$GradeParamsCopyWith(_GradeParams value, $Res Function(_GradeParams) _then) = __$GradeParamsCopyWithImpl;
@override @useResult
$Res call({
 String? semester
});




}
/// @nodoc
class __$GradeParamsCopyWithImpl<$Res>
    implements _$GradeParamsCopyWith<$Res> {
  __$GradeParamsCopyWithImpl(this._self, this._then);

  final _GradeParams _self;
  final $Res Function(_GradeParams) _then;

/// Create a copy of GradeParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? semester = freezed,}) {
  return _then(_GradeParams(
semester: freezed == semester ? _self.semester : semester // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
