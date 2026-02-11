import 'package:flutter/material.dart';

import '../../model/ride_pref/ride_pref.dart';
import '../../services/ride_prefs_service.dart';
import '../../theme/theme.dart';

import 'widgets/ride_pref_form.dart';
import 'widgets/ride_pref_history_tile.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

///
/// This screen allows user to:
/// - Enter his/her ride preference and launch a search on it
/// - Or select a last entered ride preferences and launch a search on it
///
class RidePrefScreen extends StatefulWidget {
  const RidePrefScreen({super.key});

  @override
  State<RidePrefScreen> createState() => _RidePrefScreenState();
}

class _RidePrefScreenState extends State<RidePrefScreen> {
  void onRidePrefSelected(RidePref ridePref) {
    // 1 - Navigate to the rides screen (with a buttom to top animation)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // 1 - Background Image
            _buildBackground(),

            // 2 - Foreground content
            _buildForeground(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(
        blablaHomeImagePath,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildForeground() {
    return Column(
      children: [
        SizedBox(height: 16),
        Text(
          "Your pick of rides at low price",
          style: BlaTextStyles.heading.copyWith(color: Colors.white),
        ),
        // push the white card below the header image
        SizedBox(height: 240),
        Container(
          margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 2.1 Display the Form to input the ride preferences
              RidePrefForm(
                initRidePref: RidePrefsService.currentRidePref,
                onSearch: (RidePref ridePref) {
                  onRidePrefSelected(ridePref);
                },
              ),
              SizedBox(height: BlaSpacings.m),

              // 2.2 Optionally display a list of past preferences
              SizedBox(
                height: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: RidePrefsService.ridePrefsHistory?.length ?? 0,
                  itemBuilder: (ctx, index) => RidePrefHistoryTile(
                    ridePref: RidePrefsService.ridePrefsHistory[index],
                    onTap: () {
                      onRidePrefSelected(
                        RidePrefsService.ridePrefsHistory[index],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
