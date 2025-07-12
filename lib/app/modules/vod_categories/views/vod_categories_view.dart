import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:guek_iptv/app/models/xtream/movies_category.dart';
import 'package:guek_iptv/app/modules/main/controllers/main_controller.dart';
import 'package:guek_iptv/app/modules/vod_category/controllers/vod_category_controller.dart';
import 'package:guek_iptv/app/routes/app_pages.dart';
import 'package:guek_iptv/constants/color_palette.dart';
import 'package:guek_iptv/constants/textstyle.dart';

import 'package:guek_iptv/app/modules/vod_categories/controllers/vod_categories_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class VodCategoriesView extends GetView<VodCategoriesController> {
  const VodCategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.movieCategories.isEmpty) {
        return Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
              color: ColorPalette.butColor, size: 50),
        );
      }
      List<ListTile> categories = <ListTile>[];
      if (controller.movieCategories.isNotEmpty) {
        controller.movieCategories.forEach((MovieCategoryModel category) {
          categories.add(ListTile(
            contentPadding: EdgeInsets.zero,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            selectedColor: Colors.transparent,
            selectedTileColor: Colors.transparent,
            splashColor: ColorPalette.butColor.withAlpha(100),
            onTap: () {
              //Get.to(PopularChannelScreen());
              Get.find<VodCategoryController>().movies.clear();
              Get.toNamed(Routes.VOD_CATEGORY, arguments: {
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
            ])
        ),*/
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
