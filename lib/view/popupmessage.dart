import 'package:flutter/material.dart';
import 'package:antiquewebemquiry/view/message.dart';

class WelcomeNotification extends StatelessWidget {
  final String message;
  final VoidCallback onClose;
  final VoidCallback onOpen;

  const WelcomeNotification({
    Key? key,
    required this.message,
    required this.onClose,
    required this.onOpen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFF6B00),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 24.0,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome Note!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  GestureDetector(
                    onTap: () {
                      // Navigate to MessagePage and go to the General Message tab
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MessagePage(initialTabIndex: 0), // Assuming 0 is the index for General Message tab
                        ),
                      );
                      // Call the original onOpen callback
                      onOpen();
                    },
                    child: const Text(
                      'Open',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
                size: 24.0,
              ),
              onPressed: onClose,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}