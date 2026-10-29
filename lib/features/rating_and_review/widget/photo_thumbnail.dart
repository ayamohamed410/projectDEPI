import 'dart:io';

import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoThumbnail extends StatelessWidget {
  const PhotoThumbnail({
    super.key,
    required this.photo,
    required this.onRemove,
  });

  final XFile photo;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 108,
      height: 116,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.file(
                File(photo.path),
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return const ColoredBox(
                    color: ColorsApp.blueColor,
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: ColorsApp.greyColor,
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: InkWell(
              onTap: onRemove,
              borderRadius: BorderRadius.circular(20),
              child: const CircleAvatar(
                radius: 12,
                backgroundColor: ColorsApp.primaryColor,
                child: Icon(Icons.close, size: 15, color: ColorsApp.whiteColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
