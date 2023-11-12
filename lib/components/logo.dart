import 'package:flutter/material.dart';

// Class to get logo images
class Logo {
  // Function to return the JomMakan logo with default size
  Widget getLogoImage() {
    return const Image(
      image: ResizeImage(
        AssetImage('images/logo.png'),
        width: 319,
        height: 72,
      ),
    );
  }

  // Function to return the JomMakan logo with customised size
  Widget getLogoImageWithCustomSize(int width, int height) {
    return Image(
      image: ResizeImage(
        const AssetImage('images/logo.png'),
        width: width,
        height: height,
      ),
    );
  }

  // Function to get the JomMakan along with TARUMT logo
  Widget getLogoWithTarumt() {
    return const Image(
      image: ResizeImage(
        AssetImage('images/jm-tarumt-logo.png'),
        width: 318,
        height: 56,
      ),
    );
  }
}