import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:platform_alert_dialog/platform_alert_dialog.dart';

class mapinfo extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<mapinfo> {
  late GoogleMapController mapController; //contrller for Google map
  final Set<Marker> markers = new Set(); //markers for google map
  List<Map<String, dynamic>> farmList = [
    {
      "name": "종완농장",
      "addrass": "경기도 광주시 문형리",
      "owner": "미상",
      "phone": "010-3151-2672",
      "id": 0,
      "likeCnt": 41,
      "description": "조용하고 한적한 가족 농장입니다.",
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
      "description": "사랑가득 꽃농장입니다.",
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
      "description": "훠킹! 오지마",
      "lat": 37.6389316,
      "lng": 126.809884,
      "price": 200
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        //Map widget from google_maps_flutter package
        zoomGesturesEnabled: true, //enable Zoom in, out on map
        initialCameraPosition: CameraPosition(
            // innital position in map
            target: getInitShowLocation(farmList), //initial position
            zoom: 10),
        indoorViewEnabled: true,
        markers: getmarkers(farmList), //markers to show on map
        mapType: MapType.normal, //map type
        onMapCreated: (controller) {
          //method called when map is created
          setState(() {
            mapController = controller;
          });
        },
      ),
    );
  }

  LatLng getInitShowLocation(List<Map<String, dynamic>> list) {
    LatLng showLocation =
        LatLng(37.6541316, 126.877737); //location to show in map
    return showLocation;
  }

  Set<Marker> getmarkers(List<Map<String, dynamic>> list) {
    //markers to place on map
    setState(() {
      for (int i = 0; i < list.length; i++) {
        markers.add(Marker(
          //add first marker
          markerId: MarkerId(LatLng(list[i]['lat'], list[i]['lng']).toString()),
          position: LatLng(list[i]['lat'], list[i]['lng']),
          // onTap: () {
          //   showDialog<void>(
          //     context: context,
          //     builder: (BuildContext context) {
          //       return PlatformAlertDialog(
          //         title: Text('Rewind and remember'),
          //         content: SingleChildScrollView(
          //           child: ListBody(
          //             children: <Widget>[
          //               Text('You will never be satisfied.'),
          //               Text('You\’re like me. I’m never satisfied.'),
          //             ],
          //           ),
          //         ),
          //         actions: <Widget>[
          //           PlatformDialogAction(
          //             child: Text('Cancel'),
          //             onPressed: () {
          //               Navigator.of(context).pop();
          //             },
          //           ),
          //           PlatformDialogAction(
          //             child: Text('정보 더보기'),
          //             actionType: ActionType.Preferred,
          //             onPressed: () {
          //               Navigator.of(context).pop();
          //             },
          //           ),
          //         ],
          //       );
          //     },
          //   );
          // }, //position of marker
          infoWindow: InfoWindow(
            //popup info
            title: list[i]["name"],
            snippet: list[i]["description"],
          ),
          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
        ));
      }

      //add more markers here
    });

    return markers;
  }
}
