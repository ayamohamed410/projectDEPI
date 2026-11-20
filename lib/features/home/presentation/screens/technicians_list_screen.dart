import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/technicians_repository.dart';
import '../../logic/technicians_bloc.dart';
import '../widgets/technician_card_widget.dart';

class TechniciansListScreen extends StatelessWidget {
  const TechniciansListScreen({super.key, this.category = 'Plumbing'});
  final String category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TechniciansBloc(
        FirestoreTechniciansRepository(FirebaseFirestore.instance),
      )..add(LoadTechnicians(category)),
      child: _TechniciansContent(category: category),
    );
  }
}

class _TechniciansContent extends StatelessWidget {
  const _TechniciansContent({required this.category});
  final String category;
  static const navy = Color(0xFF0F172A);

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
        title: const Text('Book Service', style: TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(radius: 16, backgroundColor: Colors.black,
              child: Icon(Icons.person, color: Colors.white, size: 18)),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final bloc = context.read<TechniciansBloc>();
          bloc.add(LoadTechnicians(category));
          await bloc.stream.firstWhere((state) =>
              state is TechniciansLoaded || state is TechniciansFailure);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Available Technicians', style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: navy)),
            const SizedBox(height: 4),
            Text('Specialty: $category · Firebase results',
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 14),
            // Ratings and GPS aren't stored in the current registration schema.
            // Do not show fake sorting behavior as if it were real.
            const Wrap(spacing: 8, runSpacing: 8, children: [
              Chip(label: Text('Recommended (name order)'),
                  backgroundColor: Color(0xFFE8EEFD)),
              Tooltip(message: 'Requires real rating data',
                  child: Chip(label: Text('Highest Rated · soon'))),
              Tooltip(message: 'Requires location coordinates',
                  child: Chip(label: Text('Nearest · soon'))),
            ]),
            const SizedBox(height: 14),
            BlocBuilder<TechniciansBloc, TechniciansState>(
              builder: (context, state) {
                if (state is TechniciansLoading || state is TechniciansInitial) {
                  return const Padding(
                    padding: EdgeInsets.all(36),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (state is TechniciansFailure) {
                  return _message(
                    context, Icons.wifi_off_outlined, state.message,
                    showRetry: true,
                  );
                }
                if (state is TechniciansLoaded) {
                  if (state.technicians.isEmpty) {
                    return _message(context, Icons.person_search_outlined,
                        'No registered technicians found for $category yet.');
                  }
                  return Column(children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('${state.technicians.length} registered technician(s)',
                          style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ),
                    const SizedBox(height: 10),
                    ...state.technicians.map((tech) => TechnicianCardWidget(
                      name: tech.name,
                      role: tech.specialization,
                      experience: tech.experience,
                      rating: '—',
                      reviewsCount: '—',
                      distance: 'Not provided',
                      eta: 'Not provided',
                      price: 'Ask for quote',
                      statusText: 'Availability unknown',
                      statusColor: const Color(0xFF64748B),
                      isElite: false,
                      onViewProfile: () => showDialog<void>(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                          title: Text(tech.name),
                          content: Text('Specialty: ${tech.specialization}\n'
                              'Experience: ${tech.experience.isEmpty ? 'Not provided' : tech.experience}\n\n'
                              'Booking and availability are not connected yet.'),
                          actions: [TextButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            child: const Text('Close'),
                          )],
                        ),
                      ),
                    )),
                  ]);
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _message(BuildContext context, IconData icon, String text,
      {bool showRetry = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 12),
      child: Column(children: [
        Icon(icon, color: Colors.blueGrey, size: 42),
        const SizedBox(height: 12),
        Text(text, textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.blueGrey)),
        if (showRetry) ...[
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => context.read<TechniciansBloc>().add(LoadTechnicians(category)),
            icon: const Icon(Icons.refresh), label: const Text('Retry'),
          ),
        ],
      ]),
    );
  }
}
