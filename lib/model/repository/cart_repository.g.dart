// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_repository.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartObjectAdapter extends TypeAdapter<CartObject> {
  @override
  final int typeId = 1;

  @override
  CartObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartObject(
      groceryId: fields[0] as int,
      productId: fields[1] as int,
      productCount: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CartObject obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.groceryId)
      ..writeByte(1)
      ..write(obj.productId)
      ..writeByte(2)
      ..write(obj.productCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
