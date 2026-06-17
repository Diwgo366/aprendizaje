import 'package:flutter/material.dart';
import '../widgets/section_header.dart';
import '../widgets/stat_card.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Impacto y Comunidad'), backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              icon: Icons.analytics,
              title: 'Datos de impacto',
              subtitle: 'La buena alimentación mejora el rendimiento escolar',
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: StatCard(value: '30%', label: 'Mejor rendimiento en matemáticas', icon: Icons.calculate, color: cs.primary)),
                const SizedBox(width: 12),
                Expanded(child: StatCard(value: '25%', label: 'Mayor concentración en clase', icon: Icons.psychology, color: cs.secondary)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: StatCard(value: '40%', label: 'Menos ausentismo escolar', icon: Icons.school, color: cs.tertiary)),
                const SizedBox(width: 12),
                Expanded(child: StatCard(value: '3x', label: 'Más probabilidad de graduarse', icon: Icons.trending_up, color: const Color(0xFFE53935))),
              ],
            ),
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
                      'Según la UNESCO, los programas de alimentación escolar no solo mejoran la nutrición, sino que también aumentan las tasas de matriculación y reducen la deserción escolar hasta en un 40%.',
                      style: theme.textTheme.bodyMedium?.copyWith(color: cs.onPrimaryContainer),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            const SectionHeader(
              icon: Icons.auto_stories,
              title: 'Historias de éxito',
              subtitle: 'Colegios y niños que transformaron su alimentación',
              color: Color(0xFF7B1FA2),
            ),
            _SuccessStory(
              icon: Icons.school,
              title: 'IE N° 20524 - Lima',
              subtitle: 'Implementación del programa de desayunos saludables',
              stats: ['200 estudiantes beneficiados', '80% de participación familiar', 'Reducción del 50% en snacks no saludables'],
              color: cs.primary,
            ),
            const SizedBox(height: 12),
            _SuccessStory(
              icon: Icons.people,
              title: 'Comunidad de Madres - Cusco',
              subtitle: 'Talleres de loncheras nutritivas con productos locales',
              stats: ['150 madres capacitadas', 'Quinua y kiwicha como base', 'Recetario bilingüe creado'],
              color: cs.secondary,
            ),
            const SizedBox(height: 12),
            _SuccessStory(
              icon: Icons.emoji_events,
              title: 'Campeones del Desayuno - Arequipa',
              subtitle: 'Concurso inter-escolar de hábitos saludables',
              stats: ['12 colegios participantes', '+500 niños registrados', '90% continuó el programa'],
              color: cs.tertiary,
            ),
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [cs.primary, cs.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Icon(Icons.people_alt, size: 64, color: cs.onPrimary),
                  const SizedBox(height: 16),
                  Text(
                    'Únete a la comunidad',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: cs.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Comparte tus logros, recibe consejos y sé parte del cambio. Juntos podemos mejorar la alimentación de nuestros niños.',
                    style: theme.textTheme.bodyLarge?.copyWith(color: cs.onPrimary.withValues(alpha: 0.9)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: cs.onPrimary,
                        foregroundColor: cs.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('Quiero ser parte', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.share),
                    label: const Text('Compartir mi historia'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: cs.onPrimary,
                      side: BorderSide(color: cs.onPrimary),
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuccessStory extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final List<String> stats;
  final Color color;

  const _SuccessStory({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.stats,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                      Text(subtitle, style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...stats.map((s) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle, size: 16, color: color),
                  const SizedBox(width: 8),
                  Expanded(child: Text(s, style: theme.textTheme.bodyMedium)),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
