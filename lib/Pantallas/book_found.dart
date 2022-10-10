import 'package:flutter/material.dart';

class BookFound extends StatelessWidget {
  final Map bookInfo;
  const BookFound({super.key, required this.bookInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detalles"),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.public)),
            IconButton(onPressed: () {}, icon: Icon(Icons.share))
          ],
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Align(
                alignment: Alignment.center,
                child: Column(children: [
                  SizedBox(height: 20),
                  Container(
                    height: 300,
                    width: 220,
                    child: _displayImage(bookInfo),
                  ),
                  SizedBox(height: 25),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                        child: Flexible(
                      child: Text("${bookInfo["title"]}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                    ))
                  ]),
                  SizedBox(height: 25),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    SizedBox(height: 25),
                    Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${bookInfo["publishedDate"]}",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          _displayPageCount(),
                          SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Container(
                                  width: 300,
                                  child:
                                      Flexible(child: _displayDescription())))
                        ])
                  ])
                ]))));
  }

  Text _displayPageCount() {
    if (bookInfo["pageCount"] == null) {
      return Text("No Info");
    }
    return Text("Paginas: ${bookInfo["pageCount"]}");
  }

  Text _displayDescription() {
    if (bookInfo["description"] == null) {
      return Text("No Info");
    }
    return Text("${bookInfo["description"]}",
        textAlign: TextAlign.justify,
        overflow: TextOverflow.ellipsis,
        maxLines: 6);
  }

  Widget _displayImage(Map media) {
    if (media["imageLinks"] == null) {
      return Image.asset("assets/book.png", fit: BoxFit.fill);
    }
    return Image.network("${media["imageLinks"]["thumbnail"]}",
        fit: BoxFit.fill);
  }
}
