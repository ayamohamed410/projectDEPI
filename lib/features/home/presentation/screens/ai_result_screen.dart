import 'package:flutter/material.dart';
import '../widgets/ai_header_badge.dart';
import '../widgets/diagnostic_details_card.dart';
import '../widgets/estimated_range_card.dart';
import '../widgets/ai_action_buttons.dart';

class AiResultScreen extends StatelessWidget {
  const AiResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Book Service',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.black54),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.black,
              child: Icon(Icons.person, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            AiHeaderBadge(),
            SizedBox(height: 16),
            DiagnosticDetailsCard(),
            SizedBox(height: 16),
            EstimatedRangeCard(),
            SizedBox(height: 20),
            AiActionButtons(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
