// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_events_by_date_usecase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GetEventsByDateParams {

 DateTime get date;
/// Create a copy of GetEventsByDateParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetEventsByDateParamsCopyWith<GetEventsByDateParams> get copyWith => _$GetEventsByDateParamsCopyWithImpl<GetEventsByDateParams>(this as GetEventsByDateParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetEventsByDateParams&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,date);

@override
String toString() {
  return 'GetEventsByDateParams(date: $date)';
}


}

/// @nodoc
abstract mixin class $GetEventsByDateParamsCopyWith<$Res>  {
  factory $GetEventsByDateParamsCopyWith(GetEventsByDateParams value, $Res Function(GetEventsByDateParams) _then) = _$GetEventsByDateParamsCopyWithImpl;
@useResult
$Res call({
 DateTime date
});




}
/// @nodoc
class _$GetEventsByDateParamsCopyWithImpl<$Res>
    implements $GetEventsByDateParamsCopyWith<$Res> {
  _$GetEventsByDateParamsCopyWithImpl(this._self, this._then);

  final GetEventsByDateParams _self;
  final $Res Function(GetEventsByDateParams) _then;

/// Create a copy of GetEventsByDateParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [GetEventsByDateParams].
extension GetEventsByDateParamsPatterns on GetEventsByDateParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetEventsByDateParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetEventsByDateParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetEventsByDateParams value)  $default,){
final _that = this;
switch (_that) {
case _GetEventsByDateParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetEventsByDateParams value)?  $default,){
final _that = this;
switch (_that) {
case _GetEventsByDateParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetEventsByDateParams() when $default != null:
return $default(_that.date);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date)  $default,) {final _that = this;
switch (_that) {
case _GetEventsByDateParams():
return $default(_that.date);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date)?  $default,) {final _that = this;
switch (_that) {
case _GetEventsByDateParams() when $default != null:
return $default(_that.date);case _:
  return null;

}
}

}

/// @nodoc


class _GetEventsByDateParams implements GetEventsByDateParams {
  const _GetEventsByDateParams({required this.date});
  

@override final  DateTime date;

/// Create a copy of GetEventsByDateParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetEventsByDateParamsCopyWith<_GetEventsByDateParams> get copyWith => __$GetEventsByDateParamsCopyWithImpl<_GetEventsByDateParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetEventsByDateParams&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,date);

@override
String toString() {
  return 'GetEventsByDateParams(date: $date)';
}


}

/// @nodoc
abstract mixin class _$GetEventsByDateParamsCopyWith<$Res> implements $GetEventsByDateParamsCopyWith<$Res> {
  factory _$GetEventsByDateParamsCopyWith(_GetEventsByDateParams value, $Res Function(_GetEventsByDateParams) _then) = __$GetEventsByDateParamsCopyWithImpl;
@override @useResult
$Res call({
 DateTime date
});




}
/// @nodoc
class __$GetEventsByDateParamsCopyWithImpl<$Res>
    implements _$GetEventsByDateParamsCopyWith<$Res> {
  __$GetEventsByDateParamsCopyWithImpl(this._self, this._then);

  final _GetEventsByDateParams _self;
  final $Res Function(_GetEventsByDateParams) _then;

/// Create a copy of GetEventsByDateParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,}) {
  return _then(_GetEventsByDateParams(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
