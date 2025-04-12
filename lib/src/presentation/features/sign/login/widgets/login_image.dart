import 'package:flutter/material.dart';
import 'package:flutter_dev_test/src/core/utils/constants/image_paths.dart';
import 'package:flutter_svg/flutter_svg.dart';

const _kImageSize = 222.0;

class LoginImage extends StatelessWidget {
  const LoginImage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 10,
              child: SvgPicture.asset(
                ImagePaths.line1,
                width: constraints.maxWidth,
              ),
            ),
            Positioned(
              bottom: 10,
              child: SvgPicture.asset(
                ImagePaths.line2,
                width: constraints.maxWidth,
              ),
            ),
            Center(
              child: Image.asset(
                ImagePaths.logo,
                height: _kImageSize,
                width: _kImageSize,
              ),
            ),
          ],
        );
      },
    );
  }
}
