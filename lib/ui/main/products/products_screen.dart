import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_delivery/extensions/optional.dart';
import 'package:wl_delivery/model/db/models/product.dart';
import 'package:wl_delivery/ui/common/list_state.dart';
import 'package:wl_delivery/ui/main/products/products_cubit.dart';
import 'package:wl_delivery/ui/main/widgets/grocery_header_widget.dart';
import 'package:wl_delivery/ui/main/widgets/product_list_tile.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductsCubit mainCubit = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        actions: <Widget>[
          IconButton(
            onPressed: mainCubit.search,
            icon: Icon(Icons.search),
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          mainCubit.parentCategory.title.orEmpty,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: BlocBuilder<ProductsCubit, ListScreenState<ProductCount>>(
          builder: (context, state) {
            if (state is Loading) {
              return CircularProgressIndicator();
            } else if (state is ErrorDetails) {
              final errorState = state as ErrorDetails;
              return Center(
                child: Text(
                    errorState.message.orEmpty
                ),
              );
            } else if (state is Data) {
              final loadedState = state as Data;
              return ListView.separated(
                itemCount: loadedState.values.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return GroceryHeaderWidget(grocery: mainCubit.grocery);
                  } else {
                    final value = loadedState.values[index - 1] as ProductCount;
                    return ProductListTile(
                        productCount: value,
                        removeAction: (() => mainCubit.remove(value.product)),
                        addAction: (() => mainCubit.add(value.product))
                    );
                  }
                }, separatorBuilder: (BuildContext context, int index) { return const Divider(height: 1,); },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

