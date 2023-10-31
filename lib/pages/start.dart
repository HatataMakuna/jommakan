import 'package:flutter/material.dart';

// external pages
import 'user/LoginPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _currentSection = 1;

  void _nextSection() {
    setState(() {
      if (_currentSection < 4) {
        _currentSection++;
      } else {
        // Navigate to login page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          children: <Widget>[
            if (_currentSection == 1)
              const Column(
                children: <Widget>[
                  // image
                  Image(
                    image: ResizeImage(
                      AssetImage('images/welcome1.png'),
                      width: 204,
                      height: 279,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Welcome', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),),
                  Text(
                    'It\'s a pleasure to meet you. We are excited that you\'re here so let\'s get started!',
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 20,),
                  ),
                ]
              ),
            if (_currentSection == 2)
              const Column(
                children: <Widget>[
                  // image
                  Image(
                    image: ResizeImage(
                      AssetImage('images/welcome2.png'),
                      width: 299,
                      height: 299,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('All your favorites', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),),
                  Text(
                    'Order from the best local restaurants with easy, on-demand delivery.',
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 20,),
                  ),
                ]
              ),
            if (_currentSection == 3)
              const Column(
                children: <Widget>[
                  // image
                  Image(
                    image: ResizeImage(
                      AssetImage('images/welcome3.png'),
                      width: 299,
                      height: 299,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Free delivery offers', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),),
                  Text(
                    'Free delivery for new customers and other payment methods.',
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 20,),
                  ),
                ]
              ),
            if (_currentSection == 4)
              const Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
                children: <Widget>[
                  // image
                  Image(
                    image: ResizeImage(
                      AssetImage('images/welcome4.png'),
                      width: 299,
                      height: 338,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Choose your food', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),),
                  Text(
                    'Easily find your type of food craving and you\'ll get delivery in a wide range.',
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 20,),
                  ),
                ]
              ),
            
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _nextSection,
              child: Text(_currentSection < 4 ? 'Next' : 'Get Started'),
            ),
          ]
        )
      )
    );
  }
}