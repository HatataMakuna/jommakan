import 'package:flutter/material.dart';

List<String> locations = [
  'Red Bricks', 'Yum Yum', 'Swimming Pool', 'East Campus', 'i-Chill', 'CITC'
];

List<Widget> locationImages = [
  const Image(
    image: ResizeImage(
      AssetImage('images/redbrick.png'),
      width: 50,
      height: 50,
    )
  ),
  const Image(
    image: ResizeImage(
      AssetImage('images/yumyum.png'),
      width: 50,
      height: 50,
    )
  ),
  const Image(
    image: ResizeImage(
      AssetImage('images/swimmingpool.png'),
      width: 50,
      height: 50,
    )
  ),
  const Image(
    image: ResizeImage(
      AssetImage('images/eastcampus.png'),
      width: 50,
      height: 50,
    )
  ),
  const Image(
    image: ResizeImage(
      AssetImage('images/ichill.png'),
      width: 50,
      height: 50,
    )
  ),
  const Image(
    image: ResizeImage(
      AssetImage('images/citc.png'),
      width: 50,
      height: 50,
    )
  ),
];