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
                // scrollDirection: Axis.horizontal,
                child: Column(
              children: <Widget>[
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
                Container(
                    child: Row(children: <Widget>[
                  Container(
                      child: Text(
                        "Nama Gerobak",
                        style: TextStyle(
                            fontFamily: "Nunito", fontWeight: FontWeight.bold),
                      ),
                      width: 150,
                      height: 52,
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade200),
                        ),
                      )),
                  Container(
                      child: Text(
                        "Jarak",
                        style: TextStyle(
                            fontFamily: "Nunito", fontWeight: FontWeight.bold),
                      ),
                      width: 50,
                      height: 52,
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade200),
                        ),
                      )),
                  Container(
                      child: Text(
                        "Rating",
                        style: TextStyle(
                            fontFamily: "Nunito", fontWeight: FontWeight.bold),
                      ),
                      width: 50,
                      height: 52,
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade200),
                        ),
                      )),
                  Container(
                      child: Text(
                        "Aksi",
                        style: TextStyle(
                            fontFamily: "Nunito", fontWeight: FontWeight.bold),
                      ),
                      width: 50,
                      height: 52,
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade200),
                        ),
                      )),
                ])),
              ],
            ));
          } else if (index < users.length - 1) {
            return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    Container(
                        child: Text(user.namaGerobak),
                        width: 150,
                        height: 52,
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade200),
                          ),
                        )),
                    Container(
                        child: Text(user.jarak),
                        width: 50,
                        height: 52,
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade200),
                          ),
                        )),
                    Container(
                        child: Text(user.rating),
                        width: 50,
                        height: 52,
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade200),
                          ),
                        )),
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
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
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
                  ],
                ));
          } else {
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
          }
        },
      );
}
