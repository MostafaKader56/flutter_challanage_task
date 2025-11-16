import 'package:flutter/material.dart';

import 'widget/users_page_body.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: UsersPageBody()));
  }
}
