import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:guek_iptv/app/widgets/custom_text.dart';
import 'package:guek_iptv/constants/color_palette.dart';
import 'package:guek_iptv/constants/textstyle.dart';

//import 'package:guek_iptv/screen/bottom/IPTvAppSpecial/Allmovies/all_movies_screen.dart';
//import 'package:guek_iptv/screen/bottom/home/home_utiles.dart';

///common button
// ignore: must_be_immutable
class CommonButton extends StatelessWidget {
  String title;

  // ignore: prefer_typing_uninitialized_variables
  var fontSize;

  // ignore: prefer_typing_uninitialized_variables
  var onPress;

  // ignore: prefer_typing_uninitialized_variables
  var color;

  double elevation;

  CommonButton(
      {required this.title,
      this.fontSize,
      required this.onPress,
      this.color,
      this.elevation = 0});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      minWidth: Get.width,
      height: 50,
      elevation: elevation,
      color: color ?? ColorPalette.butColor.withAlpha(80),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        title,
        style: TextStyleClass.sourceSansProBold(
          size: fontSize ?? 14.0,
          color: ColorPalette.white,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CommonTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;

  // ignore: prefer_typing_uninitialized_variables
  var keyBoardType;

  // ignore: prefer_typing_uninitialized_variables
  var onChange;

  Icon? icon;

  Color hintColor;
  TextStyle? style;

  CommonTextField({
    required this.hintText,
    this.controller,
    this.keyBoardType,
    this.onChange,
    this.icon,
    this.style,
    this.hintColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    log(this.hintText.toString());
    log(this.icon.toString());
    return Container(
      height: 50,
      width: Get.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorPalette.butColor,
        ),
        borderRadius: BorderRadius.circular(6),
        color: ColorPalette.white.withOpacity(0.08),
      ),
      child: TextFormField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: keyBoardType,
        onChanged: onChange ?? (val) {},
        style: this.style,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyleClass.sourceSansProRegular(color: hintColor),
          prefixIcon: this.icon != null
              ? SizedBox(
                  width: 70,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        this.icon!,
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 20,
                          child: VerticalDivider(
                            width: 1.5,
                            color: ColorPalette.butColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : null,
          contentPadding:
              this.icon == null ? EdgeInsets.only(left: 15, bottom: 15) : null,
        ),
      ),
    );
  }
}

class CommonTextFieldMo extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;

  // ignore: prefer_typing_uninitialized_variables
  var keyBoardType;

  // ignore: prefer_typing_uninitialized_variables
  var onChange;

  CommonTextFieldMo({
    required this.hintText,
    this.controller,
    this.keyBoardType,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: Get.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorPalette.white,
        ),
        borderRadius: BorderRadius.circular(6),
        color: ColorPalette.white.withOpacity(0.08),
      ),
      child: TextFormField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: keyBoardType,
        onChanged: onChange ?? (val) {},
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyleClass.sourceSansProRegular(),
          prefixIcon: SizedBox(
            width: 70,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "+91",
                    style: TextStyleClass.sourceSansProSemiBold(size: 18.0),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 20,
                    child: VerticalDivider(
                      width: 1.5,
                      color: ColorPalette.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

commonRow({title, onTap}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyleClass.sourceSansProSemiBold(
              size: 16.0, color: ColorPalette.butColor),
        ),
        onTap != null
            ? SizedBox(
                height: 20,
                child: IconButton(
                  onPressed: onTap ?? null,
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: ColorPalette.butColor,
                    size: 15,
                  ),
                ),
              )
            : Spacer(),
      ],
    ),
  );
}

commonListView({list, onTap}) {
  return SizedBox(
    height: 170,
    child: ListView.builder(
      itemCount: list.length,
      padding: EdgeInsets.only(left: 20),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 20),
          child: InkWell(
            onTap: onTap ??
                () {
                  //bottomSheet1();
                },
            child: Container(
              width: 125,
              // margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(list[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

commonListView85Image({image}) {
  return SizedBox(
    height: 85,
    child: ListView.builder(
      itemCount: 8,
      padding: EdgeInsets.only(left: 20),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: InkWell(
            onTap: () {
              //bottomSheet1();
            },
            child: Container(
              width: 150,
              // margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

commonListView85List({list}) {
  return SizedBox(
    height: 85,
    child: ListView.builder(
      itemCount: list.length,
      padding: EdgeInsets.only(left: 20),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: InkWell(
            onTap: () {
              //bottomSheet1();
            },
            child: Container(
              width: 150,
              // margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(list[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

commonGrid({list, onTap}) {
  return GridView.builder(
    shrinkWrap: false,
    itemCount: list.length,
    padding: EdgeInsets.only(bottom: 80, top: 20),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      childAspectRatio: 1.8,
    ),
    scrollDirection: Axis.vertical,
    itemBuilder: (BuildContext context, int index) {
      return InkWell(
        onTap: onTap != null ? () => onTap(context, index) : () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              image: AssetImage(
                list[index],
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    },
  );
}

commonGrid3({list}) {
  return GridView.builder(
    shrinkWrap: true,
    itemCount: list.length,
    // padding: EdgeInsets.symmetric(horizontal: 20),
    physics: NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 13,
      mainAxisSpacing: 15,
      childAspectRatio: 2 / 2.7,
    ),
    itemBuilder: (context, index) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(
              list[index],
            ),
          ),
        ),
      );
    },
  );
}

accountPageButton({var title, var onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 50,
      width: Get.width,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
          //color: ColorPalette.grey3A,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorPalette.grad3_b.withAlpha(230),
                ColorPalette.grad3_a.withAlpha(230),
              ]),
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              blurRadius: 16,
              spreadRadius: 0,
              offset: Offset(0, 0),
              color: ColorPalette.appColor.withOpacity(0.08),
            ),
          ]),
      child: Text(
        title,
        style: TextStyleClass.sourceSansProSemiBold(),
      ),
    ),
  );
}

showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: ColorPalette.grey3A,
      content: CustomText(
        text: message,
        fontSize: 14,
        maxline: 1,
        overflow: TextOverflow.ellipsis,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        color: ColorPalette.white,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: ColorPalette.appColor,
      textColor: ColorPalette.white,
      fontSize: 14);
}

showWarning(BuildContext context, String title, String message,
    {VoidCallback? okCallback = null,
    VoidCallback? backCallback = null,
    String okText = "Tamam",
    String backText = "Geri",
    bool canPop = true}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => PopScope(
      canPop: canPop,
      child: AlertDialog(
        actionsPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        content: Container(
          width: Get.width,
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorPalette.appColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyleClass.sourceSansProSemiBold(
                      size: 16.0, color: ColorPalette.butColor),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  message,
                  style: TextStyleClass.sourceSansProRegular(
                      size: 12.0, color: ColorPalette.butColor.withAlpha(200)),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        if (okCallback == null) {
                          Get.back();
                        } else {
                          okCallback();
                        }
                      },
                      child: Container(
                        //width: Get.width * .2,
                        alignment: Alignment.center,
                        height: 35,
                        decoration: BoxDecoration(
                          //color: ColorPalette.grey50,
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                ColorPalette.grad3_b.withAlpha(230),
                                ColorPalette.grad3_a.withAlpha(230),
                              ]),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                okText,
                                style: TextStyleClass.sourceSansProSemiBold(
                                  size: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    /*ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "Kapat",
                      style: TextStyleClass.sourceSansProSemiBold(
                        size: 12.0,
                        color: ColorPalette.greyB0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPalette.grad1_b.withAlpha(200),
                    ),
                  ),*/
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
