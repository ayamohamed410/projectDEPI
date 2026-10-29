import 'package:flutter/material.dart';
import '../widgets/step_indicator_header.dart';
import '../widgets/service_categories_row.dart';
import '../widgets/problem_summary_field.dart';
import '../widgets/detailed_description_section.dart';
import '../widgets/visual_evidence_section.dart';
import '../widgets/service_location_card.dart';
import '../widgets/analyze_ai_button.dart';

class DescribeProblemScreen extends StatelessWidget {
  const DescribeProblemScreen({super.key});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            StepIndicatorHeader(),
            SizedBox(height: 20),
            Text(
              'Service Category',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            ServiceCategoriesRow(),
            SizedBox(height: 20),
            Text(
              'Problem Summary',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            ProblemSummaryField(),
            SizedBox(height: 20),
            DetailedDescriptionSection(),
            SizedBox(height: 20),
            VisualEvidenceSection(),
            SizedBox(height: 20),
            Text(
              'Service Location',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            ServiceLocationCard(),
            SizedBox(height: 30),
            AnalyzeAiButton(),
            SizedBox(height: 12),
            _SecureFooterNote(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _SecureFooterNote extends StatelessWidget {
  const _SecureFooterNote();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.verified_user_outlined, size: 14, color: Colors.grey),
        SizedBox(width: 6),
        Text(
          'Free automated triage & instant estimate',
          style: TextStyle(color: Colors.grey, fontSize: 11),
        ),
      ],
    );
  }
}
