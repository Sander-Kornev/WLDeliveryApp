
import 'package:flutter_google_places_api/flutter_google_places_api.dart' as google_places;
import 'package:flutter_google_places_api/flutter_google_places_api.dart';
import 'package:geocoding/geocoding.dart';
import 'package:wl_delivery/model/api/APIManager/api_constants.dart';

class LocationItem {
  String mainText;
  String? secondaryText;
  String? placeId;

  double? latitude;
  double? longitude;

  LocationItem(this.mainText, [this.secondaryText, this.placeId]);

  factory LocationItem.fromJson(PlacePrediction prediction) {
    return LocationItem(
        prediction.structuredFormatting.mainText,
        prediction.structuredFormatting.secondaryText,
        prediction.placeId
    );
  }
}

class GeocodingManager {

  Future<List<LocationItem>> getLocations(String value) async {
    PlaceAutocompleteResponse response = await PlaceAutocompleteRequest(
        key: APIConstants.googleApiKey,
        input: value
    ).call();

    return response.predictions.map((obj) => LocationItem.fromJson(obj)).toList();
  }

  Future<List<Placemark>> getPlacemark(double latitude, double longitude) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    return placemarks;
  }

  Future<LocationItem> getPlaceCoordinate(LocationItem item) async {
    //request returns corresponding response
    PlaceDetailsResponse response = await PlaceDetailsRequest(
        key: APIConstants.googleApiKey,
        placeId: item.placeId
    ).call();

    google_places.Location location = response.result.geometry.location;
    item.longitude = location.lng;
    item.latitude = location.lat;

    return item;
  }
}