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
              color: const Color(0xFFFFF8E1),
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
