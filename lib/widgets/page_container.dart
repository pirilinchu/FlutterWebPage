import 'dart:ui';

import 'package:auditore_v4/constants.dart';
import 'package:flutter/material.dart';

import '../utils/extensions.dart';

class PageContainer extends StatelessWidget {
  final String title;
  final String body;
  final String imageUrl;
  final String color;
  final double height;
  final bool isInverted;
  final bool isBanner;
  final bool isTitle;
  final double cornerTop;
  final double cornerBottom;
  const PageContainer({
    Key? key,
    this.title = "Empty Title",
    this.body = "",
    this.imageUrl = "",
    this.color = "#00FFFF",
    this.height = 500,
    this.isInverted = false,
    this.isBanner = false,
    this.isTitle = false,
    this.cornerTop = 0.0,
    this.cornerBottom = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile(BuildContext context) =>
        MediaQuery.of(context).size.width < 750;

    BorderRadius borderRadius = isInverted
        ? BorderRadius.only(
            topLeft: Radius.circular(cornerTop),
            bottomLeft: Radius.circular(cornerBottom),
          )
        : BorderRadius.only(
            topRight: Radius.circular(cornerTop),
            bottomRight: Radius.circular(cornerBottom),
          );

    List<Widget> childrenContent = [
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 50.0,
                ),
                child: Text(title,
                    style: const TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black)),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(body,
                      style: const TextStyle(
                          height: 1.3,
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                ),
              ),
            ],
          ),
        ),
      )
    ];

    double fontSize = isTitle ? 70.0 : 40.0;

    List<Widget> bannerContent = [
      Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
            color: HexColor.fromHex(PageColors.BANNER_TEXT_COLOR)),
      ),
    ];

    if (body != "") {
      bannerContent.add(
        Container(
          height: 15.0,
        ),
      );
      bannerContent.add(
        Text(
          body,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: fontSize / 2,
              fontWeight: FontWeight.normal,
              color: HexColor.fromHex(PageColors.BANNER_TEXT_COLOR)),
        ),
      );
    }

    if (isBanner) {
      return imageUrl == ""
          ? Container(
              padding: const EdgeInsets.all(30),
              color: HexColor.fromHex(color),
              height: height / 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: bannerContent,
                ),
              ),
            )
          : Container(
              padding: const EdgeInsets.all(30),
              height: height / 2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: bannerContent,
                  ),
                ),
              ),
            );
    }

    if (isMobile(context)) {
      return Container(
        color: HexColor.fromHex(color),
        height: 2 * height,
        child: Column(
          children: childrenContent,
        ),
      );
    }
    if (isInverted) {
      childrenContent = childrenContent.reversed.toList();
    }
    return Container(
      color: HexColor.fromHex(color),
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: childrenContent,
      ),
    );
  }
}
