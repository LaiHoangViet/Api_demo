import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String token;
  int userid;

  int list_catelogy_id;

  String list_topic_content;
  int list_topic_id;

  int topic_test_id;
  String topic_test_question;
  String topic_test_answer1;
  String topic_test_answer2;
  String topic_test_answer3;
  String topic_test_answer4;

  @override
  // Khởi tạo biến
  void initState() {
    setState(() {
      token = 'abc: ';
      userid = 0;
    });
  }

  void login() async {
    var api = 'http://apiiq.bigorder.vn/api/v1/user/auto-login';
    http.Response response = await http.post(api);
    if (response.statusCode == 200) {
      try {
        var api1 = jsonDecode(response.body);
        setState(() {
          token = api1['data']['token'];
          userid = api1['data']['id'];
        });
      } catch (e) {
        print(e);
      }
    } else {
      print(response.statusCode);
    }
  }

  void abc() async {
    var api =
        'http://apiiq.bigorder.vn/api/v1/topic/list-category?userid=$userid&token=$token';
    http.Response response = await http.get(api);
    if (response.statusCode == 200) {
      try {
        var api1 = jsonDecode(response.body);
        // Cập nhật trạng thái
        setState(() {
          list_catelogy_id = api1["categorys"][0]['id'];
        });
      } catch (e) {
        print(e);
      }
    } else {
      print(response.statusCode);
    }
  }

  void list_topic() async {
    var api =
        'http://apiiq.bigorder.vn/api/v1/topic/list-topic?category_id=$list_catelogy_id&token=$token&userid=$userid';
    http.Response response = await http.get(api);
    if (response.statusCode == 200) {
      try {
        var api1 = jsonDecode(response.body);
        // Cập nhật trạng thái
        setState(() {
          list_topic_content = api1["data"][0]['content'];
          list_topic_id = api1["data"][0]['id'];
        });
        print(api1['data'][0]['content']);
      } catch (e) {
        print(e);
      }
    } else {
      print(response.statusCode);
    }
  }

  void topic_test() async {
    var api =
        'http://apiiq.bigorder.vn/api/v1/topic/topic-test?topic_id=$list_topic_id&token=$token&userid=$userid';
    http.Response response = await http.get(api);
    if (response.statusCode == 200) {
      try {
        var api1 = jsonDecode(response.body);
        // Cập nhật trạng thái
        setState(() {
          topic_test_id = api1["data"][0]['id'];
          topic_test_question = api1["data"][0]['question'];
          topic_test_answer1 = api1["data"][0]['answer'][0]['answer'];
          topic_test_answer2 = api1["data"][0]['answer'][1]['answer'];
          topic_test_answer3 = api1["data"][0]['answer'][2]['answer'];
          topic_test_answer4 = api1["data"][0]['answer'][3]['answer'];
        });
        print(api1["data"][0]['question']);
      } catch (e) {
        print(e);
      }
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'hjgjhg',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        color: Colors.green[100],
        child: Column(
          children: <Widget>[
            Text(
              token,
            ),
            Text(
              userid.toString(),
            ),
            Text(
              list_catelogy_id.toString(),
            ),
            Text(
              list_topic_content.toString(),
            ),
            Text(
              topic_test_question.toString(),
            ),
            Text(topic_test_answer1 ?? 'defaul null'),
            Text(topic_test_answer2 ?? 'defaul null'),
            Text(topic_test_answer3 ?? 'defaul null'),
            Text(topic_test_answer4 ?? 'defaul null'),
            RaisedButton(
              child: Text(
                'token',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                login();
              },
            ),
            RaisedButton(
              child: Text(
                'bấm',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                abc();
              },
            ),
            RaisedButton(
              child: Text(
                'List topic',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                list_topic();
              },
            ),
            RaisedButton(
              child: Text(
                'List question',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                topic_test();
              },
            ),
          ],
        ),
      ),
    );
  }
}
