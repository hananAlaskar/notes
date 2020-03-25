import 'package:flutter/material.dart';
import 'package:notes_app/pages/AddNotePage.dart';
import 'package:notes_app/pages/NoteListPage.dart';


class MyHome extends StatefulWidget {
  @override
  MyHomeState createState() => MyHomeState();
}

class MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  TabController _homeTabController;

  @override
  void initState() {
    super.initState();

    _homeTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _homeTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getHomeAppBar(),
      body: getHomeTabBarView(),
      bottomNavigationBar: getHomeBottomNavigationBar(),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }

  AppBar getHomeAppBar() {
    return AppBar(
      title: Text("My Note"),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  TabBarView getHomeTabBarView() {
    return TabBarView(
      children: getHomeTabBarItems(),
      controller: _homeTabController,
    );
  }

   getHomeTabBarItems() {
    return <Widget>[NoteListPage(), AddNotePage()];
  }

  Material getHomeBottomNavigationBar() {
    return Material(color:  Theme.of(context).primaryColor, child: getHomeTabBar());
  }

  TabBar getHomeTabBar() {
    return TabBar(
      tabs: <Tab>[
        Tab(
          icon: Icon(Icons.note),
        ),
        Tab(
          icon: Icon(Icons.add),
        ),
      ],
      controller: _homeTabController,
    );
  }
}
