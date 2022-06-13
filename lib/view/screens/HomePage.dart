import 'package:flutter/material.dart';
import 'package:miniflutter/view/custom_widgets/drawer.dart';
import 'package:miniflutter/view/screens/tabbar_views/users_chat_list.dart';
import 'package:miniflutter/view/screens/tabbar_views/profile_page.dart';


class HomePage extends StatelessWidget {
  static const String routeName = 'HomePage';

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: DrawerWidget(),
        appBar: AppBar(
          bottom: TabBar(
            labelColor: Colors.black26,
            tabs: [
                Tab(text: 'Home',icon: Icon(Icons.home),),
              Tab(text: 'PersonalInfo',icon: Icon(Icons.person),)
            ],
          ),
        ),
        body: TabBarView(children: [
          UsersChatList(),
          ProfilePage()
        ],

        )

      ),
    );
  }
}
