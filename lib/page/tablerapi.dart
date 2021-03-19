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

  Widget buildUsers(List<User> users) => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          if (index == 0) {
            return SingleChildScrollView(
                child: Column(children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 20, 20, 20),
                    child: Text('Daftar Gerobak',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ))),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(children: [
                      TableCell(child: Center(child: Text('Nama Gerobak'))),
                      TableCell(child: Center(child: Text('Rating'))),
                      TableCell(child: Center(child: Text('Jarak'))),
                      TableCell(child: Center(child: Text('Aksi'))),
                      TableCell(child: Text('')),
                    ]),
                  ],
                ),
              ),
            ]));
          } else {
            return SingleChildScrollView(
                child: Column(children: <Widget>[
              Container(
                // margin: EdgeInsets.all(10),
                child: Table(
                  border: TableBorder.symmetric(
                      outside: BorderSide(color: Colors.grey.shade700)),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(5, 3, 0, 3),
                          child: Text(user.namaGerobak,
                              style: TextStyle(
                                  fontFamily: 'Nunito', fontSize: 14.0))),
                      Center(
                          child: Text(user.rating,
                              style: TextStyle(
                                  fontFamily: 'Nunito', fontSize: 14.0))),
                      Center(
                          child: Text(user.jarak,
                              style: TextStyle(
                                  fontFamily: 'Nunito', fontSize: 14.0))),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
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
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        width: 90,
                        height: 30,
                        child: new RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(13.0)),
                          color: Color(0xff1C2A39),
                          onPressed: () {
                            launchWhatsapp(
                                number: "+628123456789", message: "Hello");
                          },
                          child: Text(
                            'Kontak',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ]));
          }
        },
      );
}
