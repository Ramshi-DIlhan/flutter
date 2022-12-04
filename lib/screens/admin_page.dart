import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitpod_flutter_quickstart/screens/admin_page_2.dart';
import 'package:gitpod_flutter_quickstart/service/auth.dart';
import 'package:gitpod_flutter_quickstart/service/controller.dart';
import 'package:gitpod_flutter_quickstart/service/database.dart';

class AdminPage extends StatelessWidget {
  AdminPage({Key? key}) : super(key: key);

  final _auth = AuthService();

  List allplayers = [];
  final _cont = Controller();

  @override
  Widget build(BuildContext context) {
    _auth.listenAuth();
    return Scaffold(
        appBar: AppBar(
          title: Text('Admin'),
          actions: [
            ElevatedButton(
              onPressed: () {
                _auth.Logout();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Log Out',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                allplayers = await DatabaseService(uid: 'test').AdminFetch();
                _cont.listcount.value++;
              },
              child: Text('Refresh'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width) * (5 / 14),
                  child: Text('Name',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width) * (5 / 14),
                  child: Text('Department',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width / 3) * (4 / 14),
                  child: Text('Score',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            Divider(),
            Obx(() {
              print(_cont.listcount.value);
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 40,
                            width:
                                (MediaQuery.of(context).size.width) * (3 / 8),
                            child: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                  allplayers[index].data()['name'].toString(),
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width:
                                (MediaQuery.of(context).size.width) * (3 / 8),
                            child: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                  allplayers[index].data()['dept'].toString(),
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: (MediaQuery.of(context).size.width / 3) *
                                (2 / 8),
                            child: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                  allplayers[index].data()['score'].toString(),
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      onTap: () async {
                        final result = await DatabaseService(uid: '')
                            .PlayerFetch(allplayers[index].id);
                        Get.to(() => SinglePlayerInfoPage(
                              result: result,
                            ));
                      },
                    );
                  }),
                  separatorBuilder: ((context, index) {
                    return Divider();
                  }),
                  itemCount: allplayers.length,
                ),
              );
            }),
          ],
        ));
  }
}
