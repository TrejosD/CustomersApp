import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pushReplacement('/'),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Privacy Policy'),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 14),
        child: ListView(
          children: [
            Text('Last updated: 10/12/2026'),
            Text(
              '[Nombre de tu App o Empresa] ("we," "us," or "our") operates the [Nombre de la App] mobile application (hereinafter referred to as the "Application"). This page informs you of our policies regarding the collection, use, and disclosure of personal data when you use our Application.',
            ),
            // titulo
            Divider(),
            Text('1. Information We Collect and Use'),
            Text(
              'To provide and improve our appointment management service, we collect the following data directly from you:',
            ),
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.circle, size: 10),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Account and Registration Information: We collect your name, email address, and password to manage your account creation, enable secure login, and authenticate your identity within our cloud services.',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.circle, size: 10),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Usage and Connectivity Information: The Application strictly requires Internet access to synchronize real-time business information, including addresses, services offered, and to manage appointment requests.',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // subtitulo
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.circle, size: 10),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Geographic Location Data: The Application includes features to interact with location-based services, such as searching and filtering businesses near you. If you grant the corresponding permissions on your device, we will collect information about your precise (GPS) or approximate location. Currently, this feature may be utilized by our quality assurance team (testers) across different geographic regions to verify the platform`s filtering capabilities. You can enable or disable location access at any time through your operating system settings.',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.circle, size: 10),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Push Notifications: With your prior consent, we use push notifications to send you appointment confirmations, booking reminders, updates on requested services, and important account alerts. You can opt out of receiving these communications by modifying the Application`s permissions in your device settings.',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // titulo
            Divider(),
            Text('2. How Your Data Is Shared'),
            // subtitulos
            Text(
              'We do not sell your personal data to third parties. However, to fulfill the primary core function of the Application, your data is shared as follows:',
            ),
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.circle, size: 10),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'With Business Owners: When you request an appointment with a specific business, your name is shared directly with the owner or administrator of that business so they can identify you, process your reservation, and schedule the service.',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.circle, size: 10),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Cloud Service Providers: Your authentication data (name, email, and encrypted password) is securely stored on third-party cloud database servers that comply with the highest industry security standards.',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.circle, size: 10),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Notification and Testing Infrastructure Providers: For the efficient delivery of push notifications and the secure distribution of beta versions to our testers (using authorized tools such as Firebase App Distribution, Google Play Console, or Apple TestFlight), certain anonymous device identifiers may be temporarily processed by these services to ensure the Application reaches the correct recipient.',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // titulo
            Divider(),
            Text('3. Data Security'),
            Text(
              'The security of your data is our priority. Passwords are stored in an encrypted format within our database. We implement commercially viable technical and organizational measures to protect your personal information; however, please remember that no method of transmission over the Internet or electronic storage is 100% secure.',
            ),
            Divider(),
            Text(
              '4. Data Retention and Deletion (Mandatory Google & Apple Requirement)',
            ),
            Text(
              'We will retain your personal data only for as long as necessary for the purposes set forth in this Privacy Policy.',
            ),
            Row(
              children: [
                Icon(Icons.circle, size: 10),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Right to Deletion: You have the right to request the deletion of your account and all associated data at any time. You can do this directly from the Application`s settings menu or by sending an email to [Tu Correo de Soporte]. Once requested, your information will be permanently erased from our cloud databases.',
                  ),
                ),
              ],
            ),
            // titutlo
            Divider(),
            Text('5. Children`s Privacy'),
            Text(
              'Our service is not directed to individuals under the age of 13 (or the minimum legal age in your country). We do not knowingly collect personally identifiable information from minors. If we discover that a minor has provided us with data, we will delete it from our servers immediately.',
            ),
            Divider(),
            Text('6. Changes to This Privacy Policy'),
            Text(
              'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last Updated" date.',
            ),
            Divider(),
            Text('7. Contact Us'),
            Text(
              'If you have any questions about this Privacy Policy, you can contact us at:',
            ),
            Row(
              children: [
                Icon(Icons.circle, size: 10),
                SizedBox(width: 6),
                Expanded(child: Text('Email: [Tu Correo de Soporte]')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
