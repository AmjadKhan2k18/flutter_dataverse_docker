import 'dart:async';

import 'package:dataverse/providers/accounts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OurSearchField extends StatefulWidget {
  const OurSearchField({Key? key}) : super(key: key);

  @override
  State<OurSearchField> createState() => OurSearchFieldState();
}

class OurSearchFieldState extends State<OurSearchField> {
  Timer? debouncer;

  @override
  void dispose() {
    if (debouncer != null) debouncer!.cancel();
    super.dispose();
  }

  onChangeValue(String? value) {
    if (debouncer != null && debouncer!.isActive) debouncer!.cancel();

    debouncer = Timer(const Duration(milliseconds: 500), () {
      context.read<AccountsState>().searchStr = value;
    });
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      onChanged: onChangeValue,
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(12),
          hintText: 'Search...',
          border: InputBorder.none),
    );
  }
}
