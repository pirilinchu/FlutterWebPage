import 'package:auditore_v4/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/extensions.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);
  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 750;

  @override
  Widget build(BuildContext context) {
    Future<void> _launchInBrowser(Uri url) async {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        throw 'Could not launch $url';
      }
    }

    void openFacebook() {
      _launchInBrowser(Uri.parse(Links.FACEBOOK));
    }

    void openWhatsapp() {
      _launchInBrowser(Uri.parse(Links.WHATSAPP));
    }

    List<Widget> contentChildren = [
      Expanded(
        child: Container(
          alignment:
              isMobile(context) ? Alignment.bottomCenter : Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: Text(
            General.APP_TITLE,
            style: TextStyle(
              color: HexColor.fromHex(PageColors.BANNER_TEXT_COLOR),
              fontSize: 30.0,
            ),
          ),
        ),
      ),
      Expanded(
        child: Container(
            alignment:
                isMobile(context) ? Alignment.topCenter : Alignment.centerRight,
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Row(
              mainAxisAlignment: isMobile(context)
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.end,
              children: [
                IconButton(
                  iconSize: 50.0,
                  color: HexColor.fromHex(PageColors.BANNER_TEXT_COLOR),
                  onPressed: () => openWhatsapp(),
                  icon: SvgPicture.asset(Images.WHATSAPP),
                ),
                IconButton(
                  iconSize: 50.0,
                  color: HexColor.fromHex(PageColors.BANNER_TEXT_COLOR),
                  onPressed: () => openFacebook(),
                  icon: SvgPicture.asset(Images.FACEBOOK),
                ),
              ],
            )),
      ),
    ];

    TextStyle infoStyle = TextStyle(
      color: HexColor.fromHex(PageColors.BANNER_TEXT_COLOR),
      fontSize: 18.0,
    );

    return Container(
        color: HexColor.fromHex(PageColors.BANNER_COLOR),
        height: Values.FOOTER_HEIGHT,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: isMobile(context)
                  ? Column(
                      children: contentChildren,
                    )
                  : Row(
                      children: contentChildren,
                    ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                alignment: Alignment.centerLeft,
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    Text(
                      General.APP_ADDRESS,
                      style: infoStyle,
                    ),
                    Text(
                      General.APP_LOCATION,
                      style: infoStyle,
                    ),
                    Text(
                      General.APP_PHONES,
                      style: infoStyle,
                    ),
                    Text(
                      General.APP_MAIL,
                      style: infoStyle,
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
