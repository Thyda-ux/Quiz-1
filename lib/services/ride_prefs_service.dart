import '../data/dummy_data.dart';
import '../model/ride_pref/ride_pref.dart';

class RidePrefsService {
  
  static final List<RidePref> _preferences = fakeRidePrefs;

  static RidePref? get currentRidePref => null;

  static get ridePrefsHistory => null;

  /// Get all preferences from mock data
  static List<RidePref> getAllPreferences() {
    return List<RidePref>.from(_preferences);
  }

  /// Save a new preference
  static void savePreference(RidePref pref) {
    _preferences.add(pref);
  }

  /// Delete a preference
  static void deletePreference(RidePref pref) {
    _preferences.remove(pref);
  }

  /// Clear all preferences
  static void clearPreferences() {
    _preferences.clear();
  }

  /// Get preferences by departure location
  static List<RidePref> getPreferencesByDeparture(String departureName) {
    return _preferences
        .where(
          (pref) => pref.departure.name.toLowerCase().contains(
            departureName.toLowerCase(),
          ),
        )
        .toList();
  }

  /// Get preferences by arrival location
  static List<RidePref> getPreferencesByArrival(String arrivalName) {
    return _preferences
        .where(
          (pref) => pref.arrival.name.toLowerCase().contains(
            arrivalName.toLowerCase(),
          ),
        )
        .toList();
  }

  /// Get recent preferences (last 7 days)
  static List<RidePref> getRecentPreferences() {
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    return _preferences
        .where((pref) => pref.departureDate.isAfter(weekAgo))
        .toList();
  }
}
