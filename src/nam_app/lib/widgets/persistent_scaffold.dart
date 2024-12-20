import 'package:flutter/material.dart';
import 'package:nam_app/services/context_service_impl.dart';
import 'package:nam_app/widgets/main_menu.dart';

class PersistentScaffold extends StatefulWidget {
  final Widget initialScreen;

  const PersistentScaffold({
    required this.initialScreen,
    super.key,
  });

  @override
  PersistentScaffoldState createState() => PersistentScaffoldState();
}

class PersistentScaffoldState extends State<PersistentScaffold> {
  late Widget _currentScreen;

  @override
  void initState() {
    super.initState();
    _currentScreen = widget.initialScreen;
  }

  void _navigateTo(Widget screen) {
    setState(() {
      _currentScreen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nam App'),
      ),
      drawer: MainMenu(
        contextService: InMemoryContextService(),
        onNavigate: _navigateTo, // Pass the navigation function to MainMenu
      ),
      body: _currentScreen,
    );
  }
}
