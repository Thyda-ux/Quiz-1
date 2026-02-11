
import 'package:flutter/material.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../model/ride/locations.dart';

class RidePrefForm extends StatefulWidget {
  final Function(RidePref) onSearch;

  const RidePrefForm({super.key, required this.onSearch, RidePref? initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  // Simple default values
  Location _from = const Location(name: 'Paris', country: Country.france);
  Location _to = const Location(name: 'Lyon', country: Country.france);
  DateTime _date = DateTime.now().add(const Duration(days: 1));
  int _seats = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // From field
        _buildField(
          label: 'From',
          value: _from.name,
          onTap: () => _pickLocation(true),
          icon: Icons.location_on_outlined,
        ),

        const SizedBox(height: 12),

        // To field
        _buildField(
          label: 'To',
          value: _to.name,
          onTap: () => _pickLocation(false),
          icon: Icons.location_on,
        ),

        const SizedBox(height: 12),

        // Date field
        _buildField(
          label: 'When',
          value: _formatDate(_date),
          onTap: _pickDate,
          icon: Icons.calendar_today,
        ),

        const SizedBox(height: 12),

        // Passengers field
        Row(
          children: [
            Expanded(
              child: _buildField(
                label: 'Passengers',
                value: '$_seats',
                onTap: null,
                icon: Icons.person,
              ),
            ),
            const SizedBox(width: 12),
            // Seat buttons
            Row(
              children: [
                IconButton(
                  onPressed: _seats > 1 ? () => setState(() => _seats--) : null,
                  icon: const Icon(Icons.remove),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _seats < 8 ? () => setState(() => _seats++) : null,
                  icon: const Icon(Icons.add),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Search button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _search(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.all(16),
            ),
            child: const Text(
              'Search',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildField({
    required String label,
    required String value,
    required VoidCallback? onTap,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.grey[600]),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(value, style: const TextStyle(fontSize: 16)),
                ),
                if (onTap != null)
                  Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    if (date.day == DateTime.now().day) return 'Today';
    if (date.day == DateTime.now().add(const Duration(days: 1)).day)
      return 'Tomorrow';
    return '${date.day}/${date.month}/${date.year}';
  }

  void _pickLocation(bool isFrom) async {
    // Simple location picker - just toggle between Paris and Lyon for demo
    setState(() {
      if (isFrom) {
        _from = _from.name == 'Paris'
            ? const Location(name: 'Lyon', country: Country.france)
            : const Location(name: 'Paris', country: Country.france);
      } else {
        _to = _to.name == 'Paris'
            ? const Location(name: 'Lyon', country: Country.france)
            : const Location(name: 'Paris', country: Country.france);
      }
    });
  }

  void _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (date != null) {
      setState(() => _date = date);
    }
  }

  void _search() {
    final pref = RidePref(
      departure: _from,
      arrival: _to,
      departureDate: _date,
      requestedSeats: _seats,
    );

    widget.onSearch(pref);
  }
}
