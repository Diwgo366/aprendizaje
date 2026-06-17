import 'package:flutter/material.dart';
import '../widgets/section_header.dart';
import '../widgets/recipe_card.dart';

class BreakfastScreen extends StatefulWidget {
  const BreakfastScreen({super.key});

  @override
  State<BreakfastScreen> createState() => _BreakfastScreenState();
}

class _BreakfastScreenState extends State<BreakfastScreen> {
  final List<Map<String, dynamic>> _recipes = [
    {
      'title': 'Avenada con frutas',
      'description': 'Energía natural para empezar el día',
      'time': '5 min',
      'icon': Icons.grain,
      'color': const Color(0xFFF9A825),
      'ingredients': ['1/2 taza de avena', '1 taza de leche', '1 plátano', 'Fresas al gusto', '1 cucharada de miel'],
      'instructions': 'Cocina la avena con la leche a fuego medio por 3 minutos. Sirve en un bowl y decora con el plátano en rodajas, las fresas picadas y la miel.',
    },
    {
      'title': 'Tortilla de verduras',
      'description': 'Proteína y vitaminas en un solo plato',
      'time': '10 min',
      'icon': Icons.circle,
      'color': const Color(0xFF43A047),
      'ingredients': ['2 huevos', '1/4 de zanahoria rallada', '1/4 de calabacín rallado', 'Sal y pimienta', 'Aceite de oliva'],
      'instructions': 'Bate los huevos y mezcla con las verduras ralladas. Calienta un poco de aceite en un sartén y vierte la mezcla. Cocina 3 minutos por cada lado.',
    },
    {
      'title': 'Batido de frutas',
      'description': 'Refrescante y lleno de vitaminas',
      'time': '3 min',
      'icon': Icons.local_drink,
      'color': const Color(0xFFE53935),
      'ingredients': ['1 taza de leche', '1/2 taza de yogurt', '1/2 taza de frutas mixtas', '1 cucharada de miel', 'Hielo al gusto'],
      'instructions': 'Coloca todos los ingredientes en la licuadora. Licúa por 1 minuto hasta obtener una mezcla homogénea. Sirve inmediatamente.',
    },
    {
      'title': 'Tostadas con aguacate',
      'description': 'Grasas saludables para el cerebro',
      'time': '5 min',
      'icon': Icons.whatshot,
      'color': const Color(0xFF7CB342),
      'ingredients': ['2 rebanadas de pan integral', '1 aguacate maduro', 'Jugo de 1/2 limón', 'Sal y pimienta', 'Tomate cherry'],
      'instructions': 'Tuesta el pan. Machaca el aguacate y mezcla con el jugo de limón, sal y pimienta. Unta sobre el pan y decora con tomates cherry.',
    },
  ];

  int? _gameChoice;
  bool? _gameCorrect;
  int _gameRound = 0;

  final List<Map<String, dynamic>> _gameQuestions = [
    {'question': '¿Cuál de estos es un desayuno saludable?', 'options': ['Fruta con avena', 'Papas fritas', 'Refresco', 'Dulces'], 'correct': 0},
    {'question': '¿Qué bebida es mejor para acompañar el desayuno?', 'options': ['Agua natural', 'Refresco', 'Jugo procesado', 'Café con azúcar'], 'correct': 0},
    {'question': '¿Cuál de estos NO es un desayuno nutritivo?', 'options': ['Huevos con verduras', 'Yogurt con granola', 'Pastel de chocolate', 'Batido de frutas'], 'correct': 2},
  ];

  void _answerGame(int index) {
    final correct = _gameQuestions[_gameRound]['correct'];
    setState(() {
      _gameChoice = index;
      _gameCorrect = index == correct;
    });
  }

  void _nextRound() {
    setState(() {
      _gameRound = (_gameRound + 1) % _gameQuestions.length;
      _gameChoice = null;
      _gameCorrect = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Desayunos Nutritivos'), backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              icon: Icons.restaurant,
              title: 'Recetas saludables',
              subtitle: 'Simples, rápidas y con ingredientes accesibles',
            ),
            ..._recipes.map((r) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: RecipeCard(
                title: r['title'],
                description: r['description'],
                time: r['time'],
                icon: r['icon'],
                ingredients: List<String>.from(r['ingredients']),
                instructions: r['instructions'],
                color: r['color'],
              ),
            )),
            const SizedBox(height: 32),
            SectionHeader(
              icon: Icons.smart_toy,
              title: 'Juego: Elige el desayuno correcto',
              subtitle: 'Ronda ${_gameRound + 1} de ${_gameQuestions.length}',
              color: theme.colorScheme.secondary,
            ),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _gameQuestions[_gameRound]['question'],
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    ...(_gameQuestions[_gameRound]['options'] as List<String>).asMap().entries.map((entry) {
                      final idx = entry.key;
                      final option = entry.value;
                      final isSelected = _gameChoice == idx;
                      final isCorrect = _gameCorrect == true && isSelected;
                      final isWrong = _gameCorrect == false && isSelected;
                      Color? tileColor;
                      if (isCorrect) tileColor = Colors.green.withValues(alpha: 0.15);
                      if (isWrong) tileColor = Colors.red.withValues(alpha: 0.15);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Material(
                          color: tileColor,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            onTap: _gameChoice == null ? () => _answerGame(idx) : null,
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              child: Row(
                                children: [
                                  Icon(
                                    isCorrect ? Icons.check_circle : isWrong ? Icons.cancel : Icons.radio_button_unchecked,
                                    color: isCorrect ? Colors.green : isWrong ? Colors.red : theme.colorScheme.onSurfaceVariant,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(option, style: theme.textTheme.bodyLarge),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    if (_gameChoice != null) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _gameCorrect == true
                              ? Colors.green.withValues(alpha: 0.1)
                              : Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _gameCorrect == true ? Icons.emoji_events : Icons.refresh,
                              color: _gameCorrect == true ? Colors.green : Colors.red,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _gameCorrect == true ? '¡Correcto! Muy bien.' : '¡Sigue intentando!',
                              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: _nextRound,
                          child: Text(_gameRound < _gameQuestions.length - 1 ? 'Siguiente pregunta' : '¡Empezar de nuevo!'),
                        ),
                      ),
                    ],
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
