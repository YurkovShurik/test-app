import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_test_project/enum/password_strength.dart';

class PasswordChecker extends HookWidget {

  final ValueChanged<String> onPasswordChanged;
  final ValueChanged<bool> onPasswordValidationChanged;
  final String firstName;
  final String lastName;
  final String email;

  const PasswordChecker({
    Key? key,
    required this.onPasswordChanged,
    required this.onPasswordValidationChanged,
    required this.firstName,
    required this.lastName,
    required this.email,
  }) : super(key: key);

  PasswordStrength _calculatePasswordStrength(String password) {
    if (_containsExactNameOrEmail(password)) {
      return PasswordStrength.weak;
    }
    if (password.length >= 8 && _hasSymbolOrNumber(password)) {
      return password.length > 12 ? PasswordStrength.strong : PasswordStrength.medium;
    }

    return PasswordStrength.weak;
  }

  bool _hasSymbolOrNumber(String password) {
    return RegExp(r'[0-9!@#$%^&*(),.?":{}|<>]').hasMatch(password);
  }

  bool _containsExactNameOrEmail(String password) {
    final lowerPassword = password.toLowerCase();
    return lowerPassword == email.toLowerCase() ||
        (firstName.length > 3 && lowerPassword == firstName.toLowerCase()) ||
        (lastName.length > 3 && lowerPassword == lastName.toLowerCase());
  }

  bool _validatePassword(String password) {
    return password.length >= 8 &&
        !_containsExactNameOrEmail(password) &&
        _hasSymbolOrNumber(password) &&
        !password.contains(' ');
  }

  @override
  Widget build(BuildContext context) {
    final password = useState('');
    final obscureText = useState(true);
    final strength = useState(PasswordStrength.weak);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: password.value.isEmpty ? Colors.grey : (strength.value == PasswordStrength.weak ? Colors.red : Colors.grey),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            key: key,
            style: const TextStyle(fontSize: 17),
            textAlign: TextAlign.start,
            onChanged: (value) {
              password.value = value;
              strength.value = _calculatePasswordStrength(value);
              onPasswordChanged(value);
              onPasswordValidationChanged(_validatePassword(value));
            },
            obscureText: obscureText.value,
            decoration: InputDecoration(
              hintText: "Password",
              labelText: "Password",
              labelStyle: const TextStyle(
                color: Colors.grey,
              ),
              contentPadding: const EdgeInsets.all(10),
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(
                  obscureText.value ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  obscureText.value = !obscureText.value;
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        if (password.value.isNotEmpty) _buildPasswordStrengthMessage(strength.value),
        if (password.value.isNotEmpty && strength.value == PasswordStrength.weak) ...[
          _buildPasswordCriteria('Must be at least 8 characters', password.value.length >= 8),
          _buildPasswordCriteria('Can not be identical to your name or email', !_containsExactNameOrEmail(password.value)),
          _buildPasswordCriteria('Must have at least one symbol or number', _hasSymbolOrNumber(password.value)),
          _buildPasswordCriteria('Can not contain spaces', !password.value.contains(' ')),
        ],
      ],
    );
  }

  Widget _buildPasswordStrengthMessage(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.weak:
        return const Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red),
            SizedBox(width: 8),
            Text('Password strength: weak', style: TextStyle(color: Colors.red)),
          ],
        );
      case PasswordStrength.medium:
        return const Row(
          children: [
            Icon(Icons.warning_amber_outlined, color: Colors.orange),
            SizedBox(width: 8),
            Text('Password strength: medium', style: TextStyle(color: Colors.orange)),
          ],
        );
      case PasswordStrength.strong:
        return const Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.green),
            SizedBox(width: 8),
            Text('Password strength: excellent', style: TextStyle(color: Colors.green)),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildPasswordCriteria(String text, bool isMet) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check : Icons.clear,
          color: isMet ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(color: isMet ? Colors.green : Colors.red),
        ),
      ],
    );
  }
}