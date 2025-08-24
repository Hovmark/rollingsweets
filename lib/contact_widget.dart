import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  bool _submitting = false;
  String? _responseMessage;

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _submitting = true;
      _responseMessage = null;
    });

    final uri = Uri.parse('https://formspree.io/f/xpwrnkyj');
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'name': _nameController.text,
        'email': _emailController.text,
        'subject': _subjectController.text,
        'message': _messageController.text,
      },
    );

    setState(() {
      _submitting = false;
      _responseMessage = response.statusCode == 200
          ? 'Message sent!'
          : 'Failed to send. Please try again.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 200,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Namn'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email*'),
              validator: (value) => value!.isEmpty ? 'Ange epostaddress' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _subjectController,
              decoration: const InputDecoration(labelText: 'Ämne'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _messageController,
              decoration: const InputDecoration(labelText: 'Meddelande*'),
              maxLines: 4,
              validator: (value) =>
                  value!.isEmpty ? 'Skriv ditt meddelande' : null,
            ),
            const SizedBox(height: 24),
            if (_submitting) const CircularProgressIndicator(),
            if (_responseMessage != null) Text(_responseMessage!),
            if (!_submitting)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  onPressed: _submitForm,
                  child: const Text('Skicka'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
