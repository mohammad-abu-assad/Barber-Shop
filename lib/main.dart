import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:myfirstapp/pages/home_page.dart';
import 'package:myfirstapp/pages/booking_page.dart';
import 'package:myfirstapp/classes/language.dart';
import 'package:myfirstapp/classes/language_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    final state = context.findAncestorStateOfType<_MyAppState>();
    if (state != null) {
      state.setLocale(newLocale);
    }
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) async {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((value) => setLocale(value));
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    getLocale().then((locale) => setLocale(locale));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "barber shop",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      home: const MyBottomNavPage(),
    );
  }
}

class MyBottomNavPage extends StatefulWidget {
  const MyBottomNavPage({super.key});

  @override
  _MyBottomNavPageState createState() => _MyBottomNavPageState();
}

class _MyBottomNavPageState extends State<MyBottomNavPage> {
  int _selectedIndex = 0;

  Future<void> _changeLanguage(String languageCode) async {
    Locale newLocale = await setLocale(languageCode);
    MyApp.setLocale(context, newLocale);
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        translation(context).appTitle,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      actions: <Widget>[
        _buildLanguageDropdown(),
      ],
    );
  }

  Widget _buildLanguageDropdown() {
    return PopupMenuButton<Language>(
      onSelected: (Language selectedLanguage) {
        _changeLanguage(selectedLanguage.lanCode);
      },
      itemBuilder: (BuildContext context) {
        return Language.languageList().map((Language language) {
          return PopupMenuItem<Language>(
            value: language,
            child: Text(language.name),
          );
        }).toList();
      },
      icon: const Icon(Icons.language),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: AppLocalizations.of(context)!.homePage,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.schedule),
          label: AppLocalizations.of(context)!.booking,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.shop),
          label: AppLocalizations.of(context)!.products,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.black,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _pageOptions[_selectedIndex],
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  final List<Widget> _pageOptions = [
    const HomePage(),
    const BookingPage(),
    const PlaceholderWidget(color: Colors.blue),
  ];
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  const PlaceholderWidget({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
