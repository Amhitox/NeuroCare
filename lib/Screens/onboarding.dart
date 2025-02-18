import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neurocare/utils/constants/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<OnBoarding> {
  int indexPage = 0;
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/images/logo.png',
                height: 200,
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: controller,
              onPageChanged: (value) => setState(() {
                indexPage = value;
              }),
              scrollDirection: Axis.horizontal,
              children: [
                _customOnBoard(
                    'assets/images/onboard1.png',
                    'Welcome to Neurocare!',
                    'Manage your epilepsy with ease\nTrack meds, seizures,and stay informed.'),
                _customOnBoard(
                    'assets/images/onboard2.png',
                    'Track Your Medications',
                    'Set reminders and log your doses\nNever miss a dose again.'),
                _customOnBoard(
                    'assets/images/onboard3.png',
                    'Log Your Seizures',
                    'Track frequency, duration, and triggers\nShare reports with your doctor.'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedSmoothIndicator(
              activeIndex: indexPage,
              count: 3,
              effect: WormEffect(dotWidth: 10, dotHeight: 10),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 50, top: 30),
              child: ElevatedButton(
                style: ButtonStyle(
                  fixedSize: WidgetStatePropertyAll(
                    Size(300, 50),
                  ),
                  backgroundColor:
                      WidgetStatePropertyAll(DarkAppColors.primary),
                ),
                onPressed: () {
                  controller.nextPage(
                      duration: Duration(milliseconds: 600),
                      curve: Curves.linear);
                },
                child: (indexPage != 2)
                    ? Text(
                        'Next',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )
                    : Text(
                        'Finish',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ))
        ],
      ),
    );
  }
}

Widget _customOnBoard(String image, String title, String description) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Image.asset(
          image,
          width: 300,
          height: 250,
        ),
      ),
      Text(
        title,
        style: GoogleFonts.poppins(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 26),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        description,
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}
