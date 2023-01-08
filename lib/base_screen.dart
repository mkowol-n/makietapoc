import 'package:flutter/material.dart';

import 'content_body.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: Text("title"),
        ),
        body: ContentBody(),
      ),
    );
  }
}
