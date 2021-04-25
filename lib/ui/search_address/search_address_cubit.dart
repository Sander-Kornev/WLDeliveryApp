
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_delivery/helper/location/geocoding_manager.dart';
import 'package:wl_delivery/helper/location/locationManager.dart';
import 'package:wl_delivery/router/router_delegate.dart';
import 'package:wl_delivery/ui/search_address/search_address_state.dart';
import 'package:wl_delivery/extensions/optional.dart';

class SearchAddressCubit extends Cubit<SearchAddressState> {

  final locationManager = LocationManager();
  final geocodingManager = GeocodingManager();

  Completer<LocationItem> completer;
  AppRouterDelegate router;

  SearchAddressCubit(Completer<LocationItem> completer, AppRouterDelegate router):
        completer = completer,
        router = router,
        super(SearchAddressState([LocationListItem.currentLocation()], ''));

  search(String value) async {
    if (state.searchField == value) { return; }
    emit(SearchAddressState([LocationListItem.currentLocation()], value));
    final locationItems = await geocodingManager.getLocations(value);
    final items = [LocationListItem.currentLocation()] + locationItems.map((obj) => LocationListItem.address(obj)).toList();
    emit(SearchAddressState(items, state.searchField));
  }

  selectLocation(LocationItem value) async {
    var items = [LocationListItem.currentLocation(), LocationListItem.address(value)];
    emit(SearchAddressState(items, value.mainText, value));

    final newValue = await geocodingManager.getPlaceCoordinate(value);

    final locationItems = await geocodingManager.getLocations(value.mainText);
    items = [LocationListItem.currentLocation()] + locationItems.map((obj) => LocationListItem.address(obj)).toList();
    emit(SearchAddressState(items, value.mainText, newValue));
  }

  selectMyLocation() async {
    final result = await locationManager.getLocation();
    if (result != null) {
      final locationName = (await geocodingManager.getPlacemark(result.latitude!, result.longitude!)).first.name.orEmpty;
      final locationItems = await geocodingManager.getLocations(locationName);
      final items = [LocationListItem.currentLocation()] + locationItems.map((obj) => LocationListItem.address(obj)).toList();
      var myLocationItem = LocationItem(locationName)
        ..latitude = result.latitude!
        ..longitude = result.longitude!;
      emit(SearchAddressState(items, locationName, myLocationItem));
    }
  }

  changeMapLocation(double latitude, double longitude) async {
    final locationName = (await geocodingManager.getPlacemark(latitude, longitude)).first.name.orEmpty;
    var myLocationItem = LocationItem(locationName)
      ..latitude = latitude
      ..longitude = longitude;
    emit(SearchAddressState(state.list, locationName, myLocationItem));

    final locationItems = await geocodingManager.getLocations(locationName);
    final items = [LocationListItem.currentLocation()] + locationItems.map((obj) => LocationListItem.address(obj)).toList();
    emit(SearchAddressState(items, locationName, myLocationItem));
  }

  clear() {
    emit(SearchAddressState([LocationListItem.currentLocation()], ''));
  }

  save() {
    if (state.selectedItem != null) {
      completer.complete(state.selectedItem);
      router.popRoute();
    }
  }
}