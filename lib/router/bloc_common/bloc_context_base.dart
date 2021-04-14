
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'bloc_base.dart';

class TextMessageAlert {
  List<DialogTextField> textFields;
  String? title;
  String? message;
  String? okLabel;

  Function(String?) completion;

  TextMessageAlert(this.textFields, this.title, this.message, this.okLabel, this.completion);
}

class MessageAlert<T> {
  String title;
  String? message;

  void Function(T) completion;

  //     String? okLabel,
  // String? cancelLabel,
  List<AlertDialogAction<T>> actions;

  MessageAlert(this.title, this.message, this.actions, this.completion);
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

  void subscribeConfirmationMessage(T bloc, BuildContext context) {
    (bloc as BlocBaseObj).outMessageAlertEvents.listen((MessageAlert alert) async {
      final results = await showAlertDialog(
          context: context,
          title: alert.title,
          actions: alert.actions,
          message: alert.message
      );
      alert.completion(results);
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

  void subscribeModalPresentation(T bloc, BuildContext context) {
    (bloc as BlocBaseObj).outModalController.listen((Widget widget) async {
      showCupertinoModalBottomSheet(
        context: context,
        builder: (context) => widget,
      );
    });
  }
}
