// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'track_order_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TrackOrderState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() chat,
    required TResult Function() lookingForDriver,
    required TResult Function() inProgress,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? chat,
    TResult? Function()? lookingForDriver,
    TResult? Function()? inProgress,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? chat,
    TResult Function()? lookingForDriver,
    TResult Function()? inProgress,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Chat<T> value) chat,
    required TResult Function(_LookingForDriver<T> value) lookingForDriver,
    required TResult Function(_InProgress<T> value) inProgress,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Chat<T> value)? chat,
    TResult? Function(_LookingForDriver<T> value)? lookingForDriver,
    TResult? Function(_InProgress<T> value)? inProgress,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Chat<T> value)? chat,
    TResult Function(_LookingForDriver<T> value)? lookingForDriver,
    TResult Function(_InProgress<T> value)? inProgress,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackOrderStateCopyWith<T, $Res> {
  factory $TrackOrderStateCopyWith(
    TrackOrderState<T> value,
    $Res Function(TrackOrderState<T>) then,
  ) = _$TrackOrderStateCopyWithImpl<T, $Res, TrackOrderState<T>>;
}

/// @nodoc
class _$TrackOrderStateCopyWithImpl<T, $Res, $Val extends TrackOrderState<T>>
    implements $TrackOrderStateCopyWith<T, $Res> {
  _$TrackOrderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrackOrderState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ChatImplCopyWith<T, $Res> {
  factory _$$ChatImplCopyWith(
    _$ChatImpl<T> value,
    $Res Function(_$ChatImpl<T>) then,
  ) = __$$ChatImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$ChatImplCopyWithImpl<T, $Res>
    extends _$TrackOrderStateCopyWithImpl<T, $Res, _$ChatImpl<T>>
    implements _$$ChatImplCopyWith<T, $Res> {
  __$$ChatImplCopyWithImpl(
    _$ChatImpl<T> _value,
    $Res Function(_$ChatImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of TrackOrderState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ChatImpl<T> implements _Chat<T> {
  const _$ChatImpl();

  @override
  String toString() {
    return 'TrackOrderState<$T>.chat()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ChatImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() chat,
    required TResult Function() lookingForDriver,
    required TResult Function() inProgress,
  }) {
    return chat();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? chat,
    TResult? Function()? lookingForDriver,
    TResult? Function()? inProgress,
  }) {
    return chat?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? chat,
    TResult Function()? lookingForDriver,
    TResult Function()? inProgress,
    required TResult orElse(),
  }) {
    if (chat != null) {
      return chat();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Chat<T> value) chat,
    required TResult Function(_LookingForDriver<T> value) lookingForDriver,
    required TResult Function(_InProgress<T> value) inProgress,
  }) {
    return chat(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Chat<T> value)? chat,
    TResult? Function(_LookingForDriver<T> value)? lookingForDriver,
    TResult? Function(_InProgress<T> value)? inProgress,
  }) {
    return chat?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Chat<T> value)? chat,
    TResult Function(_LookingForDriver<T> value)? lookingForDriver,
    TResult Function(_InProgress<T> value)? inProgress,
    required TResult orElse(),
  }) {
    if (chat != null) {
      return chat(this);
    }
    return orElse();
  }
}

abstract class _Chat<T> implements TrackOrderState<T> {
  const factory _Chat() = _$ChatImpl<T>;
}

/// @nodoc
abstract class _$$LookingForDriverImplCopyWith<T, $Res> {
  factory _$$LookingForDriverImplCopyWith(
    _$LookingForDriverImpl<T> value,
    $Res Function(_$LookingForDriverImpl<T>) then,
  ) = __$$LookingForDriverImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$LookingForDriverImplCopyWithImpl<T, $Res>
    extends _$TrackOrderStateCopyWithImpl<T, $Res, _$LookingForDriverImpl<T>>
    implements _$$LookingForDriverImplCopyWith<T, $Res> {
  __$$LookingForDriverImplCopyWithImpl(
    _$LookingForDriverImpl<T> _value,
    $Res Function(_$LookingForDriverImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of TrackOrderState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LookingForDriverImpl<T> implements _LookingForDriver<T> {
  const _$LookingForDriverImpl();

  @override
  String toString() {
    return 'TrackOrderState<$T>.lookingForDriver()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LookingForDriverImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() chat,
    required TResult Function() lookingForDriver,
    required TResult Function() inProgress,
  }) {
    return lookingForDriver();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? chat,
    TResult? Function()? lookingForDriver,
    TResult? Function()? inProgress,
  }) {
    return lookingForDriver?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? chat,
    TResult Function()? lookingForDriver,
    TResult Function()? inProgress,
    required TResult orElse(),
  }) {
    if (lookingForDriver != null) {
      return lookingForDriver();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Chat<T> value) chat,
    required TResult Function(_LookingForDriver<T> value) lookingForDriver,
    required TResult Function(_InProgress<T> value) inProgress,
  }) {
    return lookingForDriver(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Chat<T> value)? chat,
    TResult? Function(_LookingForDriver<T> value)? lookingForDriver,
    TResult? Function(_InProgress<T> value)? inProgress,
  }) {
    return lookingForDriver?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Chat<T> value)? chat,
    TResult Function(_LookingForDriver<T> value)? lookingForDriver,
    TResult Function(_InProgress<T> value)? inProgress,
    required TResult orElse(),
  }) {
    if (lookingForDriver != null) {
      return lookingForDriver(this);
    }
    return orElse();
  }
}

abstract class _LookingForDriver<T> implements TrackOrderState<T> {
  const factory _LookingForDriver() = _$LookingForDriverImpl<T>;
}

/// @nodoc
abstract class _$$InProgressImplCopyWith<T, $Res> {
  factory _$$InProgressImplCopyWith(
    _$InProgressImpl<T> value,
    $Res Function(_$InProgressImpl<T>) then,
  ) = __$$InProgressImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$InProgressImplCopyWithImpl<T, $Res>
    extends _$TrackOrderStateCopyWithImpl<T, $Res, _$InProgressImpl<T>>
    implements _$$InProgressImplCopyWith<T, $Res> {
  __$$InProgressImplCopyWithImpl(
    _$InProgressImpl<T> _value,
    $Res Function(_$InProgressImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of TrackOrderState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InProgressImpl<T> implements _InProgress<T> {
  const _$InProgressImpl();

  @override
  String toString() {
    return 'TrackOrderState<$T>.inProgress()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InProgressImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() chat,
    required TResult Function() lookingForDriver,
    required TResult Function() inProgress,
  }) {
    return inProgress();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? chat,
    TResult? Function()? lookingForDriver,
    TResult? Function()? inProgress,
  }) {
    return inProgress?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? chat,
    TResult Function()? lookingForDriver,
    TResult Function()? inProgress,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Chat<T> value) chat,
    required TResult Function(_LookingForDriver<T> value) lookingForDriver,
    required TResult Function(_InProgress<T> value) inProgress,
  }) {
    return inProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Chat<T> value)? chat,
    TResult? Function(_LookingForDriver<T> value)? lookingForDriver,
    TResult? Function(_InProgress<T> value)? inProgress,
  }) {
    return inProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Chat<T> value)? chat,
    TResult Function(_LookingForDriver<T> value)? lookingForDriver,
    TResult Function(_InProgress<T> value)? inProgress,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress(this);
    }
    return orElse();
  }
}

abstract class _InProgress<T> implements TrackOrderState<T> {
  const factory _InProgress() = _$InProgressImpl<T>;
}
