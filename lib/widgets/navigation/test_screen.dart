
import 'package:flutter/material.dart';
import 'bla_button.dart';

class BlaButtonTestScreen extends StatelessWidget {
  const BlaButtonTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BlaButton Test')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BlaButton Variations',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // Primary button
            const Text('Primary Button:', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            BlaButton(
              label: 'Primary Button',
              onPressed: () => print('Primary pressed'),
              variant: ButtonVariant.primary,
            ),
            
            const SizedBox(height: 16),
            
            // Primary with icon
            BlaButton(
              label: 'Primary with Icon',
              onPressed: () => print('Primary with icon pressed'),
              variant: ButtonVariant.primary,
              icon: Icons.search,
            ),
            
            const SizedBox(height: 16),
            
            // Disabled primary
            BlaButton(
              label: 'Disabled Primary',
              onPressed: () => print('This wont fire'),
              variant: ButtonVariant.primary,
              isDisabled: true,
            ),
            
            const SizedBox(height: 16),
            
            // Loading primary
            BlaButton(
              label: 'Loading Primary',
              onPressed: () {},
              variant: ButtonVariant.primary,
              isLoading: true,
            ),
            
            const SizedBox(height: 32),
            const Text('Secondary Button:', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            
            // Secondary button
            BlaButton(
              label: 'Secondary Button',
              onPressed: () => print('Secondary pressed'),
              variant: ButtonVariant.secondary,
            ),
            
            const SizedBox(height: 16),
            
            // Secondary with icon
            BlaButton(
              label: 'Secondary with Icon',
              onPressed: () => print('Secondary with icon pressed'),
              variant: ButtonVariant.secondary,
              icon: Icons.add,
            ),
            
            const SizedBox(height: 32),
            const Text('Outlined Button:', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            
            // Outlined button
            BlaButton(
              label: 'Outlined Button',
              onPressed: () => print('Outlined pressed'),
              variant: ButtonVariant.outlined,
            ),
            
            const SizedBox(height: 16),
            
            // Outlined with icon
            BlaButton(
              label: 'Outlined with Icon',
              onPressed: () => print('Outlined with icon pressed'),
              variant: ButtonVariant.outlined,
              icon: Icons.download,
            ),
            
            const SizedBox(height: 32),
            
            // Usage examples in context
            const Text('Real Usage Examples:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text('Search Form Example', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 16),
                    BlaButton(
                      label: 'Search Rides',
                      onPressed: () => print('Searching...'),
                      variant: ButtonVariant.primary,
                      icon: Icons.search,
                    ),
                    const SizedBox(height: 8),
                    BlaButton(
                      label: 'Cancel',
                      onPressed: () => print('Cancelled'),
                      variant: ButtonVariant.secondary,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}