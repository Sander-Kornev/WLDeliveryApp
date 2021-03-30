
import 'package:wl_delivery/model/db/models/grocery_cafe.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_state.freezed.dart';

@freezed
class MainScreenState with _$MainScreenState {
  const factory MainScreenState(List<GroceryCafe> values) = Data;
  const factory MainScreenState.loading() = Loading;
  const factory MainScreenState.error([String? message]) = ErrorDetails;
}