// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'log_in_usecase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LogInParams {

 String get email; String get password; bool get rememberMe;
/// Create a copy of LogInParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LogInParamsCopyWith<LogInParams> get copyWith => _$LogInParamsCopyWithImpl<LogInParams>(this as LogInParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogInParams&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.rememberMe, rememberMe) || other.rememberMe == rememberMe));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,rememberMe);

@override
String toString() {
  return 'LogInParams(email: $email, password: $password, rememberMe: $rememberMe)';
}


}

/// @nodoc
abstract mixin class $LogInParamsCopyWith<$Res>  {
  factory $LogInParamsCopyWith(LogInParams value, $Res Function(LogInParams) _then) = _$LogInParamsCopyWithImpl;
@useResult
$Res call({
 String email, String password, bool rememberMe
});




}
/// @nodoc
class _$LogInParamsCopyWithImpl<$Res>
    implements $LogInParamsCopyWith<$Res> {
  _$LogInParamsCopyWithImpl(this._self, this._then);

  final LogInParams _self;
  final $Res Function(LogInParams) _then;

/// Create a copy of LogInParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,Object? rememberMe = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,rememberMe: null == rememberMe ? _self.rememberMe : rememberMe // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LogInParams].
extension LogInParamsPatterns on LogInParams {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LogInParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LogInParams() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LogInParams value)  $default,){
final _that = this;
switch (_that) {
case _LogInParams():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LogInParams value)?  $default,){
final _that = this;
switch (_that) {
case _LogInParams() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String password,  bool rememberMe)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LogInParams() when $default != null:
return $default(_that.email,_that.password,_that.rememberMe);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String password,  bool rememberMe)  $default,) {final _that = this;
switch (_that) {
case _LogInParams():
return $default(_that.email,_that.password,_that.rememberMe);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String password,  bool rememberMe)?  $default,) {final _that = this;
switch (_that) {
case _LogInParams() when $default != null:
return $default(_that.email,_that.password,_that.rememberMe);case _:
  return null;

}
}

}

/// @nodoc


class _LogInParams implements LogInParams {
  const _LogInParams({required this.email, required this.password, required this.rememberMe});
  

@override final  String email;
@override final  String password;
@override final  bool rememberMe;

/// Create a copy of LogInParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LogInParamsCopyWith<_LogInParams> get copyWith => __$LogInParamsCopyWithImpl<_LogInParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LogInParams&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.rememberMe, rememberMe) || other.rememberMe == rememberMe));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,rememberMe);

@override
String toString() {
  return 'LogInParams(email: $email, password: $password, rememberMe: $rememberMe)';
}


}

/// @nodoc
abstract mixin class _$LogInParamsCopyWith<$Res> implements $LogInParamsCopyWith<$Res> {
  factory _$LogInParamsCopyWith(_LogInParams value, $Res Function(_LogInParams) _then) = __$LogInParamsCopyWithImpl;
@override @useResult
$Res call({
 String email, String password, bool rememberMe
});




}
/// @nodoc
class __$LogInParamsCopyWithImpl<$Res>
    implements _$LogInParamsCopyWith<$Res> {
  __$LogInParamsCopyWithImpl(this._self, this._then);

  final _LogInParams _self;
  final $Res Function(_LogInParams) _then;

/// Create a copy of LogInParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? rememberMe = null,}) {
  return _then(_LogInParams(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,rememberMe: null == rememberMe ? _self.rememberMe : rememberMe // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
