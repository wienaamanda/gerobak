import 'package:flutter/material.dart';
import 'package:daftar_gerobak/api/users_api.dart';
import 'package:daftar_gerobak/model/user.dart';
import 'package:url_launcher/url_launcher.dart';

class UserNetworkPage extends StatelessWidget {
  void launchWhatsapp({@required number, @required message}) async {
    var whatsAppUrl = "whatsapp://send?phone=$number&text=$message";
    await canLaunch(whatsAppUrl)
        ? launch(whatsAppUrl)
        : print(
            "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: FutureBuilder<List<User>>(
          future: UsersApi.getUsers(),
          builder: (context, snapshot) {
            final users = snapshot.data;

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Some error occurred!'));
                } else {
                  return buildUsers(users);
                }
            }
          },
        ),
      );

  Widget buildUsers(List<User> users) => ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: users == null ? 1 : users.length + 1,
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey,
        );
      },
      itemBuilder: (context, index) {
        if (index == 0) {
          // return the header
          Text("Daftar Gerobak");
          return new Column(children: [
            Container(
                padding: new EdgeInsets.all(15.0),
                child: Image(
                  image: new AssetImage("assets/map.png"),
                )),
            SizedBox(
              width: double.infinity,
              child: Container(
                child: Text("Daftar Gerobak",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ),
            ),
            Row(children: [
              Container(
                  child: Text('Nama Gerobak',
                      style: TextStyle(
                        height: 3.0,
                        fontSize: 15.2,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.bold,
                      )),
                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
              Container(
                  child: Text('Jarak',
                      style: TextStyle(
                        height: 3.0,
                        fontSize: 15.2,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.bold,
                      )),
                  padding: EdgeInsets.fromLTRB(50, 0, 10, 0)),
              Container(
                  child: Text('Rating',
                      style: TextStyle(
                        height: 3.0,
                        fontSize: 15.2,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.bold,
                      ))),
              Container(
                  child: Text('Aksi',
                      style: TextStyle(
                        height: 3.0,
                        fontSize: 15.2,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Nunito",
                      )),
                  padding: EdgeInsets.fromLTRB(15, 0, 10, 0)),
            ]),
          ]);
        }
        index -= 1;

        return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
                child: Container(
                    child: Row(
              children: <Widget>[
                Container(
                  child: Text(users[index].namaGerobak),
                  width: 150,
                  height: 52,
                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  alignment: Alignment.centerLeft,
                ),
                Container(
                  child: Text(users[index].jarak),
                  width: 50,
                  height: 52,
                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  alignment: Alignment.center,
                ),
                Container(
                  child: Text(users[index].rating),
                  width: 50,
                  height: 52,
                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  alignment: Alignment.center,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                  width: 90,
                  height: 30,
                  child: new RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(13.0)),
                    color: Color(0xffF9BF3B),
                    onPressed: () {
                      print("lihat detail");
                    },
                    child: Text(
                      'Detail',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ))));
        return ListTile(
          title: Row(
            children: <Widget>[
              Expanded(
                  child: OutlineButton(
                onPressed: () {},
                child: Text("Kembali Keatas"),
                borderSide: BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(13.0)),
              )),
              Expanded(
                  child: OutlineButton(
                onPressed: () {},
                child: Text("Bantuan"),
                borderSide: BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(13.0)),
              )),
            ],
          ),
        );
      });
}
