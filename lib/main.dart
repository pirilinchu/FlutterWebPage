import 'package:auditore_v4/widgets/contact_me.dart';
import 'package:auditore_v4/widgets/page_container.dart';
import 'package:auditore_v4/utils/extensions.dart';
import 'package:auditore_v4/widgets/footer.dart';
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
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void homePressed() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
    print("scroll");
  }

  double cornerRadiusSection = Values.CORNER_RADIUS_SECTION;

  @override
  Widget build(BuildContext context) {
    print("Restarted");
    return Scaffold(
      appBar: AppBar(
        shadowColor: null,
        toolbarHeight: 70.0,
        backgroundColor: HexColor.fromHex(PageColors.BANNER_COLOR),
        title: TextButton(
          onPressed: () => homePressed(),
          child: Text(
            General.APP_TITLE,
            style: TextStyle(
                color: HexColor.fromHex(PageColors.BANNER_TEXT_COLOR),
                fontSize: 20.0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            PageContainer(
              title: General.APP_TITLE,
              body: General.APP_DESCRIPTION,
              color: PageColors.BANNER_COLOR,
              height: Values.TITLE_HEIGHT,
              imageUrl: Images.TITLE_BACKGROUND,
              isBanner: true,
              isTitle: true,
            ),
            PageContainer(
              title: Questions.ONE,
              body: Answers.ONE,
              height: Values.SECTION_HEIGHT,
              imageUrl: Images.IMAGE_ONE,
              color: PageColors.BACKGROUND_COLOR,
              cornerBottom: cornerRadiusSection,
            ),
            PageContainer(
              title: Questions.TWO,
              body: Answers.TWO,
              height: Values.SECTION_HEIGHT,
              imageUrl: Images.IMAGE_TWO,
              color: PageColors.BACKGROUND_COLOR,
              isInverted: true,
              cornerTop: cornerRadiusSection,
            ),
            PageContainer(
              title: Banners.ONE,
              body: Banners.ONE_BODY,
              color: PageColors.BANNER_COLOR,
              height: Values.SECTION_HEIGHT,
              isBanner: true,
            ),
            PageContainer(
              title: Questions.THREE,
              body: Answers.THREE,
              height: Values.SECTION_HEIGHT,
              imageUrl: Images.IMAGE_THREE,
              color: PageColors.BACKGROUND_COLOR,
              cornerBottom: cornerRadiusSection,
            ),
            PageContainer(
              title: Questions.FOUR,
              body: Answers.FOUR,
              height: Values.SECTION_HEIGHT,
              imageUrl: Images.IMAGE_FOUR,
              color: PageColors.BACKGROUND_COLOR,
              isInverted: true,
              cornerBottom: cornerRadiusSection,
              cornerTop: cornerRadiusSection,
            ),
            PageContainer(
              title: Questions.FIVE,
              body: Answers.FIVE,
              height: Values.SECTION_HEIGHT,
              imageUrl: Images.IMAGE_FIVE,
              color: PageColors.BACKGROUND_COLOR,
              cornerTop: cornerRadiusSection,
            ),
            // PageContainer(
            //   title: Banners.TWO,
            //   body: Banners.TWO_BODY,
            //   color: PageColors.BANNER_COLOR,
            //   height: Values.SECTION_HEIGHT,
            //   isBanner: true,
            // ),
            const ContactMe(),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
