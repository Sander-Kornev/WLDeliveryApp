
import 'package:flutter/material.dart';
import 'package:wl_delivery/model/db/models/grocery_cafe.dart';
import 'package:wl_delivery/ui/common/list_state.dart';
import 'package:wl_delivery/ui/main/search_products/search_products_cubit.dart';
import 'package:wl_delivery/ui/main/search_products/search_products_screen.dart';

class Search extends SearchDelegate {

  SearchProductsCubit cubit;

  final GroceryCafe grocery;
  Search(this.grocery):
        cubit = SearchProductsCubit(grocery);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.chevron_left, size: 30,),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    if (query.isNotEmpty) {

      return FutureBuilder(
          future: cubit.searchResultFuture(query),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return SearchProductsList(initlistState: snapshot.data, cubit: cubit,);
            } else {
              return SearchProductsList(initlistState: ListScreenState.loading(), cubit: cubit,);
            }
          });
    }

    return Container(
      child: Center(
          child: Text('Start searching for products')
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {

      return FutureBuilder(
          future: cubit.searchResultFuture(query),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return SearchProductsList(initlistState: snapshot.data, cubit: cubit,);
            } else {
              return SearchProductsList(initlistState: ListScreenState.loading(), cubit: cubit,);
            }
          });
    }

    return Container(
      child: Center(
          child: Text('Start searching for products')
      ),
    );
  }
}