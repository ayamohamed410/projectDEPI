import 'package:final_depi/core/constants/review_constants.dart';
import 'package:final_depi/core/theme/app_colors.dart';
import 'package:final_depi/features/rating_and_review/widget/app_header.dart';
import 'package:final_depi/features/rating_and_review/widget/feedback_section.dart';
import 'package:final_depi/features/rating_and_review/widget/highlights_section.dart';
import 'package:final_depi/features/rating_and_review/widget/photo_section.dart';
import 'package:final_depi/features/rating_and_review/widget/provider_card.dart';
import 'package:final_depi/features/rating_and_review/widget/rating_card.dart';
import 'package:final_depi/features/rating_and_review/widget/submit_review_button.dart';
import 'package:final_depi/features/rating_and_review/widget/trust_note.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RatingReviewScreen extends StatefulWidget {
  const RatingReviewScreen({super.key});

  @override
  State<RatingReviewScreen> createState() => _RatingReviewScreenState();
}

class _RatingReviewScreenState extends State<RatingReviewScreen> {
  final TextEditingController _feedbackController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();
  // defult stars:
  int _rating = 5;

  // part for the highlist that will be selected in question (What stood out the most):

  final Set<String> _selectedHighlights = {
    'Professionalism',
    'Punctuality',
    'Work Quality',
    'Value for Money',
  };

  final List<XFile> _photos = [];

  // the highlist that will be appear  in question (What stood out the most):
  final List<ReviewHighlight> _highlights = const [
    ReviewHighlight('Professionalism', Icons.verified_user_outlined),
    ReviewHighlight('Punctuality', Icons.access_time),
    ReviewHighlight('Work Quality', Icons.handyman_outlined),
    ReviewHighlight('Communication', Icons.chat_bubble_outline),
    ReviewHighlight('Value for Money', Icons.payments_outlined),
    ReviewHighlight('Cleanliness', Icons.cleaning_services_outlined),
  ];

  // switch case for choose how many stars and what the return
  String get _ratingLabel {
    switch (_rating) {
      case 1:
        return 'Needs Improvement';
      case 2:
        return 'Below Expectations';
      case 3:
        return 'Good Service';
      case 4:
        return 'Great Service!';
      case 5:
        return 'Exceptional Service!';
      default:
        return 'Rate your service';
    }
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  // calculate the number of additional images that can still be added and add the new images to the list
  Future<void> _addPhotos() async {
    final remaining = ReviewConstants.maxPhotos - _photos.length;

    if (remaining <= 0) {
      _showMessage(
        'You can add up to '
        '${ReviewConstants.maxPhotos} photos.',
      );
      return;
    }

    try {
      final picked = await _imagePicker.pickMultiImage(
        imageQuality: 85,
        limit: remaining,
      );

      if (!mounted || picked.isEmpty) return;

      setState(() {
        _photos.addAll(picked.take(remaining));
      });
    } catch (_) {
      if (mounted) {
        _showMessage('Could not open your photos. Please try again.');
      }
    }
  }

  // function  deletes the image selected by the user :
  void _removePhoto(int index) {
    setState(() {
      _photos.removeAt(index);
    });
  }

  void _toggleHighlight(String title) {
    setState(() {
      if (!_selectedHighlights.add(title)) {
        _selectedHighlights.remove(title);
      }
    });
  }

  // message appears when click on submitReview button
  void _submitReview() {
    _showMessage('Review ready to submit.');
  }

  /*
  void _submitReview() {
  if (_rating == 0) {
    _showMessage('Please select a rating');
    return;
  }

  _showMessage('Review submitted successfully');
}
  */

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.background,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(onBack: () {}),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ProviderCard(),
                    const SizedBox(height: 24),

                    RatingCard(
                      rating: _rating,
                      label: _ratingLabel,
                      onRatingChanged: (value) {
                        setState(() => _rating = value);
                      },
                    ),

                    const SizedBox(height: 24),

                    HighlightsSection(
                      highlights: _highlights,
                      selectedHighlights: _selectedHighlights,
                      onToggle: _toggleHighlight,
                    ),

                    const SizedBox(height: 24),

                    FeedbackSection(
                      controller: _feedbackController,
                      maxCharacters: ReviewConstants.maxCharacters,
                    ),

                    const SizedBox(height: 24),

                    PhotosSection(
                      photos: _photos,
                      maxPhotos: ReviewConstants.maxPhotos,
                      onAddPhoto: _addPhotos,
                      onRemovePhoto: _removePhoto,
                    ),

                    const SizedBox(height: 24),
                    const TrustNote(),
                    const SizedBox(height: 24),

                    SubmitReviewButton(onPressed: _submitReview),

                    const SizedBox(height: 12),

                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Skip for Now',
                          style: TextStyle(color: ColorsApp.primaryColor),
                        ),
                      ),
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
