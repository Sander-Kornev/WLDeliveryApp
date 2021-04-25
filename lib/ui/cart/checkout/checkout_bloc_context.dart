
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_delivery/helper/location/geocoding_manager.dart';
import 'package:wl_delivery/router/bloc_common/bloc_base.dart';
import 'package:wl_delivery/router/bloc_common/bloc_context_base.dart';
import 'package:wl_delivery/router/router_delegate.dart';
import 'package:wl_delivery/router/ui_pages.dart';
import 'package:wl_delivery/ui/search_address/search_address.dart';
import 'package:wl_delivery/ui/search_address/search_address_cubit.dart';
import 'checkout_cubit.dart';

class CheckoutBlocContext extends BlocContextBase<CheckoutCubit> {

  AppRouterDelegate router;

  CheckoutBlocContext(this.router);

  @override
  void subscribe(CheckoutCubit bloc, BuildContext context) {
    bloc.outEvents.listen((BlocEvent<CheckoutCubitEvent> event) {
      switch (event.type) {
        case CheckoutCubitEvent.selectAddress:
          router.pushWidget(
              BlocProvider(
                  create: (_) => SearchAddressCubit(event.completer as Completer<LocationItem>, router),
                  child: SearchAddressPage()
              ),
              ChangePasswordPageConfig
          );
          break;
        default:
          assert(false, "Should never reach there");
          break;
      }
    });
  }
}