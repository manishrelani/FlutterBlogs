import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:news/NextPage.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  final cid, txt;
  HomePage(this.cid, this.txt);
  @override
  _HomePageState createState() => _HomePageState(cid, txt);
}

class _HomePageState extends State<HomePage> {
  var cid, txt;
  _HomePageState(this.cid, this.txt);
  var url;
  var data;
  String imgurl = "http://news.raushanjha.in/upload/";
  load() {
    return SpinKitFadingCircle(color: Colors.red);
  }

  Future getjsondata() async {
    url = "http://news.raushanjha.in/flutterapi/public/index.php/getnewsall";
    var response = await http.get(url);
    if (mounted) {
      setState(() {
        var convertdata = json.decode(response.body);
        data = convertdata;
        print(data);
      });
    }
  }

  @override
  void initState() {
    getjsondata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(txt),
        centerTitle: true,
      ),
      body: data == null
          ? load()
          : cid == ""
              ? ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NextPage(data, index)),
                              );
                            },
                            child: data[index]["news_image"] == null
                                ? load
                                : Container(
                                    height: 200,
                                    width: double.infinity,
                                    child: CachedNetworkImage(
                                      imageUrl: "http://news.raushanjha.in/upload/${data[index]["news_image"]}",
                                      fit: BoxFit.fill, 
                                      placeholder: (context, url) => load(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8, left: 4, right: 4),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.99,
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Wrap(
                              children: <Widget>[
                                Text(
                                  data[index]["news_title"],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  })
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index1) {
                    return data[index1]["ID"] == cid
                        ? Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NextPage(data, index1)),
                                    );
                                  },
                                  child: data[index1]["news_image"] == null
                                      ? load
                                      : Container(
                                          height: 200,
                                          width: double.infinity,
                                          child: Image.network(
                                            imgurl + data[index1]["news_image"],
                                            fit: BoxFit.fitWidth,
                                          )),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 8, left: 4, right: 4),
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.99,
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Wrap(
                                    children: <Widget>[
                                      Text(
                                        data[index1]["news_title"],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container();
                  }),
    );
  }
}
