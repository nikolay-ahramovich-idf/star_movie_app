import 'package:flutter/material.dart';
import 'package:presentation/const.dart';
import 'package:presentation/utils/styles.dart';

class ImageWidget extends StatelessWidget {
  final String? _imageUrl;

  const ImageWidget(
    this._imageUrl, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _imageUrl == null
        ? const Text(
            'Image Not Exist Yet',
            style: ImageWidgetStyles.imageNotExistStyle,
          )
        : Image.network(
            _imageUrl!,
            errorBuilder: (_, error, stackTrace) => const Center(
              child: Text(
                'Image Not Exist Yet',
                style: ImageWidgetStyles.imageNotExistStyle,
              ),
            ),
            fit: BoxFit.contain,
          );
  }
}
