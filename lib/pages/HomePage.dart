import 'package:flutter/material.dart';
import 'package:notes_app/pages/NoteListPage.dart';


class MyHome extends StatefulWidget {
  @override
  MyHomeState createState() => MyHomeState();
}

class MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  TabController _homeTabController;
  Color _color;

  @override
  void initState() {
    super.initState();

    _homeTabController = TabController(length: 2, vsync: this);
    _color = Colors.blue;
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
    );
  }

  getHomeAppBar() {
    return AppBar(
      title: Text("My Note"),
      backgroundColor: _color,
    );
  }

  getHomeTabBarView() {
    return TabBarView(
      children: getHomeTabBarItems(),
      controller: _homeTabController,
    );
  }

  getHomeTabBarItems() {
    return <Widget>[NoteListPage(), Text("Add Note")];
  }

  getHomeBottomNavigationBar() {
    return Material(color: _color, child: getHomeTabBar());
  }

  getHomeTabBar() {
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
