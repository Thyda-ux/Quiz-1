import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../services/location_service.dart';
import '../../../model/ride/locations.dart';

class LocationPickerScreen extends StatefulWidget {
  final String initialLocation;
  final String locationType;
  final Function(Location) onLocationSelected;

  const LocationPickerScreen({
    super.key,
    required this.initialLocation,
    required this.locationType,
    required this.onLocationSelected,
  });

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late TextEditingController _searchController;
  List<Location> _searchResults = [];
  List<Location> _allLocations = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialLocation);
    _loadLocations();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadLocations() {
    setState(() => _isLoading = true);
    try {
      _allLocations = LocationService.getAllLocations();
      _searchResults = _allLocations;
      setState(() => _isLoading = false);
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _searchLocations(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = _allLocations;
      });
      return;
    }

    setState(() {
      _searchResults = _allLocations
          .where((location) =>
              location.name.toLowerCase().contains(query.toLowerCase()) ||
              location.country.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.locationType == 'from' ? 'Leaving from' : 'Going to',
          style: BlaTextStyles.title.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(BlaSpacings.l),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _searchLocations,
                decoration: InputDecoration(
                  hintText: 'Search city',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey[600]),
                          onPressed: () {
                            _searchController.clear();
                            _searchLocations('');
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: BlaSpacings.m,
                    vertical: BlaSpacings.m,
                  ),
                ),
              ),
            ),
          ),

          // Results
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                : _searchResults.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_city,
                              size: 48,
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: BlaSpacings.m),
                            Text(
                              'No cities found',
                              style: BlaTextStyles.body.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: BlaSpacings.s),
                            Text(
                              'Try searching for a different city',
                              style: BlaTextStyles.bodySmall.copyWith(
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.all(BlaSpacings.l),
                        itemCount: _searchResults.length,
                        separatorBuilder: (_, __) =>
                            SizedBox(height: BlaSpacings.s),
                        itemBuilder: (context, index) {
                          final location = _searchResults[index];

                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[200]!),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(BlaSpacings.m),
                              leading: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.location_on_outlined,
                                    color: Theme.of(context).primaryColor,
                                    size: 24,
                                  ),
                                ),
                              ),
                              title: Text(
                                location.name,
                                style: BlaTextStyles.body.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Text(
                                  location.country.name,
                                  style: BlaTextStyles.bodySmall.copyWith(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                              trailing: Icon(
                                Icons.chevron_right,
                                color: Colors.grey[400],
                              ),
                              onTap: () {
                                widget.onLocationSelected(location);
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
