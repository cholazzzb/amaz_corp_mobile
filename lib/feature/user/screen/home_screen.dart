import 'package:amaz_corp_mobile/shared/layout.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Layout(
      title: 'Home',
      child: Text('Hello'),
    );
  }
}
