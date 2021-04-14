
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
    // let formatter = NumberFormatter()
    // formatter.numberStyle =
    // .decimal
    // formatter.maximumFractionDigits = 6
    // formatter.decimalSeparator = "."

    return {
      "address": address,
      "entrance": entrance.orEmpty,
      "floor": floor.orEmpty,
      "apartment": apartment.orEmpty,
      "latitude": 0,//formatter
          // .string(from: NSNumber(value: latitude))
          // .orEmpty,
      "longitude": 0//formatter.string(from: NSNumber(value: longitude)
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