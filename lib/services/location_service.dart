import '../model/ride/locations.dart';
import '../data/dummy_data.dart';

class LocationService {
  // Use your mock data
  static final List<Location> _locations = fakeLocations;

  /// Get all locations
  static List<Location> getAllLocations() {
    return List<Location>.from(_locations);
  }

  /// Search locations by name or country
  static List<Location> searchLocations(String query) {
    if (query.isEmpty) return _locations;

    final lowerQuery = query.toLowerCase();

    return _locations.where((location) {
      // Search in location name
      final nameMatch = location.name.toLowerCase().contains(lowerQuery);

      // Search in country name
      final countryMatch = location.country.name.toLowerCase().contains(
        lowerQuery,
      );

      return nameMatch || countryMatch;
    }).toList();
  }

  /// Get location by exact name
  static Location? getLocationByName(String name) {
    try {
      return _locations.firstWhere(
        (location) => location.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Get locations by country
  static List<Location> getLocationsByCountry(Country country) {
    return _locations.where((location) => location.country == country).toList();
  }

  /// Get unique countries from all locations
  static List<Country> getAvailableCountries() {
    final countries = <Country>{};
    for (final location in _locations) {
      countries.add(location.country);
    }
    return countries.toList();
  }

  /// Get popular locations (first 8)
  static List<Location> getPopularLocations() {
    return _locations.take(8).toList();
  }

  /// Check if location exists
  static bool locationExists(Location location) {
    return _locations.any(
      (loc) => loc.name == location.name && loc.country == location.country,
    );
  }
}
