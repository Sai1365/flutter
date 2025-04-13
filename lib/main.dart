import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'common_utils.dart';
import 'home.dart';

void main() {
  // Enforce portrait orientation at app startup
  CommonUtils.enforcePortraitOrientation();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/', // Start from LoginScreen
    routes: {
      '/': (context) => const LoginScreen(),
      '/home': (context) =>  HomeScreen(),
    },
  ));
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            bool isPortrait = orientation == Orientation.portrait;
            double responsiveSize = CommonUtils.getResponsiveSize(context); // Use shared method
            bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

            return Stack(
              children: [
                // Q Logo at the top-left using shared widget
                // Positioned(
                //   top: responsiveSize * 0.05,
                //   left: responsiveSize * 0.05,
                //   child: const QLogoWidget(),
                // ),

                // White Login Box (Right Side)
                Align(
                  alignment: Alignment.centerRight,
                  child: FractionallySizedBox(
                    widthFactor: isPortrait ? 0.7 : 0.6,
                    heightFactor: 1.0,
                    child: Container(
                      padding: EdgeInsets.all(responsiveSize * 0.04),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Settings & Language Buttons using shared methods
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CommonUtils.buildCustomButton(
                                icon: Icons.settings,
                                label: "Settings",
                                onPressed: () {},
                                responsiveSize: responsiveSize,
                              ),
                              SizedBox(width: responsiveSize * 0.02),
                              CommonUtils.buildCustomDropdownButton(
                                label: "Arabic",
                                responsiveSize: responsiveSize,
                                onChanged: (String? newValue) {},
                              ),
                            ],
                          ),
                          // Login Icons and Button using shared methods
                          Expanded(
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Wrap(
                                    spacing: responsiveSize * 0.03,
                                    children: [
                                      CommonUtils.buildLoginIcon(Icons.face),
                                      CommonUtils.buildLoginIcon(Icons.remove_red_eye),
                                      CommonUtils.buildLoginIcon(Icons.fingerprint),
                                      CommonUtils.buildLoginIcon(Icons.description),
                                    ],
                                  ),
                                  SizedBox(height: responsiveSize * 0.08),
                                  CommonUtils.buildLoginButton(
                                    responsiveSize: responsiveSize,
                                    context: context,
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(context, '/home');
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Version Label
                          Padding(
                            padding: EdgeInsets.only(top: responsiveSize * 0.02),
                            child: const Text(
                              "Version 1.0.1",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Mobile with Credit Card Image (Dynamic Positioning)
                if (isLandscape)
                  Positioned(
                    top: isPortrait ? MediaQuery.of(context).size.height * 0.25 : MediaQuery.of(context).size.height * 0.2,
                    left: isPortrait ? MediaQuery.of(context).size.width * 0.15 : MediaQuery.of(context).size.width * 0.2,
                    child: Transform.rotate(
                      angle: -0.2,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: responsiveSize * 1.1,
                          maxHeight: responsiveSize * 1,
                        ),
                        child: Image.asset(
                          'assets/mobile.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}