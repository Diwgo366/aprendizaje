import 'package:flutter/material.dart';
import '../widgets/section_header.dart';

class ParentsScreen extends StatelessWidget {
  const ParentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Padres y Docentes'), backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              icon: Icons.school,
              title: 'Guías prácticas',
              subtitle: 'Prepara loncheras nutritivas y económicas',
            ),
            ...List.generate(_guides.length, (i) {
              final guide = _guides[i];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: ExpansionTile(
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: (guide['color'] as Color).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(guide['icon'] as IconData, color: guide['color'] as Color, size: 24),
                    ),
                    title: Text(guide['title'] as String, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                    subtitle: Text(guide['subtitle'] as String, style: theme.textTheme.bodySmall),
                    childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(),
                      const SizedBox(height: 8),
                      Text(guide['content'] as String, style: theme.textTheme.bodyMedium),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.download, size: 18),
                        label: const Text('Descargar guía'),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 32),
            const SectionHeader(
              icon: Icons.download,
              title: 'Material descargable',
              subtitle: 'Infografías y listas de compras',
              color: Color(0xFF1976D2),
            ),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _DownloadCard(
                  icon: Icons.bar_chart,
                  title: 'Infografía: Plato saludable',
                  desc: 'Visualmente atractivo para niños',
                  color: cs.primary,
                ),
                _DownloadCard(
                  icon: Icons.checklist,
                  title: 'Lista de compras semanal',
                  desc: 'Alimentos esenciales económicos',
                  color: cs.secondary,
                ),
                _DownloadCard(
                  icon: Icons.calendar_view_week,
                  title: 'Menú semanal',
                  desc: '5 días de desayunos nutritivos',
                  color: cs.tertiary,
                ),
                _DownloadCard(
                  icon: Icons.science,
                  title: 'Recetario ilustrado',
                  desc: '10 recetas paso a paso',
                  color: const Color(0xFFE53935),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const SectionHeader(
              icon: Icons.forum,
              title: 'Foro y sugerencias',
              subtitle: 'Comparte experiencias con otros padres y docentes',
              color: Color(0xFF6A1B9A),
            ),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Comparte tu experiencia...',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              filled: true,
                              fillColor: cs.surfaceContainerHighest,
                            ),
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            const SizedBox(width: 4),
                            Text('4.8', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(width: 4),
                            Text('(128 experiencias)', style: theme.textTheme.bodySmall),
                          ],
                        ),
                        FilledButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.send, size: 18),
                          label: const Text('Enviar'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),
                    _ForumPost(
                      avatar: 'MP',
                      name: 'María Pérez',
                      date: 'Hace 2 días',
                      text: 'Implementé el menú semanal con mi hijo de 9 años y ya noto más energía en las mañanas. ¡Gracias por las recetas!',
                      likes: 24,
                    ),
                    const SizedBox(height: 12),
                    _ForumPost(
                      avatar: 'CL',
                      name: 'Carlos López',
                      date: 'Hace 5 días',
                      text: 'Soy docente de primaria y compartí las infografías con mis alumnos. Les encantó y varios padres me pidieron más material.',
                      likes: 18,
                    ),
                    const SizedBox(height: 12),
                    _ForumPost(
                      avatar: 'AG',
                      name: 'Ana García',
                      date: 'Hace 1 semana',
                      text: 'La lista de compras me ayudó a organizarme mejor y ahorrar. Antes compraba cosas innecesarias y ahora voy directo a lo saludable.',
                      likes: 31,
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

  static const _guides = [
    {
      'icon': Icons.lunch_dining,
      'title': 'Lonchera nutritiva en 3 pasos',
      'subtitle': 'Incluye carbohidratos, proteínas y vitaminas',
      'content': 'Paso 1: Elige una base de carbohidratos complejos (pan integral, tortilla de maíz, arroz). Paso 2: Agrega una fuente de proteína (huevo, pollo, frijoles, queso). Paso 3: Incluye fruta fresca y agua natural. Evita jugos procesados y snacks empacados.',
      'color': Color(0xFF43A047),
    },
    {
      'icon': Icons.attach_money,
      'title': 'Comer saludable sin gastar de más',
      'subtitle': 'Alternativas económicas y nutritivas',
      'content': 'Compra frutas y verduras de temporada. Sustituye carnes caras por legumbres (lentejas, garbanzos). La avena es más económica que los cereales azucarados. Congela frutas maduras para batidos. Compra en mercados locales en vez de supermercados.',
      'color': Color(0xFFF57C00),
    },
    {
      'icon': Icons.menu_book,
      'title': 'Cómo hablar con niños sobre nutrición',
      'subtitle': 'Sin prohibiciones ni presiones',
      'content': 'Usa lenguaje positivo: "este alimento te dará energía para jugar". Evita etiquetar alimentos como "buenos" o "malos". Involucra a los niños en la cocina. Cuenta historias sobre cómo los alimentos ayudan a crecer fuerte. No uses la comida como recompensa o castigo.',
      'color': Color(0xFF7B1FA2),
    },
  ];
}

class _DownloadCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  final Color color;

  const _DownloadCard({required this.icon, required this.title, required this.desc, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 72) / 2,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
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
                Text(title, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(desc, style: theme.textTheme.bodySmall, maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.file_download, size: 16, color: color),
                    const SizedBox(width: 4),
                    Text('PDF', style: theme.textTheme.labelSmall?.copyWith(color: color)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ForumPost extends StatelessWidget {
  final String avatar;
  final String name;
  final String date;
  final String text;
  final int likes;

  const _ForumPost({required this.avatar, required this.name, required this.date, required this.text, required this.likes});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Text(avatar, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: theme.colorScheme.onPrimaryContainer)),
            ),
            const SizedBox(width: 8),
            Text(name, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Text(date, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          ],
        ),
        const SizedBox(height: 4),
        Text(text, style: theme.textTheme.bodyMedium),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.thumb_up_off_alt, size: 16, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(width: 4),
            Text('$likes', style: theme.textTheme.bodySmall),
          ],
        ),
      ],
    );
  }
}
