import 'package:flutter/material.dart';
import '../widgets/section_header.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  int _score = 0;
  int _streak = 0;
  final int _currentDay = 1;
  final Set<String> _earnedBadges = {};
  bool _quizDone = false;

  final List<Map<String, dynamic>> _quiz = [
    {'q': '¿Qué fruta es rica en vitamina C?', 'options': ['Manzana', 'Naranja', 'Uva', 'Pera'], 'answer': 1},
    {'q': '¿Cuál de estos es un cereal integral?', 'options': ['Arroz blanco', 'Avena', 'Pan de molde', 'Galletas'], 'answer': 1},
    {'q': '¿Qué verdura es buena para la vista?', 'options': ['Zanahoria', 'Papa', 'Lechuga', 'Cebolla'], 'answer': 0},
    {'q': '¿Cuál es una fuente de proteína saludable?', 'options': ['Dulces', 'Huevos', 'Papas fritas', 'Refresco'], 'answer': 1},
    {'q': '¿Cuántos vasos de agua se recomienda al día?', 'options': ['2', '4', '6-8', '10+'], 'answer': 2},
  ];

  int _currentQuestion = 0;
  int? _selectedAnswer;

  void _answer(int idx) {
    if (_selectedAnswer != null) return;
    setState(() {
      _selectedAnswer = idx;
      if (idx == _quiz[_currentQuestion]['answer']) {
        _score += 10;
        _streak++;
        if (_streak == 3) _earnedBadges.add('🔥 Racha de 3');
        if (_streak == 5) _earnedBadges.add('⚡ Racha de 5');
      } else {
        _streak = 0;
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestion < _quiz.length - 1) {
      setState(() {
        _currentQuestion++;
        _selectedAnswer = null;
      });
    } else {
      setState(() {
        _quizDone = true;
        if (_score >= 40) _earnedBadges.add('🏆 Maestro del desayuno');
      });
    }
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestion = 0;
      _selectedAnswer = null;
      _quizDone = false;
      _score = 0;
      _streak = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Juegos y Práctica'), backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _StatBadge(
                    icon: Icons.stars,
                    label: 'Puntos',
                    value: '$_score',
                    color: cs.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatBadge(
                    icon: Icons.local_fire_department,
                    label: 'Racha',
                    value: '$_streak',
                    color: cs.tertiary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatBadge(
                    icon: Icons.calendar_view_day,
                    label: 'Día',
                    value: '$_currentDay',
                    color: cs.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const SectionHeader(
              icon: Icons.quiz,
              title: 'Mini-quiz diario',
              subtitle: 'Responde y acumula puntos',
            ),
            if (!_quizDone)
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: const Color(0xFFFFF3E0),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LinearProgressIndicator(
                        value: (_currentQuestion + 1) / _quiz.length,
                        borderRadius: BorderRadius.circular(8),
                        minHeight: 8,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Pregunta ${_currentQuestion + 1} de ${_quiz.length}',
                        style: theme.textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _quiz[_currentQuestion]['q'],
                        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      ...(_quiz[_currentQuestion]['options'] as List<String>).asMap().entries.map((entry) {
                        final idx = entry.key;
                        final opt = entry.value;
                        final isSelected = _selectedAnswer == idx;
                        final isCorrect = idx == _quiz[_currentQuestion]['answer'];
                        Color? bg;
                        if (_selectedAnswer != null) {
                          bg = isCorrect ? Colors.green.withValues(alpha: 0.15) : (isSelected ? Colors.red.withValues(alpha: 0.15) : null);
                        }
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Material(
                            color: bg,
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              onTap: () => _answer(idx),
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                child: Row(
                                  children: [
                                    Icon(
                                      isCorrect && _selectedAnswer != null
                                          ? Icons.check_circle
                                          : isSelected && _selectedAnswer != null
                                              ? Icons.cancel
                                              : Icons.radio_button_unchecked,
                                      color: isCorrect && _selectedAnswer != null
                                          ? Colors.green
                                          : isSelected && _selectedAnswer != null
                                              ? Colors.red
                                              : cs.onSurfaceVariant,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(opt, style: theme.textTheme.bodyLarge),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                      if (_selectedAnswer != null) ...[
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: _nextQuestion,
                            child: Text(_currentQuestion < _quiz.length - 1 ? 'Siguiente' : 'Ver resultados'),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              )
            else
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: const Color(0xFFFFF3E0),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Icon(Icons.emoji_events, size: 64, color: cs.primary),
                      const SizedBox(height: 12),
                      Text('¡Quiz completado!', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('Puntaje final: $_score puntos', style: theme.textTheme.titleLarge?.copyWith(color: cs.primary)),
                      const SizedBox(height: 20),
                      FilledButton(onPressed: _resetQuiz, child: const Text('Jugar de nuevo')),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 32),
            const SectionHeader(
              icon: Icons.emoji_events,
              title: 'Insignias y recompensas',
              subtitle: 'Tus logros desbloqueados',
            ),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                '🥇 Primer quiz',
                '🔥 Racha de 3',
                '⚡ Racha de 5',
                '🏆 Maestro del desayuno',
                '⭐ Reto completado',
                '🎯 100 puntos',
              ].map((badge) {
                final earned = _earnedBadges.contains(badge);
                return FilterChip(
                  selected: earned,
                  selectedColor: cs.primaryContainer,
                  avatar: Icon(
                    earned ? Icons.emoji_events : Icons.lock,
                    size: 16,
                    color: earned ? cs.onPrimaryContainer : cs.onSurfaceVariant,
                  ),
                  label: Text(badge, style: TextStyle(fontSize: 13, color: earned ? cs.onPrimaryContainer : cs.onSurfaceVariant)),
                  onSelected: null,
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: cs.tertiaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(Icons.lock_clock, size: 32),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Próximo reto disponible en:', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('12h 34m', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                          Text(
                            'Vuelve mañana para un nuevo desafío y sigue acumulando puntos.',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatBadge({required this.icon, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 6),
            Text(value, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: color)),
            Text(label, style: theme.textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}
