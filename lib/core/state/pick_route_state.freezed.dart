// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pick_route_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PickRouteState<T> {
  LatLng get location => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LatLng location) pickupPoint,
    required TResult Function(LatLng location) dropPoint,
    required TResult Function(LatLng location) stopPoint,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LatLng location)? pickupPoint,
    TResult? Function(LatLng location)? dropPoint,
    TResult? Function(LatLng location)? stopPoint,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LatLng location)? pickupPoint,
    TResult Function(LatLng location)? dropPoint,
    TResult Function(LatLng location)? stopPoint,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PickupPoint<T> value) pickupPoint,
    required TResult Function(_DropPoint<T> value) dropPoint,
    required TResult Function(_StopPoint<T> value) stopPoint,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PickupPoint<T> value)? pickupPoint,
    TResult? Function(_DropPoint<T> value)? dropPoint,
    TResult? Function(_StopPoint<T> value)? stopPoint,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PickupPoint<T> value)? pickupPoint,
    TResult Function(_DropPoint<T> value)? dropPoint,
    TResult Function(_StopPoint<T> value)? stopPoint,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of PickRouteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PickRouteStateCopyWith<T, PickRouteState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PickRouteStateCopyWith<T, $Res> {
  factory $PickRouteStateCopyWith(
    PickRouteState<T> value,
    $Res Function(PickRouteState<T>) then,
  ) = _$PickRouteStateCopyWithImpl<T, $Res, PickRouteState<T>>;
  @useResult
  $Res call({LatLng location});
}

/// @nodoc
class _$PickRouteStateCopyWithImpl<T, $Res, $Val extends PickRouteState<T>>
    implements $PickRouteStateCopyWith<T, $Res> {
  _$PickRouteStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PickRouteState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? location = null}) {
    return _then(
      _value.copyWith(
            location: null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as LatLng,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PickupPointImplCopyWith<T, $Res>
    implements $PickRouteStateCopyWith<T, $Res> {
  factory _$$PickupPointImplCopyWith(
    _$PickupPointImpl<T> value,
    $Res Function(_$PickupPointImpl<T>) then,
  ) = __$$PickupPointImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({LatLng location});
}

/// @nodoc
class __$$PickupPointImplCopyWithImpl<T, $Res>
    extends _$PickRouteStateCopyWithImpl<T, $Res, _$PickupPointImpl<T>>
    implements _$$PickupPointImplCopyWith<T, $Res> {
  __$$PickupPointImplCopyWithImpl(
    _$PickupPointImpl<T> _value,
    $Res Function(_$PickupPointImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of PickRouteState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? location = null}) {
    return _then(
      _$PickupPointImpl<T>(
        null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as LatLng,
      ),
    );
  }
}

/// @nodoc

class _$PickupPointImpl<T> implements _PickupPoint<T> {
  const _$PickupPointImpl(this.location);

  @override
  final LatLng location;

  @override
  String toString() {
    return 'PickRouteState<$T>.pickupPoint(location: $location)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PickupPointImpl<T> &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @override
  int get hashCode => Object.hash(runtimeType, location);

  /// Create a copy of PickRouteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PickupPointImplCopyWith<T, _$PickupPointImpl<T>> get copyWith =>
      __$$PickupPointImplCopyWithImpl<T, _$PickupPointImpl<T>>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LatLng location) pickupPoint,
    required TResult Function(LatLng location) dropPoint,
    required TResult Function(LatLng location) stopPoint,
  }) {
    return pickupPoint(location);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LatLng location)? pickupPoint,
    TResult? Function(LatLng location)? dropPoint,
    TResult? Function(LatLng location)? stopPoint,
  }) {
    return pickupPoint?.call(location);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LatLng location)? pickupPoint,
    TResult Function(LatLng location)? dropPoint,
    TResult Function(LatLng location)? stopPoint,
    required TResult orElse(),
  }) {
    if (pickupPoint != null) {
      return pickupPoint(location);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PickupPoint<T> value) pickupPoint,
    required TResult Function(_DropPoint<T> value) dropPoint,
    required TResult Function(_StopPoint<T> value) stopPoint,
  }) {
    return pickupPoint(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PickupPoint<T> value)? pickupPoint,
    TResult? Function(_DropPoint<T> value)? dropPoint,
    TResult? Function(_StopPoint<T> value)? stopPoint,
  }) {
    return pickupPoint?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PickupPoint<T> value)? pickupPoint,
    TResult Function(_DropPoint<T> value)? dropPoint,
    TResult Function(_StopPoint<T> value)? stopPoint,
    required TResult orElse(),
  }) {
    if (pickupPoint != null) {
      return pickupPoint(this);
    }
    return orElse();
  }
}

abstract class _PickupPoint<T> implements PickRouteState<T> {
  const factory _PickupPoint(final LatLng location) = _$PickupPointImpl<T>;

  @override
  LatLng get location;

  /// Create a copy of PickRouteState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PickupPointImplCopyWith<T, _$PickupPointImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DropPointImplCopyWith<T, $Res>
    implements $PickRouteStateCopyWith<T, $Res> {
  factory _$$DropPointImplCopyWith(
    _$DropPointImpl<T> value,
    $Res Function(_$DropPointImpl<T>) then,
  ) = __$$DropPointImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({LatLng location});
}

/// @nodoc
class __$$DropPointImplCopyWithImpl<T, $Res>
    extends _$PickRouteStateCopyWithImpl<T, $Res, _$DropPointImpl<T>>
    implements _$$DropPointImplCopyWith<T, $Res> {
  __$$DropPointImplCopyWithImpl(
    _$DropPointImpl<T> _value,
    $Res Function(_$DropPointImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of PickRouteState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? location = null}) {
    return _then(
      _$DropPointImpl<T>(
        null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as LatLng,
      ),
    );
  }
}

/// @nodoc

class _$DropPointImpl<T> implements _DropPoint<T> {
  const _$DropPointImpl(this.location);

  @override
  final LatLng location;

  @override
  String toString() {
    return 'PickRouteState<$T>.dropPoint(location: $location)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DropPointImpl<T> &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @override
  int get hashCode => Object.hash(runtimeType, location);

  /// Create a copy of PickRouteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DropPointImplCopyWith<T, _$DropPointImpl<T>> get copyWith =>
      __$$DropPointImplCopyWithImpl<T, _$DropPointImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LatLng location) pickupPoint,
    required TResult Function(LatLng location) dropPoint,
    required TResult Function(LatLng location) stopPoint,
  }) {
    return dropPoint(location);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LatLng location)? pickupPoint,
    TResult? Function(LatLng location)? dropPoint,
    TResult? Function(LatLng location)? stopPoint,
  }) {
    return dropPoint?.call(location);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LatLng location)? pickupPoint,
    TResult Function(LatLng location)? dropPoint,
    TResult Function(LatLng location)? stopPoint,
    required TResult orElse(),
  }) {
    if (dropPoint != null) {
      return dropPoint(location);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PickupPoint<T> value) pickupPoint,
    required TResult Function(_DropPoint<T> value) dropPoint,
    required TResult Function(_StopPoint<T> value) stopPoint,
  }) {
    return dropPoint(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PickupPoint<T> value)? pickupPoint,
    TResult? Function(_DropPoint<T> value)? dropPoint,
    TResult? Function(_StopPoint<T> value)? stopPoint,
  }) {
    return dropPoint?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PickupPoint<T> value)? pickupPoint,
    TResult Function(_DropPoint<T> value)? dropPoint,
    TResult Function(_StopPoint<T> value)? stopPoint,
    required TResult orElse(),
  }) {
    if (dropPoint != null) {
      return dropPoint(this);
    }
    return orElse();
  }
}

abstract class _DropPoint<T> implements PickRouteState<T> {
  const factory _DropPoint(final LatLng location) = _$DropPointImpl<T>;

  @override
  LatLng get location;

  /// Create a copy of PickRouteState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DropPointImplCopyWith<T, _$DropPointImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StopPointImplCopyWith<T, $Res>
    implements $PickRouteStateCopyWith<T, $Res> {
  factory _$$StopPointImplCopyWith(
    _$StopPointImpl<T> value,
    $Res Function(_$StopPointImpl<T>) then,
  ) = __$$StopPointImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({LatLng location});
}

/// @nodoc
class __$$StopPointImplCopyWithImpl<T, $Res>
    extends _$PickRouteStateCopyWithImpl<T, $Res, _$StopPointImpl<T>>
    implements _$$StopPointImplCopyWith<T, $Res> {
  __$$StopPointImplCopyWithImpl(
    _$StopPointImpl<T> _value,
    $Res Function(_$StopPointImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of PickRouteState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? location = null}) {
    return _then(
      _$StopPointImpl<T>(
        null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as LatLng,
      ),
    );
  }
}

/// @nodoc

class _$StopPointImpl<T> implements _StopPoint<T> {
  const _$StopPointImpl(this.location);

  @override
  final LatLng location;

  @override
  String toString() {
    return 'PickRouteState<$T>.stopPoint(location: $location)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StopPointImpl<T> &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @override
  int get hashCode => Object.hash(runtimeType, location);

  /// Create a copy of PickRouteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StopPointImplCopyWith<T, _$StopPointImpl<T>> get copyWith =>
      __$$StopPointImplCopyWithImpl<T, _$StopPointImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LatLng location) pickupPoint,
    required TResult Function(LatLng location) dropPoint,
    required TResult Function(LatLng location) stopPoint,
  }) {
    return stopPoint(location);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LatLng location)? pickupPoint,
    TResult? Function(LatLng location)? dropPoint,
    TResult? Function(LatLng location)? stopPoint,
  }) {
    return stopPoint?.call(location);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LatLng location)? pickupPoint,
    TResult Function(LatLng location)? dropPoint,
    TResult Function(LatLng location)? stopPoint,
    required TResult orElse(),
  }) {
    if (stopPoint != null) {
      return stopPoint(location);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PickupPoint<T> value) pickupPoint,
    required TResult Function(_DropPoint<T> value) dropPoint,
    required TResult Function(_StopPoint<T> value) stopPoint,
  }) {
    return stopPoint(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PickupPoint<T> value)? pickupPoint,
    TResult? Function(_DropPoint<T> value)? dropPoint,
    TResult? Function(_StopPoint<T> value)? stopPoint,
  }) {
    return stopPoint?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PickupPoint<T> value)? pickupPoint,
    TResult Function(_DropPoint<T> value)? dropPoint,
    TResult Function(_StopPoint<T> value)? stopPoint,
    required TResult orElse(),
  }) {
    if (stopPoint != null) {
      return stopPoint(this);
    }
    return orElse();
  }
}

abstract class _StopPoint<T> implements PickRouteState<T> {
  const factory _StopPoint(final LatLng location) = _$StopPointImpl<T>;

  @override
  LatLng get location;

  /// Create a copy of PickRouteState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StopPointImplCopyWith<T, _$StopPointImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
