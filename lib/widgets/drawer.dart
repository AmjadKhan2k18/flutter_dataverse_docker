import 'package:dataverse/providers/accounts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OurDrawer extends StatefulWidget {
  const OurDrawer({Key? key}) : super(key: key);

  @override
  State<OurDrawer> createState() => _OurDrawerState();
}

class _OurDrawerState extends State<OurDrawer> {
  // we can also extract list of stateOrProvince from response when we get all accounts on first call
  List<String> stateOrProvinceList = const [
    "TX",
    "Guangdong",
    "WA",
    "CA",
    "NM",
    "IL",
    "OH",
    "NC",
    "Ontario",
    "CO"
  ];

  Map<String, dynamic> stateCode = {
    "All": 2,
    "Active": 0,
    "Inactive": 1,
  };

  @override
  Widget build(BuildContext context) {
    final accountsState = context.watch<AccountsState>();
    final height = MediaQuery.of(context).size.height;
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 5 / 100),
          Text(
            'Filter',
            style: Theme.of(context).textTheme.headline4,
          ),
          const Divider(),
          Text(
            'Active or Non-Active',
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: height * 0.1 / 100),
          Wrap(
            direction: Axis.horizontal,
            children: stateCode.keys
                .map(
                  (key) => CustomRadioButton(
                    isSelected: stateCode[key] == accountsState.state,
                    text: key,
                    onTap: () => accountsState.state = stateCode[key],
                  ),
                )
                .toList(),
          ),
          const Divider(),
          Text(
            'Sort by Province',
            style: Theme.of(context).textTheme.headline5,
          ),
          Center(
            child: DropdownButton<String>(
              value: accountsState.stateOrProvince,
              icon: const Icon(Icons.arrow_downward),
              hint: const Text('State Or Province'),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (value) => accountsState.stateOrProvince = value,
              items: stateOrProvinceList
                  .map<DropdownMenuItem<String>>((String stateOrProvince) {
                return DropdownMenuItem<String>(
                  value: stateOrProvince,
                  child: Text(stateOrProvince),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

class CustomRadioButton extends StatelessWidget {
  final bool isSelected;
  final String text;
  final Function() onTap;
  const CustomRadioButton({
    Key? key,
    required this.isSelected,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 60,
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        alignment: Alignment.center,
        child: Text(text),
      ),
    );
  }
}
