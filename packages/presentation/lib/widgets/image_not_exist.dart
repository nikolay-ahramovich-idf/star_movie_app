import 'package:flutter/material.dart';

class ImageNotExist extends StatelessWidget {
  const ImageNotExist({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Image Not Exist Yet',
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }
}
