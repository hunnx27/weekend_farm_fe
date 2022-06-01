import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mapInfo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      title: 'T_D farm',
      home: homepage(),
    );
  }
}

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _bottomNavitate();
}

String _setTitle = 'T_D farm';
var _setBody = farm_info();

class _bottomNavitate extends State<homepage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        _setTitle = "농장정보";
        _setBody = farm_info();
      }
      if (index == 1) {
        _setTitle = "커뮤니티";
      }
      if (index == 2) {
        _setTitle = "농장 물건구입";
      }
      if (index == 3) {
        _setTitle = '내정보';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/farmDetail': (context) => farmDetail()},
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(_setTitle),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SearchPage())),
                icon: Icon(Icons.search))
          ],
          centerTitle: true,
        ),
        body: _setBody,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 7, 255, 160),
          selectedFontSize: 10,
          unselectedFontSize: 10,
          currentIndex: _selectedIndex, // 현재 선택된 메뉴
          selectedItemColor: Color.fromARGB(255, 76, 0, 253),
          // unselectedItemColor: Colors.amber,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              // backgroundColor: Colors.transparent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'chat',
              // backgroundColor: Colors.transparent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_grocery_store),
              label: 'shop',
              // backgroundColor: Colors.transparent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
              // backgroundColor: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> farmList = [
  {
    "name": "종완농장",
    "addrass": "경기도 광주시 문형리",
    "owner": "미상",
    "phone": "010-3151-2672",
    "id": 0,
    "likeCnt": 41,
    "description": "",
    "lat": 37.6541316,
    "lng": 126.877737,
    "price": 391
  },
  {
    "name": "지후닝농장",
    "addrass": "인천시 계양구 계산동",
    "owner": "최지훈",
    "phone": "010-5679-9557",
    "id": 1,
    "likeCnt": 20,
    "description": "",
    "lat": 37.6914065,
    "lng": 126.744659,
    "price": 100
  },
  {
    "name": "심솔농장",
    "addrass": "서울시 관악구 신림로 미성8길",
    "owner": "심지훈",
    "phone": "010-8555-2672",
    "id": 2,
    "likeCnt": 10,
    "description": "",
    "lat": 37.6389316,
    "lng": 126.809884,
    "price": 200
  },
];

class farm_info extends StatefulWidget {
  const farm_info({Key? key}) : super(key: key);

  @override
  State<farm_info> createState() => _farm_infoState();
}

class _farm_infoState extends State<farm_info> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          appBar: AppBar(
              title: TabBar(
                unselectedLabelColor: Color.fromARGB(255, 0, 0, 0),
                indicatorColor: Color.fromARGB(255, 68, 68, 66),
                labelColor: Color.fromARGB(255, 89, 0, 253),
                tabs: [
                  Tab(text: "지도"),
                  Tab(text: "리스트"),
                ],
              ),
              backgroundColor: Color.fromARGB(255, 223, 224, 223)),
          body: TabBarView(physics: NeverScrollableScrollPhysics(), children: [
            Container(child: mapinfo()),
            Center(
              child: ListView.builder(
                  itemCount: farmList.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> datalist = farmList[index];
                    String? name = datalist["name"];
                    String? address = datalist["addrass"];
                    String? owner = datalist["owner"];
                    String? phonNumber = datalist["phone"];
                    int? id = datalist["id"];
                    int findidx =
                        farmList.indexWhere((farm) => farm["id"] == id);

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: ListTile(
                            leading: Column(
                              children: [Text('농장명'), Text('$name')],
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '주소 : $address',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("농장주 : $owner"),
                                Text("연락처 : $phonNumber")
                              ],
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: IconButton(
                                    onPressed: () {
                                      print(farmList[findidx]);
                                      Navigator.pushNamed(
                                          context, farmDetail.routeName,
                                          arguments: farmList[findidx]);
                                    },
                                    icon: Icon(
                                      Icons.forward,
                                    ),
                                  ),
                                ),
                                Text(
                                  "더보기",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(indent: 75),
                      ],
                    );
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          // The search area here
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        /* Clear the search field */
                      },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none),
              ),
            ),
          )),
    );
  }
}

class farmDetail extends StatelessWidget {
  const farmDetail({Key? key}) : super(key: key);
  static const String routeName = "/farmDetail";

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    print(arguments);
    return Scaffold(
        appBar: AppBar(title: Text("농장 상세정보")),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              child: Row(
                children: [
                  Expanded(
                    /*1*/
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*2*/
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            arguments['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          arguments['addrass'],
                          style: TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*3*/
                  Icon(
                    Icons.star,
                    color: Colors.red[500],
                  ),
                  Text(arguments['likeCnt'].toString()), //like 받아오기
                ],
              ),
            ),
          ],
        ));
  }
}
