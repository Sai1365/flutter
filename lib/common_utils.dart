import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonUtils {
  /// Enforces the app to run in portrait orientation only.
  static void enforcePortraitOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// Hides the status bar (optional, currently commented out in main.dart).
  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  /// Resets the status bar to its default visibility (optional, for cleanup).
  static void resetStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  /// Calculates a responsive size based on the screen's shorter dimension.
  /// Returns a value that can be used for padding, margins, or font sizes.
  static double getResponsiveSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double baseSize = screenWidth < screenHeight ? screenWidth : screenHeight;
    return baseSize * 0.01; // Returns 1% of the shorter dimension as a base unit
  }

  /// Builds a custom button with an icon and label.
  static Widget buildCustomButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required double responsiveSize,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: responsiveSize * 0.6),
      label: Text(
        label,
        style: TextStyle(fontSize: responsiveSize * 0.4),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(responsiveSize * 0.3),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: responsiveSize * 0.3,
          vertical: responsiveSize * 0.15,
        ),
      ),
    );
  }

  /// Builds a custom dropdown button with a label.
  static Widget buildCustomDropdownButton({
    required String label,
    required double responsiveSize,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButton<String>(
      value: label,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: responsiveSize * 0.6,
      style: TextStyle(
        color: Colors.black,
        fontSize: responsiveSize * 0.4,
      ),
      underline: Container(
        height: 2,
        color: Colors.black,
      ),
      onChanged: onChanged,
      items: <String>['Arabic', 'English'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  /// Builds a login icon button.
  static Widget buildLoginIcon(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, size: 30.0),
        color: Colors.teal,
        onPressed: () {},
      ),
    );
  }

  /// Builds the login button.
  static Widget buildLoginButton({
    required double responsiveSize,
    required BuildContext context,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(responsiveSize * 0.4),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: responsiveSize * 0.6,
          vertical: responsiveSize * 0.3,
        ),
      ),
      child: Text(
        'Login',
        style: TextStyle(fontSize: responsiveSize * 0.5),
      ),
    );
  }

  /// Builds a reusable top navigation bar widget.
  static Widget buildTopNavigationBar({
    required BuildContext context,
    required VoidCallback onHomeTap,
    required VoidCallback onSettingsTap,
    required VoidCallback onHelpTap,
    required VoidCallback onDefaultUserTap,
  }) {
    double responsiveSize = CommonUtils.getResponsiveSize(context);

    Widget _buildNavTextButton(String text, VoidCallback onTap) {
      return TextButton(
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            color: const Color(0xFF4A90E2),
            fontSize: responsiveSize * 1.6, // Adjusted font size
          ),
        ),
      );
    }

    Widget _buildDefaultUserButton(BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 212, 170, 44)),
          borderRadius: BorderRadius.circular(responsiveSize * 2), // Adjusted border radius
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(responsiveSize * 2), // Adjusted border radius
            onTap: onDefaultUserTap,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: responsiveSize * 1.2, // Adjusted horizontal padding
                  vertical: responsiveSize * 0.8), // Adjusted vertical padding
              child: Row(
                children: [
                  Text(
                    'Default user',
                    style: TextStyle(
                      color: const Color(0xFF4A90E2),
                      fontSize: responsiveSize * 1.4, // Adjusted font size
                    ),
                  ),
                  SizedBox(width: responsiveSize * 0.4), // Adjusted SizedBox width
                  Icon(
                    Icons.arrow_forward,
                    color: const Color(0xFFFFC107),
                    size: responsiveSize * 1.6, // Adjusted icon size
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      color: const Color(0xFFE8ECEF),
      padding: EdgeInsets.symmetric(
        horizontal: responsiveSize * 1.5, // Adjusted horizontal padding
        vertical: responsiveSize * 1.0, // Adjusted vertical padding
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.qr_code,
              color: const Color(0xFFFFC107),
              size: responsiveSize * 4.0, // Adjusted logo size
            ),
          ),
          Row(
            children: [
              _buildNavTextButton('Home', onHomeTap),
              SizedBox(width: responsiveSize * 1.5), // Adjusted SizedBox width
              _buildNavTextButton('Settings', onSettingsTap),
              SizedBox(width: responsiveSize * 1.5), // Adjusted SizedBox width
              _buildNavTextButton('Help?', onHelpTap),
            ],
          ),
          _buildDefaultUserButton(context),
        ],
      ),
    );
  }
}