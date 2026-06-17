import 'package:flutter/material.dart';
import '../widgets/section_header.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Impacto de la buena alimentación'), backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              icon: Icons.auto_graph,
              title: 'Impacto de la buena alimentación',
              subtitle: 'Datos de la UNESCO sobre nutrición y rendimiento escolar',
            ),
            const SizedBox(height: 8),
            const Text(
              'Beneficios comprobados',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _DataRow(children: [
              _DataCard(
                value: '9 de cada 10',
                label: 'países invierten en programas de alimentación escolar',
                icon: Icons.public,
                color: const Color(0xFF2E7D32),
              ),
              _DataCard(
                value: '459 millones',
                label: 'de niños reciben comidas escolares en el mundo',
                icon: Icons.restaurant,
                color: const Color(0xFF558B2F),
              ),
            ]),
            const SizedBox(height: 12),
            _DataRow(children: [
              _DataCard(
                value: 'Más matrícula',
                label: 'las comidas escolares aumentan la matriculación',
                icon: Icons.school,
                color: const Color(0xFF00695C),
              ),
              _DataCard(
                value: 'Mejor aprendizaje',
                label: 'los niños bien alimentados aprenden mejor',
                icon: Icons.psychology,
                color: const Color(0xFF4527A0),
              ),
            ]),
            const SizedBox(height: 32),
            const Text(
              'Lo que se puede evitar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _DataRow(children: [
              _DataCard(
                value: '73 millones',
                label: 'de niños marginados sin alimentación escolar',
                icon: Icons.no_food,
                color: const Color(0xFFE53935),
              ),
              _DataCard(
                value: 'Menor aprovechamiento',
                label: 'sin comida escolar disminuye la capacidad de aprender',
                icon: Icons.trending_down,
                color: const Color(0xFFFF6D00),
              ),
            ]),
            const SizedBox(height: 32),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: cs.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.emoji_objects, color: cs.onPrimaryContainer),
                        const SizedBox(width: 8),
                        Text('¿Sabías que...?', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: cs.onPrimaryContainer)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Según la UNESCO, los niños y adolescentes sanos, bien alimentados y felices aprenden mejor y tienen más probabilidades de llevar una vida sana y plena. La alimentación escolar es una inversión que beneficia tanto a la educación como a la salud.',
                      style: theme.textTheme.bodyMedium?.copyWith(color: cs.onPrimaryContainer),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Fuente: UNESCO (2025)',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: cs.onPrimaryContainer.withValues(alpha: 0.6),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  final List<_DataCard> children;
  const _DataRow({required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: children
          .map((c) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: children.indexOf(c) < children.length - 1 ? 12 : 0),
                  child: c,
                ),
              ))
          .toList(),
    );
  }
}

class _DataCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  const _DataCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
