import 'package:final_depi/core/theme/app_colors.dart';
import 'package:final_depi/features/rating_and_review/widget/photo_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotosSection extends StatelessWidget {
  const PhotosSection({
    super.key,
    required this.photos,
    required this.maxPhotos,
    required this.onAddPhoto,
    required this.onRemovePhoto,
  });

  final List<XFile> photos;
  final int maxPhotos;
  final VoidCallback onAddPhoto;
  final ValueChanged<int> onRemovePhoto;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Photos of Work Done',
                style: TextStyle(
                  color: ColorsApp.primaryColor,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(
                color: ColorsApp.blueColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                '${photos.length}/$maxPhotos',
                style: const TextStyle(
                  color: ColorsApp.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          'Add proof of completed repair (optional, max 3)',
          style: TextStyle(color: ColorsApp.greyColor, fontSize: 12),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ...List.generate(
              photos.length,
              (index) => PhotoThumbnail(
                photo: photos[index],
                onRemove: () => onRemovePhoto(index),
              ),
            ),
            if (photos.length < maxPhotos)
              InkWell(
                onTap: onAddPhoto,
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  width: 108,
                  height: 116,
                  decoration: BoxDecoration(
                    color: ColorsApp.whiteColor,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: ColorsApp.blueColor),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 19,
                        backgroundColor: ColorsApp.blueColor,
                        child: Icon(
                          Icons.add_a_photo_outlined,
                          color: ColorsApp.primaryColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Add Photo',
                        style: TextStyle(
                          color: ColorsApp.primaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
