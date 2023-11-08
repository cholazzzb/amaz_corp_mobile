import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';

void _defaultOnSelect(value) {}

String _defaultSelectValue(value) => "";

class SingleSelectList {
  const SingleSelectList();

  void showBottomSheet<T>(
    BuildContext context, {
    required List<T> list,
    required String title,
    void Function(T value) onSelect = _defaultOnSelect,
    String Function(T value) selectValue = _defaultSelectValue,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.2,
        maxChildSize: 0.75,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Sizes.p24),
              topRight: Radius.circular(Sizes.p24),
            ),
          ),
          child: Column(
            children: [
              Icon(Icons.remove, color: Colors.grey[600]),
              Expanded(
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (_, index) {
                    final item = list[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(Sizes.p8),
                        child: Text(selectValue(item)),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
