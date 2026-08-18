// Registro del padre/tutor
// Spec: ../.sdd/implemented/features/domain-auth/technical-specs.md, ../.sdd/implemented/features/domain-auth/auth-service.openapi.yaml
// Consentimiento parental obligatorio (regla COPPA-like del proyecto — ver CLAUDE.md raíz)

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../shared/widgets/ep_button.dart';
import '../bloc/auth_cubit.dart';

class ParentRegisterScreen extends StatefulWidget {
  const ParentRegisterScreen({super.key});

  @override
  State<ParentRegisterScreen> createState() => _ParentRegisterScreenState();
}

class _ParentRegisterScreenState extends State<ParentRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  bool _obscurePassword = true;
  bool _consentGiven = false;
  bool _consentTouched = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthRegistered) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Revisa ${state.email} para verificar tu cuenta'),
              backgroundColor: EduPlayColors.primaryBlue,
              duration: const Duration(seconds: 4),
            ),
          );
          context.go('/auth/login');
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
                  Center(
                    child: Column(
                      children: [
                        const Text('🌟', style: TextStyle(fontSize: 56))
                            .animate()
                            .scale(duration: 400.ms, curve: Curves.elasticOut),
                        const SizedBox(height: 12),
                        const Text(
                          'Crea tu cuenta',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: EduPlayColors.primaryBlue,
                            fontFamily: 'Nunito',
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Para acompañar el aprendizaje de tu hijo/a',
                          textAlign: TextAlign.center,
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
                      if (v.length < 8) return 'Mínimo 8 caracteres';
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Confirmar contraseña',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: EduPlayColors.textDark,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _confirmPasswordCtrl,
                    obscureText: _obscurePassword,
                    decoration: _inputDecoration('••••••••'),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Confirma tu contraseña';
                      if (v != _passwordCtrl.text) {
                        return 'Las contraseñas no coinciden';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  InkWell(
                    onTap: () => setState(() {
                      _consentGiven = !_consentGiven;
                      _consentTouched = true;
                    }),
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: _consentGiven,
                            onChanged: (v) => setState(() {
                              _consentGiven = v ?? false;
                              _consentTouched = true;
                            }),
                            activeColor: EduPlayColors.primaryBlue,
                          ),
                          const SizedBox(width: 4),
                          const Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 12),
                              child: Text(
                                'Confirmo que soy el padre, madre o tutor legal '
                                'del niño o niña que usará esta cuenta, y doy mi '
                                'consentimiento para su registro.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: EduPlayColors.textMedium,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_consentTouched && !_consentGiven)
                    const Padding(
                      padding: EdgeInsets.only(left: 12, top: 4),
                      child: Text(
                        'Debes confirmar el consentimiento parental para continuar',
                        style: TextStyle(
                          color: EduPlayColors.softRed,
                          fontSize: 13,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),

                  const SizedBox(height: 24),

                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return EpButton(
                        label: 'Crear cuenta',
                        isLoading: state is AuthLoading,
                        onPressed: state is AuthLoading ? null : _submit,
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  Center(
                    child: TextButton(
                      onPressed: () => context.go('/auth/login'),
                      child: const Text.rich(
                        TextSpan(
                          text: '¿Ya tienes cuenta? ',
                          style: TextStyle(
                            color: EduPlayColors.textMedium,
                            fontFamily: 'Nunito',
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: 'Inicia sesión',
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
    setState(() => _consentTouched = true);
    if (!_formKey.currentState!.validate()) return;
    if (!_consentGiven) return;
    context.read<AuthCubit>().register(
          email: _emailCtrl.text.trim(),
          password: _passwordCtrl.text,
          consentGiven: _consentGiven,
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
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }
}
