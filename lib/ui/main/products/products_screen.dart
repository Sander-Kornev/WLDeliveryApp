import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_delivery/extensions/optional.dart';
import 'package:wl_delivery/model/db/models/category.dart';
import 'package:wl_delivery/model/db/models/product.dart';
import 'package:wl_delivery/ui/common/list_state.dart';
import 'package:wl_delivery/ui/main/products/products_cubit.dart';
import 'package:wl_delivery/ui/main/widgets/grocery_header_widget.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductsCubit mainCubit = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text(
          mainCubit.parentCategory.title.orEmpty,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: BlocBuilder<ProductsCubit, ListScreenState<Product>>(
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
                    final value = loadedState.values[index - 1] as Product;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(value.image.orEmpty),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                [
                                  Text(
                                    value.title.orEmpty,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${value.price.toString()} \$',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                      ),
                                      // Spacer(),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.pink
                                        ),
                                        child: Row(
                                          children: [
                                            TextButton(child: Text('-'), onPressed: (){},),
                                            Text('count'),
                                            TextButton(child: Text('+'), onPressed: (){},)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ]
                          ),
                        ],
                      ),
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