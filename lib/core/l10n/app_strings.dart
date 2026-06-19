// Strings de la app — preparación para l10n con .arb
// Centralizar todos los textos visibles al usuario aquí.
// En el futuro, migrar a app_es.arb / app_en.arb usando flutter gen-l10n.

abstract final class EduPlayStrings {
  // ── General ──
  static const appTitle = 'EduPlay';
  static const ok = '¡Listo!';
  static const cancel = 'Cancelar';
  static const exit = 'Salir';
  static const next = 'Siguiente';
  static const retry = 'Intentar de nuevo';
  static const continue_ = 'Continuar';
  static const loading = 'Cargando...';
  static const comingSoon = '¡Pronto disponible!';

  // ── Onboarding ──
  static const onboarding1Title = '¡Bienvenido a EduPlay!';
  static const onboarding1Body = 'Aprende matemáticas jugando. Cada lección es una aventura.';
  static const onboarding2Title = 'Gana estrellas y monedas';
  static const onboarding2Body = 'Completa ejercicios, sube de nivel y desbloquea juegos.';
  static const onboarding3Title = '¿Listo para empezar?';
  static const onboarding3Body = 'Elige tu grado y comienza tu camino de aprendizaje.';

  // ── Auth ──
  static const loginTitle = 'Iniciar Sesión';
  static const loginEmailHint = 'Correo electrónico';
  static const loginPasswordHint = 'Contraseña';
  static const loginButton = 'Entrar';
  static const selectChildTitle = '¿Quién va a jugar?';
  static const parentDashboard = 'Panel de Padres';
  static const logout = 'Cerrar sesión';

  // ── Home ──
  static const homeGreeting = '¡Hola!';
  static const homeGradeLabel = 'Grado';
  static const homeGamesBanner = 'Juegos';
  static const homePlayNow = '¡Jugar ahora!';

  // ── Lesson ──
  static const lessonNotFound = 'Lección no encontrada';
  static const lessonFailed = '¡Necesitas practicar más esto!';
  static const lessonCompleted = '¡Lección completada!';
  static const lessonSubmit = 'Terminar lección';
  static const exerciseCorrect = '¡Correcto!';
  static const exerciseIncorrect = '¡Casi! Sigue intentando.';
  static const heartsRemaining = 'corazones';

  // ── Result ──
  static const resultScore = 'Puntaje';
  static const resultCorrect = 'Correctas';
  static const resultXp = 'XP ganado';
  static const resultCoins = 'Monedas';
  static const resultContinue = 'Continuar';

  // ── Game G4 ──
  static const gameTitle = 'La Aventura del Cuarto Grado';
  static const gameSelectLevel = 'Elige tu nivel';
  static const gameLevelComplete = '¡Nivel completado!';
  static const gameComplete = '¡Completaste la Aventura del Cuarto Grado!';
  static const gameCompleteSubtitle = '¡Eres un campeón de las matemáticas!';
  static const gameOver = '¡Oh no!';
  static const gameOverRetry = 'Jugar de nuevo';
  static const gameScore = 'puntos';
  static const gameCorrect = 'correctas';
  static const gameAccuracy = 'precisión';
  static const gameLevels = 'niveles';
  static const gameXp = 'XP';
  static const gameCoins = 'monedas';

  // ── Parent Dashboard ──
  static const parentChildProgress = 'Progreso';
  static const parentWeeklyActivity = 'Actividad semanal';
  static const parentUnitProgress = 'Avance por unidad';

  // ── Placeholder screens ──
  static const achievements = 'Logros';
  static const leaderboard = 'Ranking';

  // ── Errors ──
  static const errorGeneric = 'Algo salió mal. ¡Intenta de nuevo!';
  static const errorNetwork = 'Sin conexión. Revisa tu internet.';
  static const errorAuth = 'La contraseña o PIN es incorrecto. ¡Intenta de nuevo!';
}
