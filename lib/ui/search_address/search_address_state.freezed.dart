// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'search_address_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$LocationListItemTearOff {
  const _$LocationListItemTearOff();

  CurrentLocation currentLocation() {
    return const CurrentLocation();
  }

  Address address(LocationItem item) {
    return Address(
      item,
    );
  }
}

/// @nodoc
const $LocationListItem = _$LocationListItemTearOff();

/// @nodoc
mixin _$LocationListItem {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() currentLocation,
    required TResult Function(LocationItem item) address,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? currentLocation,
    TResult Function(LocationItem item)? address,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CurrentLocation value) currentLocation,
    required TResult Function(Address value) address,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CurrentLocation value)? currentLocation,
    TResult Function(Address value)? address,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationListItemCopyWith<$Res> {
  factory $LocationListItemCopyWith(
          LocationListItem value, $Res Function(LocationListItem) then) =
      _$LocationListItemCopyWithImpl<$Res>;
}

/// @nodoc
class _$LocationListItemCopyWithImpl<$Res>
    implements $LocationListItemCopyWith<$Res> {
  _$LocationListItemCopyWithImpl(this._value, this._then);

  final LocationListItem _value;
  // ignore: unused_field
  final $Res Function(LocationListItem) _then;
}

/// @nodoc
abstract class $CurrentLocationCopyWith<$Res> {
  factory $CurrentLocationCopyWith(
          CurrentLocation value, $Res Function(CurrentLocation) then) =
      _$CurrentLocationCopyWithImpl<$Res>;
}

/// @nodoc
class _$CurrentLocationCopyWithImpl<$Res>
    extends _$LocationListItemCopyWithImpl<$Res>
    implements $CurrentLocationCopyWith<$Res> {
  _$CurrentLocationCopyWithImpl(
      CurrentLocation _value, $Res Function(CurrentLocation) _then)
      : super(_value, (v) => _then(v as CurrentLocation));

  @override
  CurrentLocation get _value => super._value as CurrentLocation;
}

/// @nodoc
class _$CurrentLocation extends CurrentLocation {
  const _$CurrentLocation() : super._();

  @override
  String toString() {
    return 'LocationListItem.currentLocation()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is CurrentLocation);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() currentLocation,
    required TResult Function(LocationItem item) address,
  }) {
    return currentLocation();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? currentLocation,
    TResult Function(LocationItem item)? address,
    required TResult orElse(),
  }) {
    if (currentLocation != null) {
      return currentLocation();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CurrentLocation value) currentLocation,
    required TResult Function(Address value) address,
  }) {
    return currentLocation(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CurrentLocation value)? currentLocation,
    TResult Function(Address value)? address,
    required TResult orElse(),
  }) {
    if (currentLocation != null) {
      return currentLocation(this);
    }
    return orElse();
  }
}

abstract class CurrentLocation extends LocationListItem {
  const factory CurrentLocation() = _$CurrentLocation;
  const CurrentLocation._() : super._();
}

/// @nodoc
abstract class $AddressCopyWith<$Res> {
  factory $AddressCopyWith(Address value, $Res Function(Address) then) =
      _$AddressCopyWithImpl<$Res>;
  $Res call({LocationItem item});
}

/// @nodoc
class _$AddressCopyWithImpl<$Res> extends _$LocationListItemCopyWithImpl<$Res>
    implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(Address _value, $Res Function(Address) _then)
      : super(_value, (v) => _then(v as Address));

  @override
  Address get _value => super._value as Address;

  @override
  $Res call({
    Object? item = freezed,
  }) {
    return _then(Address(
      item == freezed
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as LocationItem,
    ));
  }
}

/// @nodoc
class _$Address extends Address {
  const _$Address(this.item) : super._();

  @override
  final LocationItem item;

  @override
  String toString() {
    return 'LocationListItem.address(item: $item)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Address &&
            (identical(other.item, item) ||
                const DeepCollectionEquality().equals(other.item, item)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(item);

  @JsonKey(ignore: true)
  @override
  $AddressCopyWith<Address> get copyWith =>
      _$AddressCopyWithImpl<Address>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() currentLocation,
    required TResult Function(LocationItem item) address,
  }) {
    return address(item);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? currentLocation,
    TResult Function(LocationItem item)? address,
    required TResult orElse(),
  }) {
    if (address != null) {
      return address(item);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CurrentLocation value) currentLocation,
    required TResult Function(Address value) address,
  }) {
    return address(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CurrentLocation value)? currentLocation,
    TResult Function(Address value)? address,
    required TResult orElse(),
  }) {
    if (address != null) {
      return address(this);
    }
    return orElse();
  }
}

abstract class Address extends LocationListItem {
  const factory Address(LocationItem item) = _$Address;
  const Address._() : super._();

  LocationItem get item => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddressCopyWith<Address> get copyWith => throw _privateConstructorUsedError;
}
