// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_password_usecase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChangePasswordParams {

 String get currentPassword; String get newPassword;
/// Create a copy of ChangePasswordParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangePasswordParamsCopyWith<ChangePasswordParams> get copyWith => _$ChangePasswordParamsCopyWithImpl<ChangePasswordParams>(this as ChangePasswordParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangePasswordParams&&(identical(other.currentPassword, currentPassword) || other.currentPassword == currentPassword)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword));
}


@override
int get hashCode => Object.hash(runtimeType,currentPassword,newPassword);

@override
String toString() {
  return 'ChangePasswordParams(currentPassword: $currentPassword, newPassword: $newPassword)';
}


}

/// @nodoc
abstract mixin class $ChangePasswordParamsCopyWith<$Res>  {
  factory $ChangePasswordParamsCopyWith(ChangePasswordParams value, $Res Function(ChangePasswordParams) _then) = _$ChangePasswordParamsCopyWithImpl;
@useResult
$Res call({
 String currentPassword, String newPassword
});




}
/// @nodoc
class _$ChangePasswordParamsCopyWithImpl<$Res>
    implements $ChangePasswordParamsCopyWith<$Res> {
  _$ChangePasswordParamsCopyWithImpl(this._self, this._then);

  final ChangePasswordParams _self;
  final $Res Function(ChangePasswordParams) _then;

/// Create a copy of ChangePasswordParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentPassword = null,Object? newPassword = null,}) {
  return _then(_self.copyWith(
currentPassword: null == currentPassword ? _self.currentPassword : currentPassword // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _ChangePasswordParams implements ChangePasswordParams {
  const _ChangePasswordParams({required this.currentPassword, required this.newPassword});
  

@override final  String currentPassword;
@override final  String newPassword;

/// Create a copy of ChangePasswordParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangePasswordParamsCopyWith<_ChangePasswordParams> get copyWith => __$ChangePasswordParamsCopyWithImpl<_ChangePasswordParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangePasswordParams&&(identical(other.currentPassword, currentPassword) || other.currentPassword == currentPassword)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword));
}


@override
int get hashCode => Object.hash(runtimeType,currentPassword,newPassword);

@override
String toString() {
  return 'ChangePasswordParams(currentPassword: $currentPassword, newPassword: $newPassword)';
}


}

/// @nodoc
abstract mixin class _$ChangePasswordParamsCopyWith<$Res> implements $ChangePasswordParamsCopyWith<$Res> {
  factory _$ChangePasswordParamsCopyWith(_ChangePasswordParams value, $Res Function(_ChangePasswordParams) _then) = __$ChangePasswordParamsCopyWithImpl;
@override @useResult
$Res call({
 String currentPassword, String newPassword
});




}
/// @nodoc
class __$ChangePasswordParamsCopyWithImpl<$Res>
    implements _$ChangePasswordParamsCopyWith<$Res> {
  __$ChangePasswordParamsCopyWithImpl(this._self, this._then);

  final _ChangePasswordParams _self;
  final $Res Function(_ChangePasswordParams) _then;

/// Create a copy of ChangePasswordParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentPassword = null,Object? newPassword = null,}) {
  return _then(_ChangePasswordParams(
currentPassword: null == currentPassword ? _self.currentPassword : currentPassword // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
