import 'package:flutter/material.dart';

class NotificationPopupScreen extends StatefulWidget {
  const NotificationPopupScreen({Key? key}) : super(key: key);

  @override
  State<NotificationPopupScreen> createState() => _NotificationPopupScreenState();
}

class _NotificationPopupScreenState extends State<NotificationPopupScreen> {
  bool _showNotification = true;

  void _dismissNotification() {
    setState(() {
      _showNotification = false;
    });
  }

  void _showNotificationAgain() {
    setState(() {
      _showNotification = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2F3), // Changed background color to grey
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Notifications', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                if (!_showNotification)
                  ElevatedButton(
                    onPressed: _showNotificationAgain,
                    child: const Text('Show Notification Again'),
                  ),
              ],
            ),
          ),
          if (_showNotification)
            NotificationPopup(
              title: 'Welcome Note!',
              content: 'Based on your past information, it would look better to have more of text.',
              onDismiss: _dismissNotification,
            ),
        ],
      ),
    );
  }
}

class NotificationPopup extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onDismiss;
  final String buttonText;

  const NotificationPopup({
    Key? key,
    required this.title,
    required this.content,
    required this.onDismiss,
    this.buttonText = 'Open',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFF8500),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Orange dot/circle icon
                      Container(
                        margin: const EdgeInsets.only(top: 2.0, right: 6.0),
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      // Title
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      // Close button
                      GestureDetector(
                        onTap: onDismiss,
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Notification content
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(
                      content,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Open button
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: TextButton(
                      onPressed: onDismiss,
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        minimumSize: const Size(10, 10),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        buttonText,
                        style: const TextStyle(
                          color: const Color(0xFFFF8500),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}