import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_dashboard/search/presentation/cubit/search_cubit.dart';
import 'package:github_dashboard/search/presentation/ui/recent_searches_widget.dart';
import 'package:github_dashboard/user/presentation/bloc/user_bloc.dart';
import 'package:github_dashboard/user/presentation/ui/user_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchFocusNode = FocusNode();
  final _queryTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      if (_searchFocusNode.hasFocus) {
        context.read<SearchCubit>().startSearching();
      } else {
        context.read<SearchCubit>().stopSearching();
      }
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _queryTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchCubit, SearchState>(
      listener: (context, state) {
        if (state is SearchIdle && state.recentSearches.isNotEmpty) {
          _queryTextController.text = state.recentSearches.first;
          _searchFocusNode.unfocus();
          context
              .read<UserBloc>()
              .add(GetUserProfile(username: state.recentSearches.first));
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 70,
              title: SearchTextField(
                  searchFocusNode: _searchFocusNode,
                  queryTextController: _queryTextController),
            ),
            body: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                switch (state) {
                  case SearchIdle():
                    return const UserPage();
                  case SearchActive():
                    return const RecentSearches();
                }
              },
            )),
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required FocusNode searchFocusNode,
    required TextEditingController queryTextController,
  })  : _searchFocusNode = searchFocusNode,
        _queryTextController = queryTextController;

  final FocusNode _searchFocusNode;
  final TextEditingController _queryTextController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _searchFocusNode.hasFocus
                ? IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () => _searchFocusNode.unfocus(),
                  )
                : Container(),
            Flexible(
              child: SizedBox(
                height: 45,
                child: CupertinoSearchTextField(
                  controller: _queryTextController,
                  autofocus: false,
                  focusNode: _searchFocusNode,
                  style: const TextStyle(color: Colors.white),
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(10)),
                  onSubmitted: (value) {
                    context.read<SearchCubit>().addSearchTerm(value);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
