import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_delivery/extensions/optional.dart';
// import 'package:wl_delivery/extensions/string_extension.dart';
import 'package:wl_delivery/model/db/models/category.dart';
import 'package:wl_delivery/ui/common/list_state.dart';
import 'package:wl_delivery/ui/main/widgets/grocery_header_widget.dart';

import 'categories_cubit.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CategoriesCubit mainCubit = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Categories',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: BlocBuilder<CategoriesCubit, ListScreenState<Category>>(
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
                    final value = loadedState.values[index - 1] as Category;
                    return GestureDetector(
                      onTapDown: (_) => mainCubit.openDetals(value),
                      child: Container(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  value.title.orEmpty,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(value.image.orEmpty),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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