import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_context_base.dart';

class BlocProviderObj<T extends BlocBase> extends StatefulWidget {
  BlocProviderObj(
      {required this.child,
      required this.bloc,
      required this.blocContext,
      Key? key})
      : super(key: key);

  final T bloc;
  final Widget child;
  final BlocContextBase<T> blocContext;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProviderObj<BlocBase>> {
  @override
  void initState() {
    super.initState();
    widget.blocContext.subscribe(widget.bloc, context);
    widget.blocContext.subscribeProgress(widget.bloc, context);
    widget.blocContext.subscribeMessage(widget.bloc, context);
    widget.blocContext.subscribeConfirmationMessage(widget.bloc, context);
    widget.blocContext.subscribeTextMessage(widget.bloc, context);
    widget.blocContext.subscribeModalPresentation(widget.bloc, context);
  }

  @override
  void dispose() {
    // widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<T>(
      create: (BuildContext context) { return widget.bloc as T; },
      child: widget.child,
    );
  }
}
