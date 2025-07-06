// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_usecase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Params {

 String get email; String get password; String get phoneNumber; String get firstName; String get lastName;
/// Create a copy of Params
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParamsCopyWith<Params> get copyWith => _$ParamsCopyWithImpl<Params>(this as Params, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Params&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,phoneNumber,firstName,lastName);

@override
String toString() {
  return 'Params(email: $email, password: $password, phoneNumber: $phoneNumber, firstName: $firstName, lastName: $lastName)';
}


}

/// @nodoc
abstract mixin class $ParamsCopyWith<$Res>  {
  factory $ParamsCopyWith(Params value, $Res Function(Params) _then) = _$ParamsCopyWithImpl;
@useResult
$Res call({
 String email, String password, String phoneNumber, String firstName, String lastName
});




}
/// @nodoc
class _$ParamsCopyWithImpl<$Res>
    implements $ParamsCopyWith<$Res> {
  _$ParamsCopyWithImpl(this._self, this._then);

  final Params _self;
  final $Res Function(Params) _then;

/// Create a copy of Params
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,Object? phoneNumber = null,Object? firstName = null,Object? lastName = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _Params implements Params {
  const _Params({required this.email, required this.password, required this.phoneNumber, required this.firstName, required this.lastName});
  

@override final  String email;
@override final  String password;
@override final  String phoneNumber;
@override final  String firstName;
@override final  String lastName;

/// Create a copy of Params
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParamsCopyWith<_Params> get copyWith => __$ParamsCopyWithImpl<_Params>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Params&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,phoneNumber,firstName,lastName);

@override
String toString() {
  return 'Params(email: $email, password: $password, phoneNumber: $phoneNumber, firstName: $firstName, lastName: $lastName)';
}


}

/// @nodoc
abstract mixin class _$ParamsCopyWith<$Res> implements $ParamsCopyWith<$Res> {
  factory _$ParamsCopyWith(_Params value, $Res Function(_Params) _then) = __$ParamsCopyWithImpl;
@override @useResult
$Res call({
 String email, String password, String phoneNumber, String firstName, String lastName
});




}
/// @nodoc
class __$ParamsCopyWithImpl<$Res>
    implements _$ParamsCopyWith<$Res> {
  __$ParamsCopyWithImpl(this._self, this._then);

  final _Params _self;
  final $Res Function(_Params) _then;

/// Create a copy of Params
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? phoneNumber = null,Object? firstName = null,Object? lastName = null,}) {
  return _then(_Params(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
