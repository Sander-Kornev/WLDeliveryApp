// Settings Page
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:wl_delivery/model/db/models/product.dart';
import 'package:wl_delivery/ui/common/list_state.dart';
import 'package:wl_delivery/extensions/optional.dart';
import 'package:wl_delivery/ui/main/widgets/product_list_tile.dart';

import 'cart_cubit.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartCubit mainCubit = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Cart',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<CartCubit, ListScreenState<ProductCount>>(
          builder: (context, state) {
            if (state is Loading) {
              return CircularProgressIndicator();
            } else if (state is ErrorDetails) {
              final errorState = state as ErrorDetails;
              return Center(
                child: Text(errorState.message.orEmpty),
              );
            } else if (state is Data) {
              final loadedState = state as Data;
              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 350,
                    child: ListView.separated(
                      itemCount: loadedState.values.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return ListTile(
                              title: Text((mainCubit.grocery?.title).orEmpty));
                        } else {
                          final value = loadedState.values[index - 1] as ProductCount;
                          return Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.25,
                            child: ProductListTile(
                                productCount: value,
                                removeAction: () => mainCubit.remove(value.product),
                                addAction: () => mainCubit.add(value.product)
                            ),
                            secondaryActions: <Widget>[
                              IconSlideAction(
                                caption: 'Delete',
                                color: Colors.red,
                                icon: Icons.delete,
                                onTap: () => mainCubit.removeAll(value.product),
                              ),
                            ],
                          );
                        }
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          height: 1,
                        );
                      },
                    ),
                  ),
                  Divider(height: 2, thickness: 2),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Subtotal'),
                            Text(mainCubit.subtotal.orEmpty),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Delivery Fee'),
                            Text(mainCubit.deliveryFee.orEmpty),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
                            Text(mainCubit.total.orEmpty, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
                          ],
                        ),
                        SizedBox(height: 10,),
                        SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: mainCubit.checkoutAction,
                                child: Text('Checkout')
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
