import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:news/HomePage.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  spin() {
    return SpinKitRotatingPlain(color: Colors.red);
  }

  var url;
  List data;
  String imgurl = "http://news.raushanjha.in/upload/";
  Future getjsondata() async {
    url = "http://news.raushanjha.in/flutterapi/category";
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
    return data == null
        ? spin()
        : Scaffold(
            body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                title: Container(
                  height: 130,
                  width: 130,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Stack(
                    children: <Widget>[
                      GestureDetector(
                          child: Container(
                            color: Colors.grey,
                            margin: EdgeInsets.all(10),
                            height: 150,
                            width: double.infinity,
                            child: CachedNetworkImage(
                              imageUrl:
                                  data[index]["category_image"],
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage(
                                        data[index]["cid"],
                                        data[index]["category_name"])));
                          }),
                      Container(
                        margin: EdgeInsets.only(top: 120, left: 14),
                        height: 70,
                        width: MediaQuery.of(context).size.width * 0.99,
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          data[index]["category_name"],
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  childCount: data.length,
                ),
              ),
            ],
          ));
  }
}
