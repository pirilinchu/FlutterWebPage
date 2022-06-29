import 'package:auditore_v4/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';

import '../utils/extensions.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/pngkey.com-texturas-png-991608.png"),
            fit: BoxFit.cover),
      ),
      child: Container(
        padding: EdgeInsets.only(top: Values.PAGE_TOP_PADDING),
        margin: EdgeInsets.symmetric(horizontal: Values.PAGE_PADING),
        width: 200,
        color: HexColor.fromHex("#FAFAFA"),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(Home.HOME_TITLE,
                    style: const TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black)),
              ),
              Container(
                padding: const EdgeInsets.all(80.0),
                child: Text(Home.HOME_BODY,
                    style: const TextStyle(
                        height: 1.3,
                        fontSize: 30.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey)),
              ),
              Center(
                child: Text(Home.HOME_TITLE,
                    style: const TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black)),
              ),
              Container(
                  padding: const EdgeInsets.all(80.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(Home.HOME_BODY,
                            style: const TextStyle(
                                height: 1.3,
                                fontSize: 30.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      Expanded(
                          flex: 7,
                          child: Container(
                            color: Colors.green,
                            height: 300.0,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(-17.384400, -66.155010)),
                              mapType: MapType.normal,
                            ),
                          ))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
