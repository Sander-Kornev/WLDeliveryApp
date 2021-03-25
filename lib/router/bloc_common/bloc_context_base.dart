
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_base.dart';

class TextMessageAlert {
  List<DialogTextField> textFields;
  String? title;
  String? message;
  String? okLabel;

  Function(String?) completion;

  TextMessageAlert(this.textFields, this.title, this.message, this.okLabel, this.completion);
}

abstract class BlocContextBase<T extends BlocBase> {

  // обязательный к реализации метод
  void subscribe(T bloc, BuildContext context);

  void subscribeProgress(T bloc, BuildContext context) {
    (bloc as BlocBaseObj).outLoadingEvents.listen((bool isLoading) {
      if (isLoading) {
        showDialog(
            barrierDismissible: false,
            useSafeArea: false,
            context: context,
            builder: (_) {
              return Stack(
                children: [
                  Opacity(
                    opacity: 0.1,
                    child: ModalBarrier(
                        dismissible: false, color: Colors.black),
                  ),
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              );
            });
      } else {
        Navigator.pop(context);
      }
    });
  }

  void subscribeMessage(T bloc, BuildContext context) {
    (bloc as BlocBaseObj).outMessageEvents.listen((String message) {
      showOkAlertDialog(
          context: context,
          title: message,
          okLabel: 'Ok'
      );
    });
  }

  void subscribeTextMessage(T bloc, BuildContext context) {
    (bloc as BlocBaseObj).outTextAlertController.listen((TextMessageAlert textAlert) async {
      final results = await showTextInputDialog(
          context: context,
          textFields: textAlert.textFields,
          title: textAlert.title,
          message: textAlert.message,
          okLabel: textAlert.okLabel
      );
      textAlert.completion(results?.first);
    });
  }
}
