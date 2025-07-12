import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:guek_iptv/app/models/xtream/live_category.dart';

import 'package:guek_iptv/app/modules/live_categories/controllers/live_categories_controller.dart';
import 'package:guek_iptv/app/modules/live_category/controllers/live_category_controller.dart';
import 'package:guek_iptv/app/routes/app_pages.dart';
import 'package:guek_iptv/constants/color_palette.dart';
import 'package:guek_iptv/constants/textstyle.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LiveCategoriesView extends GetView<LiveCategoriesController> {
  const LiveCategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.liveCategories.isEmpty) {
        return Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
              color: ColorPalette.butColor, size: 50),
        );
      }

      List<ListTile> categories = <ListTile>[];
      if (controller.liveCategories.isNotEmpty) {
        controller.liveCategories.forEach((LiveCategoryModel category) {
          categories.add(ListTile(
            contentPadding: EdgeInsets.zero,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            selectedColor: Colors.transparent,
            selectedTileColor: Colors.transparent,
            splashColor: ColorPalette.butColor.withAlpha(100),
            onTap: () {
              Get.find<LiveCategoryController>().clear();
              Get.toNamed(Routes.LIVE_CATEGORY, arguments: {
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
