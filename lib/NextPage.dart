import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter_html/flutter_html.dart';

class NextPage extends StatefulWidget {
  final data, index;
  NextPage(this.data, this.index);
  @override
  _NextPageState createState() => _NextPageState(data, index);
}

class _NextPageState extends State<NextPage> {
  String title;
  var data, index;
  _NextPageState(this.data, this.index);
  load() {
    return SpinKitFadingCircle(
      color: Colors.blue,
      size: 30,
    );
  }

  // String url;
  /* _launch() {
    return url = data[index]['url'];
  } */

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            Icon(Icons.more_vert),
          ],
        ),
        body: PageView.builder(
            itemCount: data.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: size.height * 0.25,
                        child: data[index]["news_image"] == null
                            ? load()
                            : Image.network(
                                "http://news.raushanjha.in/upload/${data[index]["news_image"]}",
                                fit: BoxFit.fill,
                              ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 13),
                        height: size.height * 0.282,   
                        alignment: Alignment(1, 1),
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 32,
                          child: Icon(
                            Icons.bookmark,
                            size: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: size.height*0.15, 
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                      children: <Widget>[
                        Text(
                          data[index]["news_title"],
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                        Container(margin: EdgeInsets.only(top: 5), 
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.calendar_today),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  data[index]["news_date"],
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 1,
                          color: Colors.pink, 
                          width: double.infinity,
                        )
                      ],
                    ),
                  ),
                  Container(
                      //height: size.height * 0.35,
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 25),
                      child: data[index]["news_description"] == null
                          ? load()
                          : Html(
                              data: data[index]["news_description"],
                                
                            )

                      /* Text(
              data[index]["news_description"],
              style: TextStyle(fontSize: 20),
              textScaleFactor: 1,
              textAlign: TextAlign.justify,
                            ), */
                      ),
                ],
              );
            }));
  }
}
