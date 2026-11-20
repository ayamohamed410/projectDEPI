import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/ai_analysis_repository.dart';
import '../../data/firebase_ai_analysis_repository.dart';
import '../../logic/ai_analysis_bloc.dart';
import '../widgets/step_indicator_header.dart';
import 'ai_result_screen.dart';

/// Screen 8: images and text are sent to the secure Firebase Function.
class DescribeProblemScreen extends StatelessWidget {
  const DescribeProblemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AiAnalysisBloc>(
      create: (_) => AiAnalysisBloc(FirebaseAiAnalysisRepository()),
      child: const _ProblemForm(),
    );
  }
}

class _ProblemForm extends StatefulWidget {
  const _ProblemForm();

  @override
  State<_ProblemForm> createState() => _ProblemFormState();
}

class _ProblemFormState extends State<_ProblemForm> {
  static const _navy = Color(0xFF101D34);
  static const _blue = Color(0xFF185BDB);

  final _form = GlobalKey<FormState>();
  final _summary = TextEditingController();
  final _description = TextEditingController();
  final _location = TextEditingController();
  final _picker = ImagePicker();
  final List<XFile> _photos = [];
  String _category = 'Plumbing';
  bool _selectingPhoto = false;

  @override
  void initState() {
    super.initState();
    _description.addListener(_refreshCharacterCount);
  }

  void _refreshCharacterCount() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _description.removeListener(_refreshCharacterCount);
    _summary.dispose();
    _description.dispose();
    _location.dispose();
    super.dispose();
  }

  Future<void> _addPhotos(ImageSource source) async {
    if (_selectingPhoto || _photos.length >= 4) return;
    setState(() => _selectingPhoto = true);
    try {
      final List<XFile> picked;
      if (source == ImageSource.gallery) {
        picked = await _picker.pickMultiImage(imageQuality: 75);
      } else {
        final image = await _picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 75,
        );
        picked = image == null ? [] : [image];
      }
      if (!mounted) return;
      final slots = 4 - _photos.length;
      setState(() => _photos.addAll(picked.take(slots)));
      if (picked.length > slots) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You can add up to 4 photos.')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not access photos. Check camera or gallery permissions.')),
      );
    } finally {
      if (mounted) setState(() => _selectingPhoto = false);
    }
  }

  Widget _sectionLabel(String title, {String? trailing}) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Expanded(
              child: Text(title, style: const TextStyle(
                fontSize: 13, fontWeight: FontWeight.w700, color: _navy,
              )),
            ),
            if (trailing != null)
              Text(trailing, style: const TextStyle(fontSize: 11, color: _blue)),
          ],
        ),
      );

  InputDecoration _input(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 12, color: Colors.black45),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(14),
      );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AiAnalysisBloc, AiAnalysisState>(
      listener: (context, state) {
        if (state is AiFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is AiSuccess) {
          Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (_) => AiResultScreen(report: state.report),
          ));
        }
      },
      builder: (context, state) {
        final loading = state is AiLoading;
        return Scaffold(
          backgroundColor: const Color(0xFFF7F8FC),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF7F8FC),
            surfaceTintColor: Colors.transparent,
            foregroundColor: _navy,
            title: const Text('Book Service', style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.w700,
            )),
            actions: [
              IconButton(icon: const Icon(Icons.help_outline, size: 20), onPressed: () {
                showDialog<void>(context: context, builder: (_) => AlertDialog(
                  title: const Text('How it works'),
                  content: const Text('Describe the issue and add photos. AI guidance is preliminary and must be confirmed by a technician.'),
                  actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
                ));
              }),
            ],
          ),
          body: Form(
            key: _form,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
              children: [
                const StepIndicatorHeader(),
                const SizedBox(height: 22),
                _sectionLabel('Service Category', trailing: 'Select primary domain'),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ['Plumbing', 'Electrical', 'HVAC', 'Painting', 'Carpentry', 'Appliances']
                        .map((category) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ChoiceChip(
                                label: Text(category),
                                selected: _category == category,
                                onSelected: loading ? null : (_) => setState(() => _category = category),
                                selectedColor: _navy,
                                labelStyle: TextStyle(
                                  fontSize: 12,
                                  color: _category == category ? Colors.white : _navy,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 18),
                _sectionLabel('Problem Summary'),
                TextFormField(
                  controller: _summary,
                  enabled: !loading,
                  maxLength: 120,
                  decoration: _input('e.g. Water leak under kitchen sink'),
                  validator: (text) => text == null || text.trim().isEmpty
                      ? 'Please enter a problem summary'
                      : null,
                ),
                const SizedBox(height: 8),
                _sectionLabel('Detailed Description', trailing: '${_description.text.length}/500'),
                TextFormField(
                  controller: _description,
                  enabled: !loading,
                  minLines: 4,
                  maxLines: 6,
                  maxLength: 500,
                  buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
                  decoration: _input('Describe what happened, when it started, and any unusual signs.'),
                  validator: (text) => text == null || text.trim().isEmpty
                      ? 'Please describe the issue'
                      : null,
                ),
                const SizedBox(height: 22),
                _sectionLabel('Visual Evidence', trailing: '${_photos.length} of 4 added'),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDF2FD),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.camera_alt_outlined, size: 31, color: _blue),
                      const SizedBox(height: 8),
                      const Text('Add up to 4 photos', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      const Text('Photos will be sent securely for AI analysis when you press Analyze.',
                          textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Colors.black54)),
                      const SizedBox(height: 12),
                      Wrap(spacing: 10, children: [
                        TextButton.icon(
                          onPressed: loading || _selectingPhoto || _photos.length == 4
                              ? null : () => _addPhotos(ImageSource.camera),
                          icon: const Icon(Icons.camera_alt_outlined, size: 16),
                          label: const Text('Camera'),
                        ),
                        TextButton.icon(
                          onPressed: loading || _selectingPhoto || _photos.length == 4
                              ? null : () => _addPhotos(ImageSource.gallery),
                          icon: const Icon(Icons.photo_library_outlined, size: 16),
                          label: const Text('Gallery'),
                        ),
                      ]),
                    ],
                  ),
                ),
                if (_photos.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 108,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _photos.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, index) => Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(File(_photos[index].path),
                                width: 108, height: 108, fit: BoxFit.cover),
                          ),
                          Positioned(
                            right: 1, top: 1,
                            child: IconButton.filledTonal(
                              constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.close, size: 16),
                              onPressed: loading ? null : () => setState(() => _photos.removeAt(index)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 22),
                _sectionLabel('Service Location'),
                TextFormField(
                  controller: _location,
                  enabled: !loading,
                  decoration: _input('Enter your service address (optional)').copyWith(
                    prefixIcon: const Icon(Icons.location_on_outlined, color: _blue),
                  ),
                ),
                const SizedBox(height: 22),
                SizedBox(
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: loading ? null : () {
                      if (!_form.currentState!.validate()) return;
                      FocusScope.of(context).unfocus();
                      context.read<AiAnalysisBloc>().add(AnalyzeProblem(
                        category: _category,
                        summary: _summary.text,
                        description: _description.text,
                        location: _location.text,
                        imagePaths: _photos.map((photo) => photo.path).toList(),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _navy,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: loading
                        ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white,
                          ))
                        : const Icon(Icons.auto_awesome, size: 20),
                    label: Text(loading ? 'Analyzing...' : 'Analyze Issue with AI'),
                  ),
                ),
                const SizedBox(height: 8),
                const Text('AI guidance is preliminary and is not a substitute for a qualified technician.',
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Colors.black54)),
              ],
            ),
          ),
        );
      },
    );
  }
}
