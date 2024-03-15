import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../constants/app_colors.dart';

class Offers extends StatefulWidget {
  const Offers({super.key});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  List<String> offers = [
    'https://pbs.twimg.com/media/FOCKfqGWYAQrfFs?format=jpg&name=small',
    'https://pbs.twimg.com/media/FOCKfqGWYAQrfFs?format=jpg&name=small',
    'https://pbs.twimg.com/media/FOCKfqGWYAQrfFs?format=jpg&name=small',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          height: 1,
          color: Colors.grey,
        ),
        // ============>>>>>>>>>>>>   Catagory List End     <<<<<<<<<<<<<<========
        const Padding(
          padding: EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text(
                "Offers",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  // decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity - 20,
          height: 65,
          decoration: BoxDecoration(
            border: Border.all(
                color: AppColors.iconColor, style: BorderStyle.solid),
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
          child: PageView(
            children: [
              CarouselSlider(
                items: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                            image: NetworkImage(
                                'https://pbs.twimg.com/media/FOCKfqGWYAQrfFs?format=jpg&name=small'),
                            fit: BoxFit.cover)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                            image: NetworkImage(
                                'https://pbs.twimg.com/media/FOCKfqGWYAQrfFs?format=jpg&name=small'),
                            fit: BoxFit.cover)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                            image: NetworkImage(
                                'https://pbs.twimg.com/media/FOCKfqGWYAQrfFs?format=jpg&name=small'),
                            fit: BoxFit.cover)),
                  ),
                ],
                options: CarouselOptions(
                  height: 100,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.decelerate,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
