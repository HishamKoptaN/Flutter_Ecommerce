import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        border:
            Border.all(color: AppColors.iconColor, style: BorderStyle.solid),
        borderRadius: const BorderRadius.all(Radius.circular(13)),
        color: Colors.transparent,
        boxShadow: const <BoxShadow>[
          BoxShadow(
              color: Color(0xfff8f8f8),
              blurRadius: 5,
              spreadRadius: 10,
              offset: Offset(5, 5)),
        ],
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const <Widget>[
          Category(
            image_location: 'images/cats/ca2.png',
            image_caption: 'shoes',
          ),
          Category(
            image_location: 'images/cats/ca2.png',
            image_caption: 'shoes',
          ),
          Category(
            image_location: 'images/cats/ca3.png',
            image_caption: 'shoes',
          ),
          Category(
            image_location: 'images/cats/ca4.png',
            image_caption: 'shoes',
          ),
          Category(
            image_location: 'images/cats/ca5.png',
            image_caption: 'shoes',
          ),
          Category(
            image_location: 'images/cats/ca6.png',
            image_caption: 'shoes',
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  const Category(
      {super.key, required this.image_location, required this.image_caption});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 75,
      child: InkWell(
        onTap: () {},
        child: ListTile(
          title: Image.network(
            image_location,
            width: 100,
            height: 100,
            scale: 0.8,
            fit: BoxFit.fitWidth,
          ),
          subtitle: Text(image_caption),
        ),
      ),
    );
  }
}
