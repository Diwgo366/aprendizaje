import 'package:flutter/material.dart';
import '../widgets/section_header.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  final Set<int> _completedDays = {1, 2, 3};
  final String _currentMonth = 'Junio 2026';
  final int _daysInMonth = 30;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Formación de Hábitos'), backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              icon: Icons.calendar_month,
              title: 'Calendario interactivo',
              subtitle: 'Marca los días que desayunaste bien',
            ),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(icon: const Icon(Icons.chevron_left), onPressed: () {}),
                        Text(_currentMonth, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                        IconButton(icon: const Icon(Icons.chevron_right), onPressed: () {}),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom']
                          .map((d) => Text(d, style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold)))
                          .toList(),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: List.generate(_daysInMonth, (i) {
                        final day = i + 1;
                        final completed = _completedDays.contains(day);
                        final isToday = day == 16;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (completed) {
                                _completedDays.remove(day);
                              } else {
                                _completedDays.add(day);
                              }
                            });
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 88) / 7,
                            height: 40,
                            decoration: BoxDecoration(
                              color: completed
                                  ? Colors.green.withValues(alpha: 0.25)
                                  : isToday
                                      ? cs.primaryContainer
                                      : null,
                              borderRadius: BorderRadius.circular(8),
                              border: isToday && !completed ? Border.all(color: cs.primary, width: 2) : null,
                            ),
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (completed)
                                    const Icon(Icons.check_circle, color: Colors.green, size: 16)
                                  else
                                    Text('$day', style: theme.textTheme.bodySmall),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _DayStat(label: 'Completados', value: '${_completedDays.length}', color: Colors.green),
                        _DayStat(label: 'Racha actual', value: '$_streak', color: Colors.orange),
                        _DayStat(label: 'Porcentaje', value: '${(_completedDays.length / _daysInMonth * 100).toStringAsFixed(0)}%', color: cs.primary),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            const SectionHeader(
              icon: Icons.lightbulb,
              title: 'Consejos para padres',
              subtitle: 'Cómo reforzar hábitos saludables',
              color: Color(0xFFF57C00),
            ),
            ...List.generate(_tips.length, (i) {
              final tip = _tips[i];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: cs.tertiaryContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(tip['icon'] as IconData, color: cs.onTertiaryContainer, size: 24),
                    ),
                    title: Text(tip['title'] as String, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                    subtitle: Text(tip['desc'] as String, style: theme.textTheme.bodySmall),
                  ),
                ),
              );
            }),
            const SizedBox(height: 32),
            const SectionHeader(
              icon: Icons.auto_stories,
              title: 'Historias de éxito',
              subtitle: 'Niños que mejoraron su alimentación',
              color: Color(0xFF7B1FA2),
            ),
            ...List.generate(_stories.length, (i) {
              final story = _stories[i];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: cs.primaryContainer,
                          child: Text('${i + 1}', style: TextStyle(color: cs.onPrimaryContainer, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(story['name'] as String, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(story['text'] as String, style: theme.textTheme.bodyMedium),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  int get _streak {
    int streak = 0;
    for (int day = 16; day >= 1; day--) {
      if (_completedDays.contains(day)) {
        streak++;
      } else {
        break;
      }
    }
    return streak;
  }

  static const _tips = [
    {'icon': Icons.schedule, 'title': 'Establece horarios fijos', 'desc': 'Los niños se adaptan mejor cuando las comidas tienen un horario consistente cada día.'},
    {'icon': Icons.emoji_events, 'title': 'Celebra los logros', 'desc': 'Reconoce cuando tu hijo prueba nuevos alimentos o completa una semana de desayunos saludables.'},
    {'icon': Icons.group, 'title': 'Come en familia', 'desc': 'Los niños que ven a sus padres comer saludablemente tienden a imitar esos comportamientos.'},
    {'icon': Icons.shopping_cart, 'title': 'Involúcralos en las compras', 'desc': 'Lleva a tus hijos al mercado y déjalos elegir frutas y verduras que les llamen la atención.'},
    {'icon': Icons.brush, 'title': 'Presentación divertida', 'desc': 'Usa cortadores de galletas para dar formas divertidas a frutas y verduras.'},
  ];

  static const _stories = [
    {'name': 'Sofía, 8 años', 'text': 'Antes solo quería cereal azucarado. Después de las recetas divertidas, ahora pide batidos de frutas y ayuda a prepararlos.'},
    {'name': 'Mateo, 10 años', 'text': 'Empezó el programa con 0 días marcados. ¡Hoy tiene una racha de 21 días desayunando saludablemente!'},
    {'name': 'Valentina, 7 años', 'text': 'Gracias al calendario de hábitos, Valentina recuerda desayunar bien sola. Sus papás están muy orgullosos.'},
  ];
}

class _DayStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _DayStat({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(value, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: color)),
        Text(label, style: theme.textTheme.labelSmall),
      ],
    );
  }
}
