import 'package:template/pages/export.dart';

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
            margin: EdgeInsets.all(AppMargin.m5),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(AppSize.s5)),
                child: Stack(
                  children: <Widget>[
                    Image(
                      image: AssetImage(item),
                      fit: BoxFit.cover,
                      width: AppSize.s1000,
                      height: AppSize.s160,
                    ),
                    // Image.network(
                    //   item,
                    //   fit: BoxFit.cover,
                    //   width: AppSize.s1000,
                    //   height: AppSize.s160,
                    // ),
                  ],
                )),
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
              width: AppSize.s12,
              height: AppSize.s12,
              margin: EdgeInsets.symmetric(
                  vertical: AppMargin.m8, horizontal: AppMargin.m4),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? ColorsGlobal.white
                          : ColorsGlobal.black)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4)),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}
