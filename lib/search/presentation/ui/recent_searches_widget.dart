import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_dashboard/search/presentation/cubit/search_cubit.dart';

class RecentSearches extends StatelessWidget {
  const RecentSearches({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Column(
          children: [
            Flexible(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final String item = state.recentSearches[index];
                    return ListTile(
                      leading: const Icon(Icons.history),
                      title: Text(item),
                      onTap: () {
                        // context.read<UserCubit>().searchResults(query: item);
                        // setState(() {
                        //   widget.controller.text = item;
                        //   widget.focusNode.unfocus();
                        // });
                      },
                    );
                  },
                  itemCount: state.recentSearches.length),
            ),
            state.recentSearches.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: TextButton(
                        onPressed: () {
                          context.read<SearchCubit>().clearSearchHistory();
                        },
                        child: const Text("Clear search history")),
                  )
                : const SizedBox(),
          ],
        );
      },
    );
  }
}
