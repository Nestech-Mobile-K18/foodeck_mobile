import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:template/resources/media_res.dart';

// https://pub.dev/packages/carousel_slider/example
final List<String> imgList = [
  MediaRes.sale1,
  MediaRes.sale2,
  MediaRes.sale3,
];

class CarouselWithIndicator extends StatefulWidget {
  const CarouselWithIndicator({Key? key}) : super(key: key);

  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0.dp)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        item,
                        fit: BoxFit.cover,
                        width: 1000.0.dp,
                        height: 160.dp,
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0.dp, horizontal: 20.0.dp),
                          // child: Text(
                          //   'No. ${imgList.indexOf(item)} image',
                          //   style: TextStyle(
                          //     color: Colors.white,
                          //     fontSize: 20.0,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: imageSliders,
        carouselController: _controller,
        options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imgList.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 12.0.dp,
              height: 12.0.dp,
              margin:
                  EdgeInsets.symmetric(vertical: 8.0.dp, horizontal: 4.0.dp),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4)),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}
