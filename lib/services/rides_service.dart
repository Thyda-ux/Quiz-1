import '../data/dummy_data.dart';
import '../model/ride/ride.dart';
import '../model/ride/locations.dart';

class RideFilterService {
  static List<Ride> availableSeats = fakeRides;

  /// Filter rides by departure, seats
  static List<Ride> filterRides({
    required List<Ride> rides,
    Location? departure,
    int? requestedSeats,
    int? minSeats,
  }) {
    return rides.where((ride) {
      // Departure location
      if (departure != null) {
        if (!_matchesLocation(ride.departureLocation, departure)) {
          return false;
        }
      }
      //Available seats
      if (minSeats != null) {
        if (ride.remainingSeats < requestedSeats!) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  static bool _matchesLocation(Location loc1, Location loc2) {
    return loc1.name == loc2.name;
  }
}
