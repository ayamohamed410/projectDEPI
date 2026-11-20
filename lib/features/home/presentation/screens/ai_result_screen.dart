import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/ai_analysis_bloc.dart';
import '../../logic/ai_report_save_cubit.dart';
import 'technicians_list_screen.dart';

/// Screen 9 — renders the AiReport received from Screen 8.
/// Can display either a live Gemini report or a demo report.
class AiResultScreen extends StatelessWidget {
  final AiReport report;
  const AiResultScreen({super.key, required this.report});

  static const _navy = Color(0xFF111E35);
  static const _blue = Color(0xFF1761E9);
  static const _muted = Color(0xFF657084);
  static const _bg = Color(0xFFF7F8FC);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AiReportSaveCubit(),
      child: Scaffold(
        backgroundColor: _bg,
        appBar: AppBar(
          backgroundColor: _bg,
          surfaceTintColor: Colors.transparent,
          foregroundColor: _navy,
          title: const Text('Book Service', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          actions: [
            IconButton(
              icon: const Icon(Icons.help_outline, size: 20),
              onPressed: () => showDialog<void>(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: const Text('About this report'),
                  content: const Text('This AI report is preliminary. It is not a confirmed diagnosis, quotation, or substitute for a qualified technician inspection.'),
                  actions: [TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('OK'))],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 12),
              child: CircleAvatar(radius: 16, backgroundColor: _navy,
                  child: Icon(Icons.person_outline, color: Colors.white, size: 19)),
            ),
          ],
        ),
        body: BlocListener<AiReportSaveCubit, AiReportSaveState>(
          listener: (context, state) {
            if (state is AiReportSaved) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Report saved on this device. It is not yet synced to Requests.'),
              ));
            } else if (state is AiReportSaveError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 28),
            children: [
              Row(children: [
                _pill('Analysis Complete', Icons.verified_outlined, const Color(0xFFE9EEFE), _navy),
                const Spacer(),
                const Icon(Icons.circle, size: 7, color: _blue),
                const SizedBox(width: 5),
                Text(report.isDemo ? 'Demo result' : 'AI generated', style: const TextStyle(fontSize: 11, color: _muted)),
              ]),
              const SizedBox(height: 12),
              _surface(children: [
                Row(children: [
                  _pill(report.isDemo ? 'AI DIAGNOSTIC · DEMO' : 'AI DIAGNOSTIC', Icons.auto_awesome, _blue, Colors.white),
                  const Spacer(),
                  const Text('Unverified', style: TextStyle(fontSize: 11, color: _muted)),
                ]),
                const SizedBox(height: 14),
                Text(report.title, style: const TextStyle(color: _navy, fontSize: 19, fontWeight: FontWeight.w800)),
                const SizedBox(height: 14),
                Row(children: [
                  Expanded(child: _metric('Recommended Specialty', report.specialty, Icons.build_outlined, _blue)),
                  const SizedBox(width: 8),
                  Expanded(child: _metric('Severity Assessment', report.severity, Icons.warning_amber_outlined, const Color(0xFFCA6A25))),
                ]),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: const Color(0xFFFFF5E7), borderRadius: BorderRadius.circular(10)),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Icon(Icons.shield_outlined, color: Color(0xFF875B25), size: 18),
                    const SizedBox(width: 8),
                    Expanded(child: Text('Precaution: ${report.precaution}',
                      style: const TextStyle(color: Color(0xFF6A5134), fontSize: 12))),
                  ]),
                ),
              ]),
              const SizedBox(height: 12),
              _surface(children: [
                Row(children: [
                  const Icon(Icons.description_outlined, size: 18, color: _blue),
                  const SizedBox(width: 6),
                  const Expanded(child: Text('Diagnostic Summary', style: TextStyle(fontWeight: FontWeight.w800, color: _navy, fontSize: 15))),
                  TextButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.edit_outlined, size: 15),
                    label: const Text('Edit Details', style: TextStyle(fontSize: 11)),
                  ),
                ]),
                const SizedBox(height: 8),
                Text(report.summary, style: const TextStyle(color: _muted, height: 1.45, fontSize: 13)),
                const SizedBox(height: 16),
                const Text('ANTICIPATED PARTS & CONSUMABLES',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: _navy, letterSpacing: 0.4)),
                const SizedBox(height: 8),
                Wrap(spacing: 7, runSpacing: 8,
                  children: report.parts.map((part) => _pill(part, Icons.handyman_outlined,
                    const Color(0xFFEAF0FF), _blue)).toList()),
                const SizedBox(height: 14),
                const Text('Photos are not included in this demo analysis.',
                    style: TextStyle(fontSize: 11, color: _muted)),
              ]),
              const SizedBox(height: 12),
              _surface(children: [
                const Row(children: [
                  Icon(Icons.payments_outlined, size: 19, color: _blue),
                  SizedBox(width: 7),
                  Text('Estimated Range', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: _navy)),
                ]),
                const SizedBox(height: 12),
                _estimate('Estimated Cost', report.costMin > 0 && report.costMax >= report.costMin
                    ? 'EGP ${report.costMin} – ${report.costMax}' : 'Awaiting technician quote', Icons.account_balance_wallet_outlined),
                const SizedBox(height: 8),
                _estimate('Estimated Duration', report.minutesMin > 0 && report.minutesMax >= report.minutesMin
                    ? '${report.minutesMin} – ${report.minutesMax} mins' : 'Awaiting technician assessment', Icons.access_time),
                const SizedBox(height: 8),
                const Text('Costs and duration are not verified; a technician must inspect the issue.',
                    style: TextStyle(color: _muted, fontSize: 11)),
              ]),
              const SizedBox(height: 16),
              SizedBox(height: 52, child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: _navy, foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11))),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(
                  builder: (_) => TechniciansListScreen(category: report.category),
                )),
                icon: const Icon(Icons.search, size: 18),
                label: const Text('Find Available Technicians', style: TextStyle(fontWeight: FontWeight.w700)),
              )),
              const SizedBox(height: 10),
              BlocBuilder<AiReportSaveCubit, AiReportSaveState>(builder: (context, state) {
                final saving = state is AiReportSaving;
                final saved = state is AiReportSaved;
                return SizedBox(height: 48, child: OutlinedButton.icon(
                  onPressed: saving || saved ? null : () => context.read<AiReportSaveCubit>().save(report),
                  style: OutlinedButton.styleFrom(backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFFE0E5F0)), foregroundColor: _navy,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11))),
                  icon: saving ? const SizedBox(width: 16, height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2))
                      : Icon(saved ? Icons.check_circle_outline : Icons.bookmark_border, size: 18),
                  label: Text(saving ? 'Saving...' : saved ? 'Saved on this device' : 'Save Report Locally'),
                ));
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _surface({required List<Widget> children}) => Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(13),
      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.035), blurRadius: 9, offset: const Offset(0, 3))]),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
  );

  Widget _pill(String text, IconData icon, Color bg, Color fg) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 12, color: fg), const SizedBox(width: 5),
      Text(text, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: fg)),
    ]),
  );

  Widget _metric(String label, String value, IconData icon, Color accent) => Container(
    constraints: const BoxConstraints(minHeight: 82),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(color: const Color(0xFFF0F4FE), borderRadius: BorderRadius.circular(9)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 10, color: _muted)),
      const SizedBox(height: 8),
      Row(children: [
        Icon(icon, size: 16, color: accent), const SizedBox(width: 5),
        Expanded(child: Text(value, style: TextStyle(fontSize: 12, color: accent, fontWeight: FontWeight.w700))),
      ]),
    ]),
  );

  Widget _estimate(String title, String value, IconData icon) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: const Color(0xFFF0F4FE), borderRadius: BorderRadius.circular(9)),
    child: Row(children: [
      Icon(icon, color: _blue, size: 20), const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 11, color: _muted)),
        const SizedBox(height: 3),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: _navy)),
      ])),
    ]),
  );
}
