import 'package:flutter/material.dart';
import 'common_utils.dart';
import 'update_screen.dart';
import 'ReplaceScreen.dart';
import 'card_operation_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isEnrollmentActive = false;

  Widget _buildOperationButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: CommonUtils.getResponsiveSize(context) * 2),
          decoration: BoxDecoration(
            color: isActive && text == 'Enrollment'
                ? const Color(0xFFFFC107)
                : Colors.white,
            borderRadius: BorderRadius.circular(CommonUtils.getResponsiveSize(context) * 0.8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: const Color(0xFF4A90E2),
                size: CommonUtils.getResponsiveSize(context) * 2.4,
              ),
              const SizedBox(width: 8.0),
              Text(
                text,
                style: TextStyle(
                  fontSize: CommonUtils.getResponsiveSize(context) * 1.6,
                  color: const Color(0xFF4A90E2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 2.0,
      height: 40.0,
      color: const Color(0xFFFFC107),
    );
  }

  void _showEnrollmentPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enrollment Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPopupOption('New Enrollment', () {
                Navigator.pop(context);
                print('New Enrollment tapped');
                // Handle New Enrollment logic
              }),
              _buildPopupOption('Pending Enrollment', () {
                Navigator.pop(context);
                print('Pending Enrollment tapped');
                // Handle Pending Enrollment logic
              }),
              _buildPopupOption('HBank New Enrollment', () {
                Navigator.pop(context);
                print('HBank New Enrollment tapped');
                // Handle HBank New Enrollment logic
              }),
              _buildPopupOption('Name Printing on Master card', () {
                Navigator.pop(context);
                print('Name Printing on Master card tapped');
                // Handle Name Printing logic
              }),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _isEnrollmentActive = false;
                });
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPopupOption(String text, VoidCallback onTap) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(fontSize: CommonUtils.getResponsiveSize(context) * 1.6),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    double responsiveSize = CommonUtils.getResponsiveSize(context);
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Stack(
            children: [
              // Background color
              Container(
                color: const Color(0xFF4A90E2),
              ),

              // Top Navigation Bar (using the reusable widget)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: CommonUtils.buildTopNavigationBar(
                  context: context,
                  onHomeTap: () {
                    print('Home Tapped in HomeScreen');
                    // Navigate to Home screen
                  },
                  onSettingsTap: () {
                    print('Settings Tapped in HomeScreen');
                    // Navigate to Settings screen
                  },
                  onHelpTap: () {
                    print('Help Tapped in HomeScreen');
                    // Show Help dialog
                  },
                  onDefaultUserTap: () {
                    print('Default User Tapped in HomeScreen');
                    // Handle Default User action
                  },
                ),
              ),

              // Operations Section
              Positioned(
                top: responsiveSize * 18, // Adjust as needed
                left: 0,
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsiveSize * 3,
                    vertical: responsiveSize * 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: responsiveSize * 4),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                          vertical: responsiveSize * 2,
                          horizontal: responsiveSize * 3,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildOperationButton(
                              icon: Icons.person_add,
                              text: 'Enrollment',
                              onTap: () {
                                setState(() {
                                  _isEnrollmentActive = true;
                                });
                                _showEnrollmentPopup();
                              },
                              isActive: _isEnrollmentActive,
                            ),
                            _buildVerticalDivider(),
                            _buildOperationButton(
                              icon: Icons.update,
                              text: 'Update',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateScreen()),
                                );
                              },
                            ),
                            _buildVerticalDivider(),
                            _buildOperationButton(
                              icon: Icons.refresh,
                              text: 'Replace',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReplaceScreen()),
                                );
                              },
                            ),
                            _buildVerticalDivider(),
                            _buildOperationButton(
                              icon: Icons.credit_card,
                              text: 'Card Operations',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CardOperationsScreen()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}