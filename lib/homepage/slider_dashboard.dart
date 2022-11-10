import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SliderDashboard extends StatefulWidget {
  const SliderDashboard({Key? key}) : super(key: key);

  @override
  State<SliderDashboard> createState() => _SliderDashboardState();
}

class _SliderDashboardState extends State<SliderDashboard> {
  final List<String> bannerList = [
    'https://c4.wallpaperflare.com/wallpaper/336/163/715/honeycombs-abstract-minimalism-simple-background-wallpaper-preview.jpg',
    'https://c4.wallpaperflare.com/wallpaper/336/163/715/honeycombs-abstract-minimalism-simple-background-wallpaper-preview.jpg',
    'https://c4.wallpaperflare.com/wallpaper/336/163/715/honeycombs-abstract-minimalism-simple-background-wallpaper-preview.jpg',
  ];
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        CarouselSlider(
          items: bannerList
              .map((item) => ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    ],
                  )))
              .toList(),
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 298 / 110,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: bannerList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: (_current == entry.key ? 20.0 : 11.0),
                height: 11.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: (_current == entry.key
                        ? Color(0xff466aff)
                        : Colors.grey)),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }
}
