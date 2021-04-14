// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'cart.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CartActionTearOff {
  const _$CartActionTearOff();

  Add add(Product product) {
    return Add(
      product,
    );
  }

  Remove remove(Product product) {
    return Remove(
      product,
    );
  }

  RemoveAll removeAll(Product product) {
    return RemoveAll(
      product,
    );
  }
}

/// @nodoc
const $CartAction = _$CartActionTearOff();

/// @nodoc
mixin _$CartAction {
  Product get product => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Product product) add,
    required TResult Function(Product product) remove,
    required TResult Function(Product product) removeAll,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Product product)? add,
    TResult Function(Product product)? remove,
    TResult Function(Product product)? removeAll,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Add value) add,
    required TResult Function(Remove value) remove,
    required TResult Function(RemoveAll value) removeAll,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Add value)? add,
    TResult Function(Remove value)? remove,
    TResult Function(RemoveAll value)? removeAll,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CartActionCopyWith<CartAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartActionCopyWith<$Res> {
  factory $CartActionCopyWith(
          CartAction value, $Res Function(CartAction) then) =
      _$CartActionCopyWithImpl<$Res>;
  $Res call({Product product});
}

/// @nodoc
class _$CartActionCopyWithImpl<$Res> implements $CartActionCopyWith<$Res> {
  _$CartActionCopyWithImpl(this._value, this._then);

  final CartAction _value;
  // ignore: unused_field
  final $Res Function(CartAction) _then;

  @override
  $Res call({
    Object? product = freezed,
  }) {
    return _then(_value.copyWith(
      product: product == freezed
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
    ));
  }
}

/// @nodoc
abstract class $AddCopyWith<$Res> implements $CartActionCopyWith<$Res> {
  factory $AddCopyWith(Add value, $Res Function(Add) then) =
      _$AddCopyWithImpl<$Res>;
  @override
  $Res call({Product product});
}

/// @nodoc
class _$AddCopyWithImpl<$Res> extends _$CartActionCopyWithImpl<$Res>
    implements $AddCopyWith<$Res> {
  _$AddCopyWithImpl(Add _value, $Res Function(Add) _then)
      : super(_value, (v) => _then(v as Add));

  @override
  Add get _value => super._value as Add;

  @override
  $Res call({
    Object? product = freezed,
  }) {
    return _then(Add(
      product == freezed
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
    ));
  }
}

/// @nodoc
class _$Add implements Add {
  const _$Add(this.product);

  @override
  final Product product;

  @override
  String toString() {
    return 'CartAction.add(product: $product)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Add &&
            (identical(other.product, product) ||
                const DeepCollectionEquality().equals(other.product, product)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(product);

  @JsonKey(ignore: true)
  @override
  $AddCopyWith<Add> get copyWith => _$AddCopyWithImpl<Add>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Product product) add,
    required TResult Function(Product product) remove,
    required TResult Function(Product product) removeAll,
  }) {
    return add(product);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Product product)? add,
    TResult Function(Product product)? remove,
    TResult Function(Product product)? removeAll,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(product);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Add value) add,
    required TResult Function(Remove value) remove,
    required TResult Function(RemoveAll value) removeAll,
  }) {
    return add(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Add value)? add,
    TResult Function(Remove value)? remove,
    TResult Function(RemoveAll value)? removeAll,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(this);
    }
    return orElse();
  }
}

abstract class Add implements CartAction {
  const factory Add(Product product) = _$Add;

  @override
  Product get product => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $AddCopyWith<Add> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemoveCopyWith<$Res> implements $CartActionCopyWith<$Res> {
  factory $RemoveCopyWith(Remove value, $Res Function(Remove) then) =
      _$RemoveCopyWithImpl<$Res>;
  @override
  $Res call({Product product});
}

/// @nodoc
class _$RemoveCopyWithImpl<$Res> extends _$CartActionCopyWithImpl<$Res>
    implements $RemoveCopyWith<$Res> {
  _$RemoveCopyWithImpl(Remove _value, $Res Function(Remove) _then)
      : super(_value, (v) => _then(v as Remove));

  @override
  Remove get _value => super._value as Remove;

  @override
  $Res call({
    Object? product = freezed,
  }) {
    return _then(Remove(
      product == freezed
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
    ));
  }
}

/// @nodoc
class _$Remove implements Remove {
  const _$Remove(this.product);

  @override
  final Product product;

  @override
  String toString() {
    return 'CartAction.remove(product: $product)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Remove &&
            (identical(other.product, product) ||
                const DeepCollectionEquality().equals(other.product, product)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(product);

  @JsonKey(ignore: true)
  @override
  $RemoveCopyWith<Remove> get copyWith =>
      _$RemoveCopyWithImpl<Remove>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Product product) add,
    required TResult Function(Product product) remove,
    required TResult Function(Product product) removeAll,
  }) {
    return remove(product);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Product product)? add,
    TResult Function(Product product)? remove,
    TResult Function(Product product)? removeAll,
    required TResult orElse(),
  }) {
    if (remove != null) {
      return remove(product);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Add value) add,
    required TResult Function(Remove value) remove,
    required TResult Function(RemoveAll value) removeAll,
  }) {
    return remove(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Add value)? add,
    TResult Function(Remove value)? remove,
    TResult Function(RemoveAll value)? removeAll,
    required TResult orElse(),
  }) {
    if (remove != null) {
      return remove(this);
    }
    return orElse();
  }
}

abstract class Remove implements CartAction {
  const factory Remove(Product product) = _$Remove;

  @override
  Product get product => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $RemoveCopyWith<Remove> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemoveAllCopyWith<$Res> implements $CartActionCopyWith<$Res> {
  factory $RemoveAllCopyWith(RemoveAll value, $Res Function(RemoveAll) then) =
      _$RemoveAllCopyWithImpl<$Res>;
  @override
  $Res call({Product product});
}

/// @nodoc
class _$RemoveAllCopyWithImpl<$Res> extends _$CartActionCopyWithImpl<$Res>
    implements $RemoveAllCopyWith<$Res> {
  _$RemoveAllCopyWithImpl(RemoveAll _value, $Res Function(RemoveAll) _then)
      : super(_value, (v) => _then(v as RemoveAll));

  @override
  RemoveAll get _value => super._value as RemoveAll;

  @override
  $Res call({
    Object? product = freezed,
  }) {
    return _then(RemoveAll(
      product == freezed
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
    ));
  }
}

/// @nodoc
class _$RemoveAll implements RemoveAll {
  const _$RemoveAll(this.product);

  @override
  final Product product;

  @override
  String toString() {
    return 'CartAction.removeAll(product: $product)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RemoveAll &&
            (identical(other.product, product) ||
                const DeepCollectionEquality().equals(other.product, product)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(product);

  @JsonKey(ignore: true)
  @override
  $RemoveAllCopyWith<RemoveAll> get copyWith =>
      _$RemoveAllCopyWithImpl<RemoveAll>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Product product) add,
    required TResult Function(Product product) remove,
    required TResult Function(Product product) removeAll,
  }) {
    return removeAll(product);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Product product)? add,
    TResult Function(Product product)? remove,
    TResult Function(Product product)? removeAll,
    required TResult orElse(),
  }) {
    if (removeAll != null) {
      return removeAll(product);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Add value) add,
    required TResult Function(Remove value) remove,
    required TResult Function(RemoveAll value) removeAll,
  }) {
    return removeAll(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Add value)? add,
    TResult Function(Remove value)? remove,
    TResult Function(RemoveAll value)? removeAll,
    required TResult orElse(),
  }) {
    if (removeAll != null) {
      return removeAll(this);
    }
    return orElse();
  }
}

abstract class RemoveAll implements CartAction {
  const factory RemoveAll(Product product) = _$RemoveAll;

  @override
  Product get product => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $RemoveAllCopyWith<RemoveAll> get copyWith =>
      throw _privateConstructorUsedError;
}
