
import 'package:flutter/material.dart';
import 'package:wl_delivery/model/db/models/grocery_cafe.dart';
import 'package:wl_delivery/router/bloc_common/bloc_base.dart';
import 'package:wl_delivery/router/bloc_common/bloc_context_base.dart';
import 'package:wl_delivery/router/router_delegate.dart';
import 'package:wl_delivery/router/ui_pages.dart';
import 'package:wl_delivery/ui/main/products/products_cubit.dart';
import 'package:wl_delivery/ui/main/search_products/search_products_delegate.dart';

class ProductsBlocContext extends BlocContextBase<ProductsCubit> {

  AppRouterDelegate router;

  ProductsBlocContext(this.router);

  @override
  void subscribe(ProductsCubit bloc, BuildContext context) {
    bloc.outEvents.listen((BlocEvent<ProductsBlocAction> event) {
      switch(event.type) {
        case ProductsBlocAction.search:
          showSearch(context: context, delegate: Search(event.parameters![GroceryCafe.staticTableName] as GroceryCafe));
          break;
        case ProductsBlocAction.login:
          router.setNewRoutePath(LoginPageConfig);
          break;
      }
    });
  }
}