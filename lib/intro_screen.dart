import 'package:flutter/material.dart';
import 'timer_screen.dart'; // Импортируйте новую страницу
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IntroScreen extends StatefulWidget {
  final IO.Socket socket; // Добавьте это поле

  IntroScreen(this.socket);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Map<String, String>> _introData = [
    {
      'image': 'assets/image1.png',
      'text': 'Привет! Добро пожаловать в наше приложение.',
    },
    {
      'image': 'assets/image2.png',
      'text': 'Здесь вы найдете множество полезных функций.',
    },
    {
      'image': 'assets/image3.png',
      'text': 'Давайте начнем путешествие в мир наших возможностей.',
    },
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _startApp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => TimerScreen(socket: widget.socket)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _introData.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_introData[index]['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(
                    _introData[index]['text']!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 40.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
          ),
        ],
      ),
      floatingActionButton: _currentPage == _introData.length - 1
          ? FloatingActionButton(
              onPressed: _startApp,
              child: Icon(Icons.arrow_forward),
            )
          : null,
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < _introData.length; i++) {
      indicators.add(
        i == _currentPage ? _indicator(true) : _indicator(false),
      );
    }
    return indicators;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white54,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
