import 'package:flutter/material.dart';
import 'package:wl_delivery/extensions/optional.dart';
import 'package:wl_delivery/model/db/models/product.dart';
import 'package:wl_delivery/ui/common/list_state.dart';
import 'package:wl_delivery/ui/main/search_products/search_products_cubit.dart';
import 'package:wl_delivery/ui/main/widgets/product_list_tile.dart';

class SearchProductsList extends StatefulWidget {

  ListScreenState<ProductCount> initlistState;
  SearchProductsCubit cubit;

  SearchProductsList({
    required this.initlistState,
    required this.cubit
  });

  @override
  _SearchProductsListState createState() {
    return _SearchProductsListState();
  }
}

class _SearchProductsListState extends State<SearchProductsList> {

  ListScreenState<ProductCount>? listState;
  _addProduct(Product product) {
    setState(() {
      listState = widget.cubit.add(product);
    });
  }

  _removeProduct(Product product) {
    setState(() {
      listState = widget.cubit.remove(product);
    });
  }

  ListScreenState<ProductCount> get stateObject {
    return listState ?? widget.initlistState;
  }

  @override
  Widget build(BuildContext context) {
    if (stateObject is Loading) {
      return Center(child: CircularProgressIndicator());
    } else if (stateObject is ErrorDetails) {
      final errorState = stateObject as ErrorDetails;
      return Center(
        child: Text(errorState.message.orEmpty),
      );
    } else if (stateObject is Data) {
      final loadedState = stateObject as Data;
      return ListView.separated(
        itemCount: loadedState.values.length,
        itemBuilder: (context, index) {
          final value = loadedState.values[index] as ProductCount;
          return ProductListTile(
            productCount: value,
            addAction: (() => _addProduct(value.product)),
            removeAction: (() => _removeProduct(value.product)),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 1,
          );
        },
      );
    }
    return Container();
  }
}