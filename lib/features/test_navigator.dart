import 'package:final_depi/features/customer_request_status/screens/request_status_screen.dart';
import 'package:final_depi/features/customer_service_details/screens/customer_service_details_screen.dart';
import 'package:flutter/material.dart';

class TestNavigator extends StatelessWidget {
  const TestNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const CustomerServiceDetailsScreen(),
                    ),
                  );
                },
                child: const Text('CustomerServiceDetailsScreen'),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RequestStatusScreen(),
                    ),
                  );
                },
                child: const Text('RequestStatusScreen'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
