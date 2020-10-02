import 'package:flutter/material.dart';


class API{
  String linkList(int id ,String token){
    return 'http://apiiq.bigorder.vn/api/v1/topic/list-category?userid=${id}&token=${token}';
  }
}


class showInfo extends StatefulWidget {
  var tokenabc123;
  showInfo({Key key, @required this.tokenabc123}): super(key: key);
  @override
  _showInfoState createState() => _showInfoState();
}

class _showInfoState extends State<showInfo> {
  var tokenabc123;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test'),
        ),
        body: Container(
          child: Text('$tokenabc123'),
        ),
      ),
    );
  }
}
