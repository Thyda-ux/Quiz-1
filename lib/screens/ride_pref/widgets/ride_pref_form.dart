import 'package:flutter/material.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../model/ride/locations.dart';
import '../../../theme/theme.dart';
import 'location_picker.dart';
import 'passenger_selection.dart';

class RidePrefForm extends StatefulWidget {
  final RidePref? initRidePref;
  final Function(RidePref) onSearch;

  const RidePrefForm({super.key, this.initRidePref, required this.onSearch});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  late TextEditingController _fromController;
  late TextEditingController _toController;
  late DateTime _selectedDate;
  late int _passengerCount;
  late Location? _fromDeparture;
  late Location? _toArrival;

  @override
  void initState() {
    super.initState();
    _fromController = TextEditingController(
      text: widget.initRidePref?.departure.name ?? '',
    );
    _toController = TextEditingController(
      text: widget.initRidePref?.arrival.name ?? '',
    );
    _fromDeparture = widget.initRidePref?.departure;
    _toArrival = widget.initRidePref?.arrival;
    _selectedDate = widget.initRidePref?.departureDate ?? DateTime.now();
    _passengerCount = widget.initRidePref?.requestedSeats ?? 1;
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  String _getDateText() {
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    final weekday = weekdays[_selectedDate.weekday - 1];
    final day = _selectedDate.day;
    final month = months[_selectedDate.month - 1];

    return '$weekday $day $month';
  }

  void _handleSearch() {
    if (_fromDeparture == null) {
      _showError('Please select departure location');
      return;
    }

    if (_toArrival == null) {
      _showError('Please select destination location');
      return;
    }

    if (_fromDeparture == _toArrival) {
      _showError('Departure and destination cannot be the same');
      return;
    }

    final ridePref = RidePref(
      departure: _fromDeparture!,
      arrival: _toArrival!,
      departureDate: _selectedDate,
      requestedSeats: _passengerCount,
    );

    widget.onSearch(ridePref);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: BlaTextStyles.body),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(BlaSpacings.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Leaving from
          _buildMenuItem(
            icon: Icons.location_on_outlined,
            label: 'Leaving from',
            value: _fromController.text.isEmpty ? null : _fromController.text,
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LocationPickerScreen(
                    initialLocation: _fromController.text,
                    locationType: 'from',
                    onLocationSelected: (location) {
                      setState(() {
                        _fromController.text = location.name;
                        _fromDeparture = location;
                      });
                    },
                  ),
                ),
              );
            },
          ),

          const Divider(height: 1, color: Colors.grey),

          // Going to
          _buildMenuItem(
            icon: Icons.location_on_outlined,
            label: 'Going to',
            value: _toController.text.isEmpty ? null : _toController.text,
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LocationPickerScreen(
                    initialLocation: _toController.text,
                    locationType: 'to',
                    onLocationSelected: (location) {
                      setState(() {
                        _toController.text = location.name;
                        _toArrival = location;
                      });
                    },
                  ),
                ),
              );
            },
          ),

          const Divider(height: 1, color: Colors.grey),

          // Date
          _buildMenuItem(
            icon: Icons.calendar_today,
            label: _getDateText(),
            value: null,
            showChevron: true,
            onTap: () => _selectDate(context),
          ),

          const Divider(height: 1, color: Colors.grey),

          // Passenger
          _buildMenuItem(
            icon: Icons.person_outline,
            label: _passengerCount == 1
                ? '1 passenger'
                : '$_passengerCount passengers',
            value: null,
            showChevron: true,
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PassengerSelectionScreen(
                    initialSeats: _passengerCount,
                    onSeatsSelected: (seats) {
                      setState(() {
                        _passengerCount = seats;
                      });
                    },
                  ),
                ),
              );
            },
          ),

          const Divider(height: 1, color: Colors.grey),

          SizedBox(height: BlaSpacings.l),

          // Search button
          ElevatedButton(
            onPressed: _handleSearch,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              padding: EdgeInsets.symmetric(vertical: BlaSpacings.m),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(BlaSpacings.m),
              ),
              elevation: 0,
            ),
            child: Text(
              'Search',
              style: BlaTextStyles.heading.copyWith(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    String? value,
    bool showChevron = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: BlaSpacings.m,
          horizontal: BlaSpacings.m,
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[600], size: 20),
            SizedBox(width: BlaSpacings.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (value != null) ...[
                    Text(
                      label,
                      style: BlaTextStyles.bodySmall.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: BlaSpacings.xs),
                    Text(
                      value,
                      style: BlaTextStyles.body.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ] else
                    Text(
                      label,
                      style: BlaTextStyles.body.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                ],
              ),
            ),
            if (showChevron)
              Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}
