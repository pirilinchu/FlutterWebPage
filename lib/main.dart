import 'package:auditore_v4/pages/home_page.dart';
import 'package:auditore_v4/pages/page_container.dart';
import 'package:auditore_v4/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:auditore_v4/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        fontFamily: "Roboto",
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  double cornerRadiusSection = Values.CORNER_RADIUS_SECTION;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Navbar(),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PageContainer(
              title: General.APP_TITLE,
              color: PageColors.BANNER_COLOR,
              height: 800,
              isBanner: true,
              isTitle: true,
            ),
            PageContainer(
              title: Questions.ONE,
              body: Answers.ONE,
              height: 500,
              imageUrl: "images/image_placeholder.png",
              color: PageColors.BACKGROUND_COLOR,
              cornerBottom: cornerRadiusSection,
            ),
            PageContainer(
              title: Questions.TWO,
              body: Answers.TWO,
              height: 500,
              imageUrl: "images/image_placeholder.png",
              color: PageColors.BACKGROUND_COLOR,
              isInverted: true,
              cornerTop: cornerRadiusSection,
            ),
            PageContainer(
              title: Banners.ONE,
              body: Banners.ONE_BODY,
              color: PageColors.BANNER_COLOR,
              height: 500,
              isBanner: true,
            ),
            PageContainer(
              title: Questions.THREE,
              body: Answers.THREE,
              height: 500,
              imageUrl: "images/image_placeholder.png",
              color: PageColors.BACKGROUND_COLOR,
              cornerBottom: cornerRadiusSection,
            ),
            PageContainer(
              title: Questions.FOUR,
              body: Answers.FOUR,
              height: 500,
              imageUrl: "images/image_placeholder.png",
              color: PageColors.BACKGROUND_COLOR,
              isInverted: true,
              cornerBottom: cornerRadiusSection,
              cornerTop: cornerRadiusSection,
            ),
            PageContainer(
              title: Questions.FIVE,
              body: Answers.FIVE,
              height: 500,
              imageUrl: "images/image_placeholder.png",
              color: PageColors.BACKGROUND_COLOR,
              cornerTop: cornerRadiusSection,
            ),
            PageContainer(
              title: Banners.TWO,
              body: Banners.TWO_BODY,
              color: PageColors.BANNER_COLOR,
              height: 500,
              isBanner: true,
            ),
          ],
        ),
      ),
    );
  }
}
