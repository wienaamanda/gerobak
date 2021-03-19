import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:daftar_gerobak/page/user_network_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

// 0xffF9BF3B
class MyApp extends StatelessWidget {
  static final String title = 'Daftar Gerobak';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        // theme: ThemeData(
        //   primaryColor: Colors.amberAccent,
        // ),
        home: MainPage(title: title),
      );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Color(0xffF9BF3B),
        //   title: Text(widget.title),
        // ),
        body: buildPages(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: Text("Kembali Keatas"),
              activeIcon: Text("Kembali Keatas"),
              title: Container(
                height: 0.0,
              ),
            ),
            BottomNavigationBarItem(
              icon: Text("Bantuan"),
              activeIcon: Text("Bantuan"),
              title: Container(
                height: 0.0,
              ),
            ),
          ],
        ),
      );

  Widget buildPages() {
    switch (index) {
      case 0:
        return UserNetworkPage();
      default:
        return Container();
    }
  }
}
