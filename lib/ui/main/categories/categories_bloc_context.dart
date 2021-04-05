
import 'package:flutter/material.dart';
import 'package:wl_delivery/model/db/models/category.dart';
import 'package:wl_delivery/model/db/models/grocery_cafe.dart';
import 'package:wl_delivery/router/bloc_common/bloc_base.dart';
import 'package:wl_delivery/router/bloc_common/bloc_context_base.dart';
import 'package:wl_delivery/router/bloc_common/bloc_provider.dart';
import 'package:wl_delivery/router/router_delegate.dart';
import 'package:wl_delivery/router/ui_pages.dart';
import 'package:wl_delivery/ui/main/products/products_bloc_context.dart';
import 'package:wl_delivery/ui/main/products/products_cubit.dart';
import 'package:wl_delivery/ui/main/products/products_screen.dart';

import 'categories_cubit.dart';
import 'categories_screen.dart';

class CategoriesBlocContext extends BlocContextBase<CategoriesCubit> {

  AppRouterDelegate router;

  CategoriesBlocContext(this.router);

  @override
  void subscribe(CategoriesCubit bloc, BuildContext context) {
    bloc.outEvents.listen((BlocEvent<CategoriesBlocEvent> event) {
      switch (event.type) {
        case CategoriesBlocEvent.openSubcategory:
          router.pushWidget(BlocProviderObj(
            child: CategoriesScreen(),
            bloc: CategoriesCubit(event.parameters![GroceryCafe.staticTableName] as GroceryCafe, event.parameters![Category.staticTableName] as Category),
            blocContext: CategoriesBlocContext(router),
          ), CategoriesPageConfig);
          break;
        case CategoriesBlocEvent.openProducts:
          router.pushWidget(BlocProviderObj(
            child: ProductsScreen(),
            bloc: ProductsCubit(event.parameters![GroceryCafe.staticTableName] as GroceryCafe, event.parameters![Category.staticTableName] as Category),
            blocContext: ProoductsBlocContext(router),
          ), CategoriesPageConfig);
          break;
        default:
          assert(false, "Should never reach there");
          break;
      }
    });
  }
}
