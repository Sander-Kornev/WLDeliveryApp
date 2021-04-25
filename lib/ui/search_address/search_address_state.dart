
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wl_delivery/helper/location/geocoding_manager.dart';

part 'search_address_state.freezed.dart';

class SearchAddressState {
  List<LocationListItem> list;
  String searchField;
  LocationItem? selectedItem;

  SearchAddressState(this.list, this.searchField, [this.selectedItem]);

  bool get showMap {
    return selectedItem?.longitude != null && selectedItem?.latitude != null;
  }

  double? get latitude {
    return selectedItem?.latitude;
  }

  double? get longitude {
    return selectedItem?.longitude;
  }
}

@freezed
class LocationListItem with _$LocationListItem {
  const factory LocationListItem.currentLocation() = CurrentLocation;
  const factory LocationListItem.address(LocationItem item) = Address;

  const LocationListItem._();

  String nameValue() {
    if (this is Address) {
      return (this as Address).item.mainText;
    } else {
      return 'Current Location';
    }
  }

  String? areaNameValue() {
    if (this is Address) {
      return (this as Address).item.secondaryText;
    } else {
      return null;
    }
  }

  IconData icon() {
    if (this is Address) {
      return Icons.search;
    } else {
      return Icons.my_location_outlined;
    }
  }
}