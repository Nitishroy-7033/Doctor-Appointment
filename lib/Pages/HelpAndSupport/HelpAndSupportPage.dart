import 'package:flutter/material.dart';

class HelpAndSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Contact Us
            Text(
              'Contact Us',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.blue),
              title: Text('Call us at'),
              subtitle: Text('+1-234-567-890'),
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.red),
              title: Text('Email us at'),
              subtitle: Text('support@example.com'),
            ),
            SizedBox(height: 20),

            // Section: Visit Us
            Text(
              'Visit Us',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.green),
              title: Text('Our Office Address'),
              subtitle: Text(
                '123 Main Street\nCity, State, ZIP Code',
                style: TextStyle(height: 1.5),
              ),
            ),
            ListTile(
              leading: Icon(Icons.access_time, color: Colors.orange),
              title: Text('Office Hours'),
              subtitle: Text(
                'Monday to Friday: 9:00 AM – 6:00 PM\nSaturday: 10:00 AM – 4:00 PM\nClosed on Sundays and public holidays',
                style: TextStyle(height: 1.5),
              ),
            ),
            SizedBox(height: 20),

            // Section: FAQ
            Text(
              'Frequently Asked Questions',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // Navigate to FAQ Page (Implement separately)
              },
              child: Row(
                children: [
                  Icon(Icons.help_outline, color: Colors.blue),
                  SizedBox(width: 10),
                  Text(
                    'Visit our FAQ section',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Section: Live Chat
            Text(
              'Live Chat',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // Trigger Live Chat (Implement separately)
              },
              child: Row(
                children: [
                  Icon(Icons.chat_bubble_outline, color: Colors.blue),
                  SizedBox(width: 10),
                  Text(
                    'Chat with us now',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
