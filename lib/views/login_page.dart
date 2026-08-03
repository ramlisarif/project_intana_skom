import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import 'main_navigation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _nikController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final guru = await ApiService.login(_nikController.text, _passController.text);
      setState(() => _isLoading = false);

      if (guru != null && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => MainNavigation(guru: guru)),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('NIK / Password Salah! Password harus 6 karakter.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.school, size: 80, color: Colors.indigo),
                const SizedBox(height: 16),
                const Text('Portal KBM Guru', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _nikController,
                  decoration: const InputDecoration(labelText: 'NIK Guru', border: OutlineInputBorder()),
                  validator: (v) => (v == null || v.isEmpty) ? 'NIK tidak boleh kosong' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passController,
                  obscureText: true,
                  maxLength: 6,
                  decoration: const InputDecoration(labelText: 'Password (6 Karakter)', border: OutlineInputBorder()),
                  validator: (v) => (v == null || v.length != 6) ? 'Password harus 6 karakter' : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                  child: _isLoading ? const CircularProgressIndicator(
                    
                  ) : const Text('MASUK'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}