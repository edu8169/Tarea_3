import 'package:flutter/material.dart';
import 'package:tarea_3/Pantallas/book_found.dart';

class BookResults extends StatelessWidget {
  final Map<dynamic, dynamic> books;
  final int index;

  const BookResults({super.key, required this.books, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => BookFound(
                    bookInfo: books["volumeInfo"],
                  ))));
        },
        child: Container(
            padding: EdgeInsets.all(5),
            child: Column(children: [
              Container(
                  height: 150,
                  width: 120,
                  child: _displayImage(books["volumeInfo"])),
              SizedBox(height: 10),
              Container(
                  child: Flexible(
                      fit: FlexFit.tight,
                      child: Text("${books["volumeInfo"]["title"]}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          textAlign: TextAlign.justify)))
            ])));
  }

  Widget _displayImage(Map media) {
    if (media["imageLinks"] == null) {
      return Image.asset("assets/book-asset.png");
    }
    return FadeInImage.assetNetwork(
      placeholder: 'assets/book-asset.png',
      image: "${media["imageLinks"]["thumbnail"]}",
    );
  }
}
