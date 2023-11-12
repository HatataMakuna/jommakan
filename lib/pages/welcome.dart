import 'package:flutter/material.dart';
import 'package:jom_makan/components/indicator.dart';
import 'package:jom_makan/components/logo.dart';

//void main() => runApp(const MaterialApp(home: Welcome(),));

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const WelcomePage();
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late PageController _pageController;
  int _currentSection = 1;
  final Logo _logo = Logo();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  void _nextSection() {
    setState(() {
      if (_currentSection < 4) {
        _currentSection++;
        _pageController.nextPage(duration: const Duration(milliseconds: 600), curve: Curves.easeOutCubic);
      } else {
        // Navigate to the login page
        Navigator.pushNamed(context, '/user/login');
      }
    });
  }

  void _previousSection() {
    setState(() {
      if (_currentSection > 1) {
        _currentSection--;
        _pageController.previousPage(duration: const Duration(milliseconds: 600), curve: Curves.easeOutCubic);
      } else {
        // Navigate back to the previous page
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentSection > 1 ? AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          onPressed: () {
            _previousSection();
          },
        ),
      ) : AppBar(
        backgroundColor: Colors.white,
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Disable swipe
        children: [
          // Section 1
          Column(
            children: [
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.topLeft,
                children: <Widget>[
                  yellowCircle(),
                  welcomeSection1(),
                ],
              ),
              const SizedBox(height: 20),
              const Indicator(totalIndicators: 4, activeIndex: 0),
              const SizedBox(height: 20),
              nextButton(),
            ],
          ),
          // Section 2
          Column(
            children: [
              const SizedBox(height: 20),
              welcomeSection2(),
              const SizedBox(height: 20),
              const Indicator(totalIndicators: 4, activeIndex: 1),
              const SizedBox(height: 20),
              nextButton(),
            ],
          ),
          // Section 3
          Column(
            children: [
              const SizedBox(height: 20),
              welcomeSection3(),
              const SizedBox(height: 20),
              const Indicator(totalIndicators: 4, activeIndex: 2),
              const SizedBox(height: 20),
              nextButton(),
            ],
          ),
          // Section 4
          Column(
            children: [
              const SizedBox(height: 20),
              welcomeSection4(),
              const SizedBox(height: 20),
              const Indicator(totalIndicators: 4, activeIndex: 3),
              const SizedBox(height: 20),
              nextButton(),
            ],
          ),
        ],
      ),
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
    return Column(
      children: <Widget>[
        _logo.getLogoImage(),
        const SizedBox(height: 20),
        const Image(
          image: ResizeImage(
            AssetImage('images/welcome1.png'),
            width: 204,
            height: 279,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Welcome', textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w700,)
        ),
        const Text(
          'It\'s a pleasure to meet you. We are excited that you\'re here so let\'s get started!',
          textAlign: TextAlign.center, style: TextStyle(
            fontSize: 16, fontFamily: 'Abhaya Libre', fontWeight: FontWeight.w500,
          ),
        )
      ]
    );
  }

  Widget welcomeSection2() {
    return Column(
      children: <Widget>[
        _logo.getLogoImage(),
        const SizedBox(height: 20),
        const Image(
          image: ResizeImage(
            AssetImage('images/welcome2.png'),
            width: 299,
            height: 299,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'All your favorites', textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        const Text(
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
    return Column(
      children: <Widget>[
        _logo.getLogoImage(),
        const SizedBox(height: 20),
        const Image(
          image: ResizeImage(
            AssetImage('images/welcome3.png'),
            width: 299,
            height: 299,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Free delivery offers', textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w700,),
        ),
        const Text(
          'Free delivery for new customers and other payment methods.', textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontFamily: 'Abhaya Libre', fontWeight: FontWeight.w500,),
        ),
      ]
    );
  }

  Widget welcomeSection4() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Center vertically
      crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
      children: <Widget>[
        _logo.getLogoImage(),
        const SizedBox(height: 20),
        const Image(
          image: ResizeImage(
            AssetImage('images/welcome4.png'),
            width: 299,
            height: 299,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Choose your food', textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        const Text(
          'Easily find your type of food craving and you\'ll get delivery in a wide range.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Abhaya Libre',
            fontWeight: FontWeight.w500,
          ),
        ),
      ]
    );
  }

  Widget nextButton() {
    return Container(
      width: 335,
      height: 48,
      margin: const EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
        onPressed: _nextSection,
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
          ),
        ),
      ),
    );
  }
}