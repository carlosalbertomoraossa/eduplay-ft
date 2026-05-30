// Onboarding Screen — 3 pasos para nuevos usuarios
// UX Spec: /specs/product/ux-children.md — "Duración total esperada: < 90 segundos"

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/ep_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  static const _pages = [
    _OnboardingPage(
      emoji: '🌍',
      title: '¡Bienvenido al\nMundo del Saber!',
      subtitle: 'Aprende matemáticas, español y ciencias\njugando con Lumi y sus amigos.',
      bgColor: Color(0xFF3B82F6),
    ),
    _OnboardingPage(
      emoji: '⭐',
      title: '¡Gana estrellas\ny sube de nivel!',
      subtitle: 'Completa lecciones, mantén tu racha diaria\ny desbloquea recompensas increíbles.',
      bgColor: Color(0xFFA855F7),
    ),
    _OnboardingPage(
      emoji: '📚',
      title: 'Aprende con el\ncurrículo colombiano',
      subtitle: 'Todo alineado con lo que aprendes\nen el colegio. ¡Pero mucho más divertido!',
      bgColor: Color(0xFF22C55E),
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/auth/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemCount: _pages.length,
            itemBuilder: (_, i) => _OnboardingPageView(page: _pages[i]),
          ),

          // Indicadores de página
          Positioned(
            bottom: 140,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: i == _currentPage ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(i == _currentPage ? 1 : 0.4),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),

          // Botón continuar
          Positioned(
            bottom: 48,
            left: 32,
            right: 32,
            child: EpButton(
              label: _currentPage == _pages.length - 1 ? '¡Empezar!' : 'Continuar',
              onPressed: _nextPage,
            ),
          ),

          // Skip (solo en páginas 1 y 2)
          if (_currentPage < _pages.length - 1)
            Positioned(
              top: 56,
              right: 24,
              child: TextButton(
                onPressed: () => context.go('/auth/login'),
                child: const Text(
                  'Saltar',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _OnboardingPage {
  final String emoji;
  final String title;
  final String subtitle;
  final Color bgColor;

  const _OnboardingPage({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.bgColor,
  });
}

class _OnboardingPageView extends StatelessWidget {
  final _OnboardingPage page;
  const _OnboardingPageView({required this.page});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: page.bgColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              Text(
                page.emoji,
                style: const TextStyle(fontSize: 100),
              )
                  .animate()
                  .scale(
                    begin: const Offset(0.6, 0.6),
                    duration: 500.ms,
                    curve: Curves.elasticOut,
                  ),

              const SizedBox(height: 40),

              Text(
                page.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontFamily: 'Nunito',
                  height: 1.2,
                ),
              )
                  .animate(delay: 100.ms)
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.2, end: 0),

              const SizedBox(height: 20),

              Text(
                page.subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                  fontFamily: 'Nunito',
                  height: 1.5,
                ),
              )
                  .animate(delay: 200.ms)
                  .fadeIn(duration: 400.ms),

              const SizedBox(height: 160), // espacio para botones
            ],
          ),
        ),
      ),
    );
  }
}
