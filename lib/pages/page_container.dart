import 'package:auditore_v4/constants.dart';
import 'package:flutter/material.dart';

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
    this.imageUrl = "images/image_placeholder.png",
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
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
              color: HexColor.fromHex(PageColors.BANNER_TEXT_COLOR)),
        ),
      );
    }

    if (isBanner) {
      return Container(
        padding: const EdgeInsets.all(30),
        color: HexColor.fromHex(color),
        height: height / 2,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: bannerContent,
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

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
