import 'package:dataverse/models/account.dart';
import 'package:dataverse/providers/accounts.dart';
import 'package:dataverse/screens/loading.dart';
import 'package:dataverse/widgets/drawer.dart';
import 'package:dataverse/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ViewType { grid, list }

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  ViewType _viewType = ViewType.list;

  @override
  Widget build(BuildContext context) {
    final accountsState = context.watch<AccountsState>();
    return Scaffold(
      key: _key,
      endDrawer: const OurDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            actions: [
              IconButton(
                onPressed: toggleIsList,
                icon: Icon(
                  _viewType == ViewType.grid
                      ? Icons.grid_view_outlined
                      : Icons.list,
                  key: const Key('list_grid_icon'),
                ),
              ),
              IconButton(
                onPressed: _key.currentState?.openEndDrawer,
                icon: const Icon(
                  Icons.filter_list_alt,
                ),
              ),
            ],
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Expanded(
                    child: OurSearchField(
                      key: Key('search_field'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (accountsState.isLoading)
            const SliverToBoxAdapter(
                child: LoadingScreen(
              key: Key('is_loading'),
            )),
          if (accountsState.error != null)
            SliverToBoxAdapter(
              child: Center(child: Text(accountsState.error!)),
            ),
          if (!accountsState.isLoading && accountsState.error == null) ...[
            if (accountsState.accounts.isEmpty)
              const SliverToBoxAdapter(
                child: Center(child: Text('No Accounts found')),
              ),
            if (_viewType == ViewType.list)
              AccountsListView(
                accounts: accountsState.accounts,
                key: const Key('accounts_list_view'),
              ),
            if (_viewType == ViewType.grid)
              AccountsGridView(
                accounts: accountsState.accounts,
              )
          ]
        ],
      ),
    );
  }

  toggleIsList() {
    if (_viewType == ViewType.list) {
      _viewType = ViewType.grid;
    } else {
      _viewType = ViewType.list;
    }
    setState(() {});
  }
}

class AccountsListView extends StatelessWidget {
  final List<Account> accounts;
  const AccountsListView({required this.accounts, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final account = accounts[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    account.statecode == 1 ? Colors.red : Colors.green,
              ),
              trailing: account.address == null
                  ? null
                  : Text(
                      account.address!,
                    ),
              title: Text(account.name),
              subtitle: accounts[index].accountnumber == null
                  ? null
                  : Text(
                      accounts[index].accountnumber!,
                    ),
            ),
          );
        },
        childCount: accounts.length,
      ),
    );
  }
}

class AccountsGridView extends StatelessWidget {
  final List<Account> accounts;
  const AccountsGridView({required this.accounts, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 2,
      children: accounts
          .map(
            (account) => Card(
              key: const Key('account_card'),
              color: account.statecode == 1
                  ? Colors.red.shade200
                  : Colors.green.shade200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(account.name),
                  if (account.accountnumber != null) ...[
                    const SizedBox(
                      height: 8,
                    ),
                    Text(account.accountnumber!),
                  ],
                  if (account.address != null) ...[
                    const SizedBox(
                      height: 8,
                    ),
                    Text(account.address!)
                  ],
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
