
import 'package:flutter/material.dart';
import 'package:wl_delivery/model/db/models/grocery_cafe.dart';
import 'package:wl_delivery/router/bloc_common/bloc_base.dart';
import 'package:wl_delivery/router/bloc_common/bloc_context_base.dart';
import 'package:wl_delivery/router/bloc_common/bloc_provider.dart';
import 'package:wl_delivery/router/router_delegate.dart';
import 'package:wl_delivery/router/ui_pages.dart';
import 'package:wl_delivery/ui/common/list_state.dart';
import 'package:wl_delivery/ui/main/categories/categories_bloc_context.dart';
import 'package:wl_delivery/ui/main/categories/categories_cubit.dart';
import 'package:wl_delivery/ui/main/categories/categories_screen.dart';
import 'main_cubit.dart';

class MainBlocContext extends BlocContextBase<MainCubit> {

  AppRouterDelegate router;

  MainBlocContext(this.router);

  @override
  void subscribe(MainCubit bloc, BuildContext context) {
    bloc.outEvents.listen((BlocEvent<ListBlocEvent> event) {
      switch (event.type) {
        case ListBlocEvent.openDetails:
          router.pushWidget(BlocProviderObj(
            child: CategoriesScreen(),
            bloc: CategoriesCubit(event.parameters![GroceryCafe.staticTableName] as GroceryCafe, null),
            blocContext: CategoriesBlocContext(router),
          ), CategoriesPageConfig);
          break;
        default:
          assert(false, "Should never reach there");
          break;
      }
    });
  }
}
