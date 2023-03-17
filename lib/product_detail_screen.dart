import 'package:api_practice/productmodel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  Products product;

  ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _totalDots = 5;
  int currentIndex = 0;

  @override
  void initState() {
    _totalDots = widget.product.images!.length;
    super.initState();
  }

  int _validp(int position) {
    if (position >= _totalDots) return 0;
    if (position < 0) return _totalDots - 1;
    return position;
  }

  void updatep(int position, CarouselPageChangedReason a) {
    setState(() {
      currentIndex = _validp(position);
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.product.title!,
                    style: TextStyle(fontSize: h * 0.05, color: Colors.black),
                  ),
                ),
                Text(
                  widget.product.rating.toString(),
                  style: TextStyle(fontSize: h * 0.05, color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.star, color: Colors.yellow.shade800),
                  ],
                ),
              ],
            ),
          ),

          CarouselSlider(
            items: [
              for (int i = 0; i < widget.product.images!.length; i++)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(widget.product.images![i]),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
            ],
            options: CarouselOptions(
                height: h * 0.7,
                enlargeCenterPage: true,
                autoPlay: false,
                aspectRatio: 1.5,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                viewportFraction: 1.0,
                onPageChanged: updatep),
          ),
          const SizedBox(height: 2),
          Center(
            child: DotsIndicator(
              dotsCount: widget.product.images!.length,
              position: currentIndex.toDouble(),
              decorator: DotsDecorator(color: Colors.black, activeColor: Colors.red, size: Size(h * 0.03, h * 0.03), activeSize: Size(h * 0.03, h * 0.03)),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12,horizontal: 16),
            child: Text(widget.product.description!, style: TextStyle(color: Colors.black)),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Center(child: Text("Book Now", style: TextStyle(color: Colors.white, fontSize: h * 0.04))),
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(h * 0.1)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
