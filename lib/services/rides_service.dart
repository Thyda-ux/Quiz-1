import '../data/dummy_data.dart';
import '../model/ride/ride.dart';
import '../model/ride/locations.dart';

class RideService {
  static final List<Ride> _rides = fakeRides;

  static List<Ride> getAllRides() {
    return List<Ride>.from(_rides);
  }

  // Filter rides by departure location
  static List<Ride> filterByDeparture(Location departure) {
    return _rides.where((ride) {
      // Exact match for location name AND country
      return ride.departureLocation.name == departure.name &&
          ride.departureLocation.country == departure.country;
    }).toList();
  }

  // Filter rides for given requested seat number
  static List<Ride> filterBySeatRequested(int seatRequested) {
    // Validate input
    if (seatRequested <= 0) {
      return [];
    }

    return _rides.where((ride) {
      return ride.remainingSeats >= seatRequested;
    }).toList();
  }

  // Flexible filter with optional criteria
  static List<Ride> filterBy({Location? departure, int? seatRequested}) {
    return _rides.where((ride) {
      // Filter by departure if provided
      if (departure != null) {
        if (ride.departureLocation.name != departure.name ||
            ride.departureLocation.country != departure.country) {
          return false;
        }
      }

      // Filter by seats if provided
      if (seatRequested != null) {
        if (seatRequested <= 0) return false;
        if (ride.remainingSeats < seatRequested) return false;
      }

      return true;
    }).toList();
  }

  /// Get total number of rides
  static int getTotalRides() {
    return _rides.length;
  }

  /// Get rides with specific departure AND arrival
  static List<Ride> getRidesByRoute(Location departure, Location arrival) {
    return _rides.where((ride) {
      return ride.departureLocation.name == departure.name &&
          ride.departureLocation.country == departure.country &&
          ride.arrivalLocation.name == arrival.name &&
          ride.arrivalLocation.country == arrival.country;
    }).toList();
  }

  /// Get upcoming rides (future dates)
  static List<Ride> getUpcomingRides() {
    final now = DateTime.now();
    return _rides.where((ride) => ride.departureDate.isAfter(now)).toList();
  }
}
