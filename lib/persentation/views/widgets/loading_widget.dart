import 'package:flutter/material.dart';

class LoadingWidget {
  final BuildContext context;

  LoadingWidget(this.context);

  void show() {
    showDialog(
      context: context,
      builder: (_) => Center(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5)),
          child: const SizedBox(
            height: 100,
            width: 100,
            child: Center(
                child: CircularProgressIndicator(
              strokeWidth: 8,
            )),
          ),
        ),
      ),
    );
  }

  void close() {
    Navigator.pop(context);
  }
}
