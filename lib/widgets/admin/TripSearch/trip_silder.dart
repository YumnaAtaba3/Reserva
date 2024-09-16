import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


// class TypeSlider extends StatefulWidget {
//   TypeSlider({super.key, required this.images});
//   final List<String> images;

//   @override
//   State<TypeSlider> createState() => _TypeSliderState();
// }

// class _TypeSliderState extends State<TypeSlider> {
// //  final  List<String>! images;
//   late final List images = widget.images;

//   int activeIndex = 0;
//   final controller = CarouselController();
//   final urlImages = [
//     "images/im2.jpg",
//     "images/im3.jpg",
//     "images/im4.jpg",
//     "images/im5.jpg",
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       CarouselSlider.builder(
//           carouselController: controller,
//           itemCount: images.length,
//           itemBuilder: (context, index, realIndex) {
//             final image = images[index];
//             return buildImage(image, index);
//           },
//           options: CarouselOptions(
//               height: 300,
//               autoPlay: true,
//               enableInfiniteScroll: false,
//               autoPlayAnimationDuration: Duration(seconds: 10),
//               enlargeCenterPage: true,
//               onPageChanged: (index, reason) =>
//                   setState(() => activeIndex = index))),
//       SizedBox(height: 12),
//       buildIndicator()
//     ]);
//   }

//   Widget buildIndicator() => AnimatedSmoothIndicator(
//         onDotClicked: animateToSlide,
//         effect: ExpandingDotsEffect(
//             dotWidth: 5, activeDotColor: Colors.blue, dotHeight: 5, radius: 5),
//         activeIndex: activeIndex,
//         count: images.length,
//       );
//   void animateToSlide(int index) => controller.animateToPage(index);
// }

// Widget buildImage(String urlImage, int index) =>
//     Container(child: Image.network(urlImage, fit: BoxFit.cover));
class TypeSlider extends StatefulWidget {
  final List<String> images;

  TypeSlider({Key? key, required this.images}) : super(key: key);

  @override
  _TypeSliderState createState() => _TypeSliderState();
}

class _TypeSliderState extends State<TypeSlider> {
  late final List<String> images = widget.images;
  int activeIndex = 0;
  final controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
    mainAxisSize: MainAxisSize.max,
      children: [
        CarouselSlider.builder(
          carouselController: controller,
          itemCount: images.length,
          itemBuilder: (context, index, realIndex) {
            final image = images[index];
            return buildImage(image);
          },
          options: CarouselOptions(
            
            height:180,
            autoPlay: true,
            enableInfiniteScroll: false,
            autoPlayAnimationDuration: Duration(seconds: 10),
            enlargeCenterPage: true,
            onPageChanged: (index, reason) => setState(() => activeIndex = index),
          ),
        ),
        SizedBox(height: 12),
        buildIndicator(),
      ],
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
    onDotClicked: animateToSlide,
    effect: ExpandingDotsEffect(
      dotWidth: 5,
      activeDotColor: Colors.blue,
      dotHeight: 5,
      radius: 5,
    ),
    activeIndex: activeIndex,
    count: images.length,
  );

  void animateToSlide(int index) => controller.animateToPage(index);

  Widget buildImage(String urlImage) => Container(
    child: Image.network(urlImage, fit: BoxFit.cover),
  );
}