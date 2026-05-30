// Splash Screen — primera pantalla de EduPlay
// UX Spec: /specs/product/ux-children.md

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_theme.dart';
import '../bloc/auth_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(milliseconds: 1800));
    if (!mounted) return;
    context.read<AuthCubit>().checkStoredSession();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthChildLoggedIn) {
          context.go('/home');
        } else if (state is AuthParentLoggedIn) {
          context.go('/auth/select-child');
        } else if (state is AuthUnauthenticated) {
          context.go('/onboarding');
        }
      },
      child: Scaffold(
        backgroundColor: EduPlayColors.primaryBlue,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo / ícono principal
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    '🌟',
                    style: TextStyle(fontSize: 64),
                  ),
                ),
              )
                  .animate()
                  .scale(
                    begin: const Offset(0.5, 0.5),
                    end: const Offset(1, 1),
                    duration: 600.ms,
                    curve: Curves.elasticOut,
                  ),

              const SizedBox(height: 24),

              const Text(
                'EduPlay',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontFamily: 'Nunito',
                ),
              )
                  .animate(delay: 300.ms)
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.3, end: 0),

              const SizedBox(height: 8),

              const Text(
                '¡Aprender es una aventura!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                  fontFamily: 'Nunito',
                ),
              )
                  .animate(delay: 500.ms)
                  .fadeIn(duration: 400.ms),

              const SizedBox(height: 48),

              const CircularProgressIndicator(
                color: Colors.white54,
                strokeWidth: 2,
              )
                  .animate(delay: 800.ms)
                  .fadeIn(duration: 300.ms),
            ],
          ),
        ),
      ),
    );
  }
}
