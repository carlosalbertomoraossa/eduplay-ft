// Login del padre/tutor
// Spec: /specs/domains/auth/spec.md

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../shared/widgets/ep_button.dart';
import '../bloc/auth_cubit.dart';

class ParentLoginScreen extends StatefulWidget {
  const ParentLoginScreen({super.key});

  @override
  State<ParentLoginScreen> createState() => _ParentLoginScreenState();
}

class _ParentLoginScreenState extends State<ParentLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthParentLoggedIn) {
          context.go('/auth/select-child');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: EduPlayColors.softRed,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: EduPlayColors.backgroundLight,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Center(
                    child: Column(
                      children: [
                        const Text('🌟', style: TextStyle(fontSize: 56))
                            .animate()
                            .scale(duration: 400.ms, curve: Curves.elasticOut),
                        const SizedBox(height: 12),
                        const Text(
                          'EduPlay',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: EduPlayColors.primaryBlue,
                            fontFamily: 'Nunito',
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Ingresa con tu cuenta',
                          style: TextStyle(
                            fontSize: 16,
                            color: EduPlayColors.textMedium,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Email
                  const Text(
                    'Correo electrónico',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: EduPlayColors.textDark,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _inputDecoration('tu@correo.com'),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Ingresa tu correo';
                      if (!v.contains('@')) return 'Correo no válido';
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Contraseña
                  const Text(
                    'Contraseña',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: EduPlayColors.textDark,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordCtrl,
                    obscureText: _obscurePassword,
                    decoration: _inputDecoration('••••••••').copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: EduPlayColors.textMedium,
                        ),
                        onPressed: () =>
                            setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Ingresa tu contraseña';
                      if (v.length < 6) return 'Mínimo 6 caracteres';
                      return null;
                    },
                  ),

                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {}, // TODO: forgot password
                      child: const Text(
                        '¿Olvidaste tu contraseña?',
                        style: TextStyle(
                          color: EduPlayColors.primaryBlue,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Botón login
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return EpButton(
                        label: 'Ingresar',
                        isLoading: state is AuthLoading,
                        onPressed: state is AuthLoading ? null : _submit,
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // Crear cuenta
                  Center(
                    child: TextButton(
                      onPressed: () => context.go('/auth/register'),
                      child: const Text.rich(
                        TextSpan(
                          text: '¿No tienes cuenta? ',
                          style: TextStyle(
                            color: EduPlayColors.textMedium,
                            fontFamily: 'Nunito',
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: 'Regístrate',
                              style: TextStyle(
                                color: EduPlayColors.primaryBlue,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
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

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().loginParent(
          email: _emailCtrl.text.trim(),
          password: _passwordCtrl.text,
        );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: EduPlayColors.textMedium,
        fontFamily: 'Nunito',
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: EduPlayColors.primaryBlue,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: EduPlayColors.softRed),
      ),
    );
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }
}
