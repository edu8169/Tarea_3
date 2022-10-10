import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarea_3/widgets/book_results.dart';
import 'package:tarea_3/widgets/shimmer.dart';

import '../bloc/books_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  String searchedbook = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Libreria free to play")),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(10),
                child: Column(children: [
                  TextField(
                    onChanged: (value) {
                      searchedbook = value;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Ingrese Titulo",
                        suffixIcon: IconButton(
                            onPressed: () {
                              BlocProvider.of<BooksBloc>(context).add(
                                  BooksSearchedEvent(
                                      titleSearched: searchedbook));
                            },
                            icon: Icon(Icons.search))),
                  ),
                  SizedBox(height: 20),
                  BlocConsumer<BooksBloc, BooksState>(
                      listener: (context, state) {
                    if (state is BooksNotFoundState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${state.errorMessage}")));
                    }
                  }, builder: (context, state) {
                    if (state is BooksSearchState) {
                      return shimmerDisplay(context);
                    } else if (state is BooksFoundState) {
                      print(context.watch<BooksBloc>().books[0]);
                      return resultsFromSearch(context);
                    } else {
                      return Column(children: [
                        SizedBox(height: 260),
                        Text("Busque un libro en la barra superior")
                      ]);
                    }
                  })
                ]))));
  }

  Container shimmerDisplay(BuildContext context) {
    return Container(
      height: 575,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1,
            crossAxisSpacing: 30,
            mainAxisSpacing: 35),
        itemCount: context.watch<BooksBloc>().books.length,
        itemBuilder: (BuildContext context, int index) {
          return ShimmerWidget();
        },
      ),
    );
  }

  Container resultsFromSearch(BuildContext context) {
    return Container(
      height: 575,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1,
            crossAxisSpacing: 30,
            mainAxisSpacing: 35),
        itemCount: context.watch<BooksBloc>().books.length,
        itemBuilder: (BuildContext context, int index) {
          return BookResults(
              books: context.watch<BooksBloc>().books[index], index: index);
        },
      ),
    );
  }
}
