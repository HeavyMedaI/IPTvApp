import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:guek_iptv/app/models/xtream/movies_category.dart';
import 'package:guek_iptv/app/models/xtream/series_category.dart';
import 'package:guek_iptv/app/modules/series_category/controllers/series_category_controller.dart';
import 'package:guek_iptv/app/routes/app_pages.dart';
import 'package:guek_iptv/constants/color_palette.dart';
import 'package:guek_iptv/constants/textstyle.dart';

import 'package:guek_iptv/app/modules/series_categories/controllers/series_categories_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SeriesCategoriesView extends GetView<SeriesCategoriesController> {
  const SeriesCategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.seriesCategories.isEmpty) {
        return Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
              color: ColorPalette.butColor, size: 50),
        );
      }
      List<ListTile> categories = <ListTile>[];
      if (controller.seriesCategories.isNotEmpty) {
        controller.seriesCategories.forEach((SeriesCategoryModel category) {
          categories.add(ListTile(
            contentPadding: EdgeInsets.zero,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            selectedColor: Colors.transparent,
            selectedTileColor: Colors.transparent,
            splashColor: ColorPalette.butColor.withAlpha(100),
            onTap: () {
              Get.find<SeriesCategoryController>().clear();
              Get.toNamed(Routes.SERIES_CATEGORY, arguments: {
                "category_id": category.categoryId!,
                "category_name": category.categoryName!
              });
            },
            title: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                category.categoryName!,
                style: TextStyleClass.sourceSansProSemiBold(
                  size: 16.0,
                  color: ColorPalette.butColor
                ),
              ),
            ),
          ));
        });
      }
      return Container(
        color: Colors.transparent,
        /*decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorPalette.grad1_a,
                  ColorPalette.grad1_a,
                  ColorPalette.white.withOpacity(.5),
                  ColorPalette.grad1_b.withAlpha(50),
                  ColorPalette.white.withOpacity(.5),
                  ColorPalette.grad1_a,
            ])),*/
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                ...categories,
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      );
    });
  }
}
