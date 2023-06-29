// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

extension ToLIstView<T> on Iterable<T> {
  Widget toListView() => IterableListView(iterable: this);
}

class IterableListView<T> extends StatelessWidget {
  final Iterable<T> iterable;
  const IterableListView({
    Key? key,
    required this.iterable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: iterable.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(iterable.elementAt(index).toString()),
        );
      },
    );
  }
}
