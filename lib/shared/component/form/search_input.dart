import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:amaz_corp_mobile/shared/rate_limit.dart';
import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  final void Function(String value) onSearch;

  const SearchInput({
    super.key,
    required this.onSearch,
  });

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final _debouncedOnSearch = Debouncer(const Duration(milliseconds: 700));

  void _onChanged(String text) {
    _debouncedOnSearch(() => widget.onSearch(text));
  }

  @override
  build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p8),
      child: TextFormField(
        onChanged: _onChanged,
        decoration: const InputDecoration(
          hintText: "Search",
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
