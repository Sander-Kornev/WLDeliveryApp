
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_delivery/model/db/models/grocery_cafe.dart';
import 'package:wl_delivery/ui/common/list_state.dart';
import 'package:wl_delivery/ui/main/restaurants/main_cubit.dart';
import 'package:wl_delivery/extensions/optional.dart';
import 'package:wl_delivery/extensions/double_extension.dart';
import 'package:wl_delivery/extensions/string_extension.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MainCubit mainCubit = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
            'Restaurants',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: BlocBuilder<MainCubit, ListScreenState<GroceryCafe>>(
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
              return ListView.builder(
                itemCount: loadedState.values.length,
                itemBuilder: (context, index) {
                  final value = loadedState.values[index] as GroceryCafe;
                  return GestureDetector(
                    onTapDown: (_) => mainCubit.openCategories(value),
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                DefaultTextStyle(
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.fitWidth,
                                              image: NetworkImage(value.image.orEmpty),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  value.title.orEmpty,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                                SizedBox(height: 10,),
                                                // Spacer(),
                                                Text(value.openTime.orEmpty)
                                              ],
                                            ),
                                            Text('Delivery fee: ${value.deliveryPrice.toCurrency}'),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 182, 10, 0),
                                        child: Container(
                                          decoration: ShapeDecoration(
                                            color: Colors.green,
                                            shape: StadiumBorder(),
                                          ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                  value.status.orEmpty.capitalize(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600
                                                ),
                                              ),
                                            )
                                        ),
                                      )
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider()
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}