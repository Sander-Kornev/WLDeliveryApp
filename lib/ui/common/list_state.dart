
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_state.freezed.dart';

@freezed
class ListScreenState<T> with _$ListScreenState<T> {
  const factory ListScreenState.loaded(List<T> values) = Data;
  const factory ListScreenState.loading() = Loading;
  const factory ListScreenState.error([String? message]) = ErrorDetails;
}

enum ListBlocEvent {
  openDetails
}