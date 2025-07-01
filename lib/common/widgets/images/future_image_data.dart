import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shopping_app/common/widgets/centered_loading.dart';

/// Used to show thumbnail when using these packages:
///
///  - `video_thumbnail`
///  - `youtube_player_flutter`
///  - `video_player`
class FutureImageData extends StatelessWidget {
  const FutureImageData({
    super.key,
    required this.future,
    this.borderRadius,
  });

  final Future<Uint8List?> future;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CenteredLoading();
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const SizedBox.shrink();
        }

        return SizedBox(
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(snapshot.requireData!),
                fit: BoxFit.contain,
              ),
              borderRadius: borderRadius,
            ),
          ),
        );
      },
    );
  }
}
