import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class PassengerSelectionScreen extends StatefulWidget {
  final int initialSeats;
  final Function(int) onSeatsSelected;

  const PassengerSelectionScreen({
    super.key,
    required this.initialSeats,
    required this.onSeatsSelected,
  });

  @override
  State<PassengerSelectionScreen> createState() =>
      _PassengerSelectionScreenState();
}

class _PassengerSelectionScreenState extends State<PassengerSelectionScreen> {
  late int _selectedSeats;

  @override
  void initState() {
    super.initState();
    _selectedSeats = widget.initialSeats;
  }

  void _incrementSeats() {
    if (_selectedSeats < 8) {
      setState(() {
        _selectedSeats++;
      });
    }
  }

  void _decrementSeats() {
    if (_selectedSeats > 1) {
      setState(() {
        _selectedSeats--;
      });
    }
  }

  void _handleConfirm() {
    widget.onSeatsSelected(_selectedSeats);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(BlaSpacings.l),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Close button
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      size: 28,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: BlaSpacings.xl),

                  // Title
                  Text(
                    'Number of seats to book',
                    style: BlaTextStyles.heading.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: BlaColors.textNormal,
                    ),
                  ),
                  SizedBox(height: BlaSpacings.xl),

                  // Seats counter section
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Minus button
                            GestureDetector(
                              onTap: _decrementSeats,
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: _selectedSeats <= 1
                                        ? Colors.grey[300]!
                                        : Colors.grey[400]!,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.remove,
                                    size: 28,
                                    color: _selectedSeats <= 1
                                        ? Colors.grey[300]
                                        : Colors.grey[600],
                                  ),
                                ),
                              ),
                            ),

                            // Seat count display
                            Text(
                              '$_selectedSeats',
                              style: BlaTextStyles.heading.copyWith(
                                fontSize: 56,
                                fontWeight: FontWeight.w600,
                                color: BlaColors.textNormal,
                              ),
                            ),

                            // Plus button
                            GestureDetector(
                              onTap: _incrementSeats,
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    size: 32,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Confirm button positioned at bottom right
              Positioned(
                bottom: BlaSpacings.l,
                right: BlaSpacings.l,
                child: GestureDetector(
                  onTap: _handleConfirm,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_forward,
                        size: 28,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
