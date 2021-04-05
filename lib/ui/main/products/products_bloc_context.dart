
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:wl_delivery/router/bloc_common/bloc_base.dart';
import 'package:wl_delivery/router/bloc_common/bloc_context_base.dart';
import 'package:wl_delivery/router/router_delegate.dart';
import 'package:wl_delivery/ui/main/products/products_cubit.dart';

class ProoductsBlocContext extends BlocContextBase<ProductsCubit> {

  AppRouterDelegate router;

  ProoductsBlocContext(this.router);

  @override
  void subscribe(ProductsCubit bloc, BuildContext context) {
    bloc.outEvents.listen((BlocEvent<Void> event) {

    });
  }
}
