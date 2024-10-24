import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsText extends StatelessWidget {
  const TermsAndConditionsText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black, fontSize: 16),
        children: [
          const TextSpan(
              text: 'By selecting Agree and continue, I agree to Security Rent ',
          ),
          TextSpan(
            text: 'Terms of Service',
            style: const TextStyle(
              color: Colors.indigoAccent,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Open Terms of Service
              },
          ),
          const TextSpan(text: ', '),
          TextSpan(
            text: 'Payments Terms of Service',
            style: const TextStyle(
              color: Colors.indigoAccent,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Open Payments Terms of Service
              },
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Notification Policy',
            style: const TextStyle(
              color: Colors.indigoAccent,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Open Notification Policy
              },
          ),
          const TextSpan(text: ' and acknowledge the '),
          TextSpan(
            text: 'Privacy Policy',
            style: const TextStyle(
              color: Colors.indigoAccent,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Open Privacy Policy
              },
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}