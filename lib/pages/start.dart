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

class _WelcomePageState extends State<WelcomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int _currentSection = 1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      )
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _nextSection() {
    setState(() {
      if (_currentSection < 4) {
        _currentSection++;
        _animationController.reset();
        _animationController.forward();
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
              Stack(
                alignment: Alignment.topLeft, // Align items at the top left corner
                children: <Widget>[
                  yellowCircle(),
                  welcomeSection1(),
                ],
              ),
            if (_currentSection == 2)
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_animation.value * MediaQuery.of(context).size.width, 0),
                    child: child,
                  );
                },
                child: welcomeSection2(),
              ),
            if (_currentSection == 3)
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_animation.value * MediaQuery.of(context).size.width, 0),
                    child: child,
                  );
                },
                child: welcomeSection3(),
              ),
            if (_currentSection == 4)
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_animation.value * MediaQuery.of(context).size.width, 0),
                    child: child,
                  );
                },
                child: welcomeSection4(),
              ),
            const SizedBox(height: 20),
            nextButton(),
          ]
        )
      )
    );
  }

  Widget yellowCircle() {
    return Container(
      width: 365,
      height: 437,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(209, 252, 208, 136),
      ),
    );
  }

  Widget welcomeSection1() {
    return const Column(
      children: <Widget>[
        Image(
          image: ResizeImage(
            AssetImage('images/welcome1.png'),
            width: 204,
            height: 279,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Welcome', textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w700,)
        ),
        Text(
          'It\'s a pleasure to meet you. We are excited that you\'re here so let\'s get started!',
          textAlign: TextAlign.center, style: TextStyle(
            fontSize: 16, fontFamily: 'Abhaya Libre', fontWeight: FontWeight.w500,
          ),
        )
      ]
    );
  }

  Widget welcomeSection2() {
    return const Column(
      children: <Widget>[
        Image(
          image: ResizeImage(
            AssetImage('images/welcome2.png'),
            width: 299,
            height: 299,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'All your favorites', textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          'Order from the canteen stalls with easy, on-demand delivery.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Abhaya Libre',
            fontWeight: FontWeight.w500,
          )
        )
      ]
    );
  }

  Widget welcomeSection3() {
    return const Column(
      children: <Widget>[
        Image(
          image: ResizeImage(
            AssetImage('images/welcome3.png'),
            width: 299,
            height: 299,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Free delivery offers', textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w700,),
        ),
        Text(
          'Free delivery for new customers and other payment methods.', textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontFamily: 'Abhaya Libre', fontWeight: FontWeight.w500,),
        ),
      ]
    );
  }

  Widget welcomeSection4() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center, // Center vertically
      crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
      children: <Widget>[
        Image(
          image: ResizeImage(
            AssetImage('images/welcome4.png'),
            width: 299,
            height: 338,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Choose your food', textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          'Easily find your type of food craving and you\'ll get delivery in a wide range.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Abhaya Libre',
            fontWeight: FontWeight.w500,
          )
        )
      ]
    );
  }

  Widget nextButton() {
    return Container(
      width: 335,
      height: 48,
      margin: const EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
        onPressed: () {
          _nextSection(); // Call the logic to move to the next section
          _animationController.forward(); // Start the animation
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          _currentSection < 4 ? 'Next' : 'Get Started',
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'Abhaya Libre',
            fontWeight: FontWeight.w500,
          )
        )
      )
    );
  }
}