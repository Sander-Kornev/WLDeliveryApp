
import 'package:wl_delivery/extensions/optional.dart';

class Destination {
  String address;
  String? entrance;
  String? floor;
  String? apartment;
  double latitude;
  double longitude;

  Destination({
    required this.address,
    this.entrance,
    this.floor,
    this.apartment,
    required this.latitude,
    required this.longitude
  });

  Map get apiJSON {
    return {
      "address": address,
      "entrance": entrance.orEmpty,
      "floor": floor.orEmpty,
      "apartment": apartment.orEmpty,
      "latitude": latitude.toStringAsFixed(6),
      "longitude": longitude.toStringAsFixed(6)
    };
  }

// var fullAddress: String {
// var full = address
// if let floor = floor, !floor.isEmpty {
// full.append(", flr \(floor)")
// }
// if let apartment = apartment, !apartment.isEmpty {
// full.append(", ap \(apartment)")
// }
// return full
// }
//
// var coordinate: CLLocationCoordinate2D {
//     .init(latitude: latitude, longitude: longitude)
// }
}