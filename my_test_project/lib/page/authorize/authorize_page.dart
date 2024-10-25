import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_test_project/component/email_validator.dart';
import 'package:my_test_project/component/form/text_input.dart';
import 'package:my_test_project/component/password_checker.dart';
import 'package:my_test_project/component/terms_and_conditions_text.dart';
import 'package:my_test_project/page/home/home_page.dart';

class AuthorizePage extends HookWidget {
  const AuthorizePage({super.key});

  @override
  Widget build(BuildContext context) {

    final ValueNotifier<String> firstNameState = useState('');
    final ValueNotifier<String> lastNameState = useState('');
    final ValueNotifier<String> emailState = useState('');
    final ValueNotifier<bool> isEmailValid = useState(true);
    final ValueNotifier<bool> isPasswordValid = useState(false);
    final ValueNotifier<String> passwordState = useState('');

    bool isFirstNameValid = firstNameState.value.isNotEmpty;
    bool isLastNameValid = lastNameState.value.isNotEmpty;
    bool isFormValid = isFirstNameValid && isLastNameValid && isEmailValid.value && isPasswordValid.value;

    void validateAndSetEmail(String email) {
      isEmailValid.value = EmailValidator.validate(email);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Sign Up",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    TextInput(
                      hintText: "First name",
                      onChanged: (String firstName) {
                        firstNameState.value = firstName;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextInput(
                      hintText: "Last name",
                      onChanged: (String lastName) {
                        lastNameState.value = lastName;
                      },
                    ),
                    const SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        isFirstNameValid && isLastNameValid
                            ? 'Make sure it matches the name on your government ID.'
                            : 'Make sure it matches the name on your driver license',
                        style: const TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextInput(
                      hintText: 'Email',
                      onChanged: (value) {
                        emailState.value = value;
                        validateAndSetEmail(value);
                      },
                      borderColor: emailState.value.isEmpty ? Colors.grey : (isEmailValid.value ? Colors.grey : Colors.red),
                    ),
                    const SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        isEmailValid.value
                            ? 'We will email you trip confirmations and receipts.'
                            : 'We will email you confirmations and receipts.',
                        style: const TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 20),
                    PasswordChecker(
                      onPasswordChanged: (password) {
                        passwordState.value = password;
                      },
                      onPasswordValidationChanged: (isValid) {
                        isPasswordValid.value = isValid;
                      },
                      firstName: firstNameState.value,
                      lastName: lastNameState.value,
                      email: emailState.value,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                const TermsAndConditionsText(),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                      onPressed: isFormValid ? () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );
                      } : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isFormValid ? Colors.indigoAccent : Colors.grey,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'Agree and continue',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}