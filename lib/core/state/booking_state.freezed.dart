// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BookingState<T> {
  bool get showButtonEnable => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool showButtonEnable) initial,
    required TResult Function(
      List<VehicleOrder> vehicles,
      bool showButtonEnable,
    )
    selectVehicle,
    required TResult Function(bool showButtonEnable) inProgress,
    required TResult Function(bool showButtonEnable) cancel,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool showButtonEnable)? initial,
    TResult? Function(List<VehicleOrder> vehicles, bool showButtonEnable)?
    selectVehicle,
    TResult? Function(bool showButtonEnable)? inProgress,
    TResult? Function(bool showButtonEnable)? cancel,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool showButtonEnable)? initial,
    TResult Function(List<VehicleOrder> vehicles, bool showButtonEnable)?
    selectVehicle,
    TResult Function(bool showButtonEnable)? inProgress,
    TResult Function(bool showButtonEnable)? cancel,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(_SelectVehicle<T> value) selectVehicle,
    required TResult Function(_Confirm<T> value) inProgress,
    required TResult Function(_Cancel<T> value) cancel,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(_SelectVehicle<T> value)? selectVehicle,
    TResult? Function(_Confirm<T> value)? inProgress,
    TResult? Function(_Cancel<T> value)? cancel,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(_SelectVehicle<T> value)? selectVehicle,
    TResult Function(_Confirm<T> value)? inProgress,
    TResult Function(_Cancel<T> value)? cancel,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingStateCopyWith<T, BookingState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingStateCopyWith<T, $Res> {
  factory $BookingStateCopyWith(
    BookingState<T> value,
    $Res Function(BookingState<T>) then,
  ) = _$BookingStateCopyWithImpl<T, $Res, BookingState<T>>;
  @useResult
  $Res call({bool showButtonEnable});
}

/// @nodoc
class _$BookingStateCopyWithImpl<T, $Res, $Val extends BookingState<T>>
    implements $BookingStateCopyWith<T, $Res> {
  _$BookingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? showButtonEnable = null}) {
    return _then(
      _value.copyWith(
            showButtonEnable: null == showButtonEnable
                ? _value.showButtonEnable
                : showButtonEnable // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<T, $Res>
    implements $BookingStateCopyWith<T, $Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl<T> value,
    $Res Function(_$InitialImpl<T>) then,
  ) = __$$InitialImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({bool showButtonEnable});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<T, $Res>
    extends _$BookingStateCopyWithImpl<T, $Res, _$InitialImpl<T>>
    implements _$$InitialImplCopyWith<T, $Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl<T> _value,
    $Res Function(_$InitialImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? showButtonEnable = null}) {
    return _then(
      _$InitialImpl<T>(
        showButtonEnable: null == showButtonEnable
            ? _value.showButtonEnable
            : showButtonEnable // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$InitialImpl<T> implements _Initial<T> {
  const _$InitialImpl({this.showButtonEnable = false});

  @override
  @JsonKey()
  final bool showButtonEnable;

  @override
  String toString() {
    return 'BookingState<$T>.initial(showButtonEnable: $showButtonEnable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl<T> &&
            (identical(other.showButtonEnable, showButtonEnable) ||
                other.showButtonEnable == showButtonEnable));
  }

  @override
  int get hashCode => Object.hash(runtimeType, showButtonEnable);

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<T, _$InitialImpl<T>> get copyWith =>
      __$$InitialImplCopyWithImpl<T, _$InitialImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool showButtonEnable) initial,
    required TResult Function(
      List<VehicleOrder> vehicles,
      bool showButtonEnable,
    )
    selectVehicle,
    required TResult Function(bool showButtonEnable) inProgress,
    required TResult Function(bool showButtonEnable) cancel,
  }) {
    return initial(showButtonEnable);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool showButtonEnable)? initial,
    TResult? Function(List<VehicleOrder> vehicles, bool showButtonEnable)?
    selectVehicle,
    TResult? Function(bool showButtonEnable)? inProgress,
    TResult? Function(bool showButtonEnable)? cancel,
  }) {
    return initial?.call(showButtonEnable);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool showButtonEnable)? initial,
    TResult Function(List<VehicleOrder> vehicles, bool showButtonEnable)?
    selectVehicle,
    TResult Function(bool showButtonEnable)? inProgress,
    TResult Function(bool showButtonEnable)? cancel,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(showButtonEnable);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(_SelectVehicle<T> value) selectVehicle,
    required TResult Function(_Confirm<T> value) inProgress,
    required TResult Function(_Cancel<T> value) cancel,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(_SelectVehicle<T> value)? selectVehicle,
    TResult? Function(_Confirm<T> value)? inProgress,
    TResult? Function(_Cancel<T> value)? cancel,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(_SelectVehicle<T> value)? selectVehicle,
    TResult Function(_Confirm<T> value)? inProgress,
    TResult Function(_Cancel<T> value)? cancel,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial<T> implements BookingState<T> {
  const factory _Initial({final bool showButtonEnable}) = _$InitialImpl<T>;

  @override
  bool get showButtonEnable;

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<T, _$InitialImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectVehicleImplCopyWith<T, $Res>
    implements $BookingStateCopyWith<T, $Res> {
  factory _$$SelectVehicleImplCopyWith(
    _$SelectVehicleImpl<T> value,
    $Res Function(_$SelectVehicleImpl<T>) then,
  ) = __$$SelectVehicleImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({List<VehicleOrder> vehicles, bool showButtonEnable});
}

/// @nodoc
class __$$SelectVehicleImplCopyWithImpl<T, $Res>
    extends _$BookingStateCopyWithImpl<T, $Res, _$SelectVehicleImpl<T>>
    implements _$$SelectVehicleImplCopyWith<T, $Res> {
  __$$SelectVehicleImplCopyWithImpl(
    _$SelectVehicleImpl<T> _value,
    $Res Function(_$SelectVehicleImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? vehicles = null, Object? showButtonEnable = null}) {
    return _then(
      _$SelectVehicleImpl<T>(
        null == vehicles
            ? _value._vehicles
            : vehicles // ignore: cast_nullable_to_non_nullable
                  as List<VehicleOrder>,
        showButtonEnable: null == showButtonEnable
            ? _value.showButtonEnable
            : showButtonEnable // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$SelectVehicleImpl<T> implements _SelectVehicle<T> {
  const _$SelectVehicleImpl(
    final List<VehicleOrder> vehicles, {
    this.showButtonEnable = false,
  }) : _vehicles = vehicles;

  final List<VehicleOrder> _vehicles;
  @override
  List<VehicleOrder> get vehicles {
    if (_vehicles is EqualUnmodifiableListView) return _vehicles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vehicles);
  }

  @override
  @JsonKey()
  final bool showButtonEnable;

  @override
  String toString() {
    return 'BookingState<$T>.selectVehicle(vehicles: $vehicles, showButtonEnable: $showButtonEnable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectVehicleImpl<T> &&
            const DeepCollectionEquality().equals(other._vehicles, _vehicles) &&
            (identical(other.showButtonEnable, showButtonEnable) ||
                other.showButtonEnable == showButtonEnable));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_vehicles),
    showButtonEnable,
  );

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectVehicleImplCopyWith<T, _$SelectVehicleImpl<T>> get copyWith =>
      __$$SelectVehicleImplCopyWithImpl<T, _$SelectVehicleImpl<T>>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool showButtonEnable) initial,
    required TResult Function(
      List<VehicleOrder> vehicles,
      bool showButtonEnable,
    )
    selectVehicle,
    required TResult Function(bool showButtonEnable) inProgress,
    required TResult Function(bool showButtonEnable) cancel,
  }) {
    return selectVehicle(vehicles, showButtonEnable);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool showButtonEnable)? initial,
    TResult? Function(List<VehicleOrder> vehicles, bool showButtonEnable)?
    selectVehicle,
    TResult? Function(bool showButtonEnable)? inProgress,
    TResult? Function(bool showButtonEnable)? cancel,
  }) {
    return selectVehicle?.call(vehicles, showButtonEnable);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool showButtonEnable)? initial,
    TResult Function(List<VehicleOrder> vehicles, bool showButtonEnable)?
    selectVehicle,
    TResult Function(bool showButtonEnable)? inProgress,
    TResult Function(bool showButtonEnable)? cancel,
    required TResult orElse(),
  }) {
    if (selectVehicle != null) {
      return selectVehicle(vehicles, showButtonEnable);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(_SelectVehicle<T> value) selectVehicle,
    required TResult Function(_Confirm<T> value) inProgress,
    required TResult Function(_Cancel<T> value) cancel,
  }) {
    return selectVehicle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(_SelectVehicle<T> value)? selectVehicle,
    TResult? Function(_Confirm<T> value)? inProgress,
    TResult? Function(_Cancel<T> value)? cancel,
  }) {
    return selectVehicle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(_SelectVehicle<T> value)? selectVehicle,
    TResult Function(_Confirm<T> value)? inProgress,
    TResult Function(_Cancel<T> value)? cancel,
    required TResult orElse(),
  }) {
    if (selectVehicle != null) {
      return selectVehicle(this);
    }
    return orElse();
  }
}

abstract class _SelectVehicle<T> implements BookingState<T> {
  const factory _SelectVehicle(
    final List<VehicleOrder> vehicles, {
    final bool showButtonEnable,
  }) = _$SelectVehicleImpl<T>;

  List<VehicleOrder> get vehicles;
  @override
  bool get showButtonEnable;

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectVehicleImplCopyWith<T, _$SelectVehicleImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConfirmImplCopyWith<T, $Res>
    implements $BookingStateCopyWith<T, $Res> {
  factory _$$ConfirmImplCopyWith(
    _$ConfirmImpl<T> value,
    $Res Function(_$ConfirmImpl<T>) then,
  ) = __$$ConfirmImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({bool showButtonEnable});
}

/// @nodoc
class __$$ConfirmImplCopyWithImpl<T, $Res>
    extends _$BookingStateCopyWithImpl<T, $Res, _$ConfirmImpl<T>>
    implements _$$ConfirmImplCopyWith<T, $Res> {
  __$$ConfirmImplCopyWithImpl(
    _$ConfirmImpl<T> _value,
    $Res Function(_$ConfirmImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? showButtonEnable = null}) {
    return _then(
      _$ConfirmImpl<T>(
        showButtonEnable: null == showButtonEnable
            ? _value.showButtonEnable
            : showButtonEnable // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ConfirmImpl<T> implements _Confirm<T> {
  const _$ConfirmImpl({this.showButtonEnable = false});

  @override
  @JsonKey()
  final bool showButtonEnable;

  @override
  String toString() {
    return 'BookingState<$T>.inProgress(showButtonEnable: $showButtonEnable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmImpl<T> &&
            (identical(other.showButtonEnable, showButtonEnable) ||
                other.showButtonEnable == showButtonEnable));
  }

  @override
  int get hashCode => Object.hash(runtimeType, showButtonEnable);

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmImplCopyWith<T, _$ConfirmImpl<T>> get copyWith =>
      __$$ConfirmImplCopyWithImpl<T, _$ConfirmImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool showButtonEnable) initial,
    required TResult Function(
      List<VehicleOrder> vehicles,
      bool showButtonEnable,
    )
    selectVehicle,
    required TResult Function(bool showButtonEnable) inProgress,
    required TResult Function(bool showButtonEnable) cancel,
  }) {
    return inProgress(showButtonEnable);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool showButtonEnable)? initial,
    TResult? Function(List<VehicleOrder> vehicles, bool showButtonEnable)?
    selectVehicle,
    TResult? Function(bool showButtonEnable)? inProgress,
    TResult? Function(bool showButtonEnable)? cancel,
  }) {
    return inProgress?.call(showButtonEnable);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool showButtonEnable)? initial,
    TResult Function(List<VehicleOrder> vehicles, bool showButtonEnable)?
    selectVehicle,
    TResult Function(bool showButtonEnable)? inProgress,
    TResult Function(bool showButtonEnable)? cancel,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress(showButtonEnable);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(_SelectVehicle<T> value) selectVehicle,
    required TResult Function(_Confirm<T> value) inProgress,
    required TResult Function(_Cancel<T> value) cancel,
  }) {
    return inProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(_SelectVehicle<T> value)? selectVehicle,
    TResult? Function(_Confirm<T> value)? inProgress,
    TResult? Function(_Cancel<T> value)? cancel,
  }) {
    return inProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(_SelectVehicle<T> value)? selectVehicle,
    TResult Function(_Confirm<T> value)? inProgress,
    TResult Function(_Cancel<T> value)? cancel,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress(this);
    }
    return orElse();
  }
}

abstract class _Confirm<T> implements BookingState<T> {
  const factory _Confirm({final bool showButtonEnable}) = _$ConfirmImpl<T>;

  @override
  bool get showButtonEnable;

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfirmImplCopyWith<T, _$ConfirmImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CancelImplCopyWith<T, $Res>
    implements $BookingStateCopyWith<T, $Res> {
  factory _$$CancelImplCopyWith(
    _$CancelImpl<T> value,
    $Res Function(_$CancelImpl<T>) then,
  ) = __$$CancelImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({bool showButtonEnable});
}

/// @nodoc
class __$$CancelImplCopyWithImpl<T, $Res>
    extends _$BookingStateCopyWithImpl<T, $Res, _$CancelImpl<T>>
    implements _$$CancelImplCopyWith<T, $Res> {
  __$$CancelImplCopyWithImpl(
    _$CancelImpl<T> _value,
    $Res Function(_$CancelImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? showButtonEnable = null}) {
    return _then(
      _$CancelImpl<T>(
        showButtonEnable: null == showButtonEnable
            ? _value.showButtonEnable
            : showButtonEnable // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$CancelImpl<T> implements _Cancel<T> {
  const _$CancelImpl({this.showButtonEnable = false});

  @override
  @JsonKey()
  final bool showButtonEnable;

  @override
  String toString() {
    return 'BookingState<$T>.cancel(showButtonEnable: $showButtonEnable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CancelImpl<T> &&
            (identical(other.showButtonEnable, showButtonEnable) ||
                other.showButtonEnable == showButtonEnable));
  }

  @override
  int get hashCode => Object.hash(runtimeType, showButtonEnable);

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CancelImplCopyWith<T, _$CancelImpl<T>> get copyWith =>
      __$$CancelImplCopyWithImpl<T, _$CancelImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool showButtonEnable) initial,
    required TResult Function(
      List<VehicleOrder> vehicles,
      bool showButtonEnable,
    )
    selectVehicle,
    required TResult Function(bool showButtonEnable) inProgress,
    required TResult Function(bool showButtonEnable) cancel,
  }) {
    return cancel(showButtonEnable);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool showButtonEnable)? initial,
    TResult? Function(List<VehicleOrder> vehicles, bool showButtonEnable)?
    selectVehicle,
    TResult? Function(bool showButtonEnable)? inProgress,
    TResult? Function(bool showButtonEnable)? cancel,
  }) {
    return cancel?.call(showButtonEnable);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool showButtonEnable)? initial,
    TResult Function(List<VehicleOrder> vehicles, bool showButtonEnable)?
    selectVehicle,
    TResult Function(bool showButtonEnable)? inProgress,
    TResult Function(bool showButtonEnable)? cancel,
    required TResult orElse(),
  }) {
    if (cancel != null) {
      return cancel(showButtonEnable);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(_SelectVehicle<T> value) selectVehicle,
    required TResult Function(_Confirm<T> value) inProgress,
    required TResult Function(_Cancel<T> value) cancel,
  }) {
    return cancel(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(_SelectVehicle<T> value)? selectVehicle,
    TResult? Function(_Confirm<T> value)? inProgress,
    TResult? Function(_Cancel<T> value)? cancel,
  }) {
    return cancel?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(_SelectVehicle<T> value)? selectVehicle,
    TResult Function(_Confirm<T> value)? inProgress,
    TResult Function(_Cancel<T> value)? cancel,
    required TResult orElse(),
  }) {
    if (cancel != null) {
      return cancel(this);
    }
    return orElse();
  }
}

abstract class _Cancel<T> implements BookingState<T> {
  const factory _Cancel({final bool showButtonEnable}) = _$CancelImpl<T>;

  @override
  bool get showButtonEnable;

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CancelImplCopyWith<T, _$CancelImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
