import 'dart:async';

import 'package:api_practice/list_item_widget.dart';
import 'package:api_practice/productmodel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  ProductsModel? getapimodel;

  @override
  void initState() {
    getproduct();
    super.initState();
  }

  Future<void> getproduct() async {
    try {
      var response = await Dio().get("https://dummyjson.com/products");
      if (response.statusCode == 200) {
        print(response.data);
        getapimodel = ProductsModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    setState(() {});
    print("llllllllllllllllllllllllllllllllllllllllllllllllllll${getapimodel!.products!.length}");
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: getapimodel != null
          ? SingleChildScrollView(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: getapimodel!.products!.length,
                itemBuilder: (context, index) {
                  return ListItemWidget(product: getapimodel!.products![index]);
                },
              ),
            )
          : const Center(child: CircularProgressIndicator(color: Colors.red)),
    ));
  }
}
