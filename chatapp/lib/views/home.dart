import 'package:chatapp/net/flutterfire.dart';
import 'package:chatapp/views/signup.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/net/database.dart';

class HomeView extends StatefulWidget with PreferredSizeWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _HomeViewState extends State<HomeView> {
  Widget appBarTitle = new Text('ChatApp');
  TextEditingController searchController = TextEditingController();
  Icon actionIcon = new Icon(Icons.search);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [
          PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: AppBar(
              title: appBarTitle,
              backgroundColor: Color.fromARGB(255, 59, 167, 230),
              actions: [
                IconButton(
                    onPressed: () async {
                      await signOut();
                      Navigator.pop(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    icon: Icon(Icons.logout)),
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: IconButton(
                    icon: actionIcon,
                    onPressed: () {
                      setState(() {
                        if (this.actionIcon.icon == Icons.search) {
                          this.actionIcon = new Icon(Icons.close);
                          this.appBarTitle = new TextField(
                            controller: searchController,
                            style: TextStyle(
                                fontSize: 22.0, color: Color(0xFFbdc6cf)),
                            decoration: InputDecoration(
                              hintText: 'Search here',
                            ),
                          );
                        } else {
                          this.actionIcon = new Icon(Icons.search);
                          this.appBarTitle = new Text('ChatApp');
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          //MaterialButton(
          //  onPressed: () async {
          //  await InsertData();
          //},
          //child: Text("ADD DATA"))
        ]),
      ),
    );
  }
}
