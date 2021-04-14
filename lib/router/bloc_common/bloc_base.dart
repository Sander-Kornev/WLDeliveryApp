import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_context_base.dart';

class BlocEvent<T> {
  T type;
  Map<String, dynamic>? parameters;

  BlocEvent({required this.type, this.parameters});
}

// Generic Interface for all BLoCs
abstract class BlocBaseObj<T, P> extends BlocBase<T> {
  StreamController<BlocEvent<P>> _eventsController = StreamController<
      BlocEvent<P>>();

  BlocBaseObj(T state) : super(state);

  @protected
  Sink<BlocEvent<P>> get inEvents => _eventsController.sink;

  Stream<BlocEvent<P>> get outEvents => _eventsController.stream;

  StreamController<bool> _loadingController = StreamController<bool>();

  @protected
  Sink<bool> get inLoadingEvents => _loadingController.sink;

  Stream<bool> get outLoadingEvents => _loadingController.stream;

  StreamController<String> _messageController = StreamController<String>();

  @protected
  Sink<String> get inMessageEvents => _messageController.sink;

  Stream<String> get outMessageEvents => _messageController.stream;

  StreamController<MessageAlert> _messageAlertController = StreamController<MessageAlert>();

  @protected
  Sink<MessageAlert> get inMessageAlertEvents => _messageAlertController.sink;

  Stream<MessageAlert> get outMessageAlertEvents => _messageAlertController.stream;

  StreamController<TextMessageAlert> _textAlertController = StreamController<
      TextMessageAlert>();

  @protected
  Sink<TextMessageAlert> get inTextAlertController => _textAlertController.sink;

  Stream<TextMessageAlert> get outTextAlertController =>
      _textAlertController.stream;

  StreamController<Widget> _modalController = StreamController<
      Widget>();

  @protected
  Sink<Widget> get inModalController => _modalController.sink;

  Stream<Widget> get outModalController =>
      _modalController.stream;

  void dispose() {
    _eventsController.close();
    _loadingController.close();
    _messageController.close();
    _textAlertController.close();
    _modalController.close();
    _messageAlertController.close();
  }
}
