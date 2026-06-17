import 'package:flutter/material.dart';
import '../widgets/section_header.dart';

const List<Map<String, dynamic>> _tips = [
  {'icon': Icons.schedule, 'title': 'Establece horarios fijos', 'desc': 'Los niños se adaptan mejor cuando las comidas tienen un horario consistente cada día.', 'color': Color(0xFF43A047)},
  {'icon': Icons.emoji_events, 'title': 'Celebra los logros', 'desc': 'Reconoce cuando tu hijo prueba nuevos alimentos o completa una semana de desayunos saludables.', 'color': Color(0xFFFF6F00)},
  {'icon': Icons.group, 'title': 'Come en familia', 'desc': 'Los niños que ven a sus padres comer saludablemente tienden a imitar esos comportamientos.', 'color': Color(0xFF7B1FA2)},
  {'icon': Icons.shopping_cart, 'title': 'Involúcralos en las compras', 'desc': 'Lleva a tus hijos al mercado y déjalos elegir frutas y verduras que les llamen la atención.', 'color': Color(0xFF1976D2)},
  {'icon': Icons.brush, 'title': 'Presentación divertida', 'desc': 'Usa cortadores de galletas para dar formas divertidas a frutas y verduras.', 'color': Color(0xFFE53935)},
];

class ParentsScreen extends StatelessWidget {
  const ParentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              icon: Icons.lightbulb,
              title: 'Consejos para padres',
              subtitle: 'Cómo reforzar hábitos saludables en casa',
              color: Color(0xFFF57C00),
            ),
            ...List.generate(_tips.length, (i) {
              final tip = _tips[i];
              final tipColor = tip['color'] as Color;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  color: Color.lerp(tipColor, Colors.white, 0.88),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: tipColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(tip['icon'] as IconData, color: tipColor, size: 24),
                    ),
                    title: Text(tip['title'] as String, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                    subtitle: Text(tip['desc'] as String, style: theme.textTheme.bodySmall),
                  ),
                ),
              );
            }),
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
      'content': 'Compra frutas y verduras de temporada. Sustituye carnes caras por legumbres (lentejas, garbanzos). La avena es más económica que los cereales azucarados. Congela frutas maduras para licuados. Compra en mercados locales en vez de supermercados.',
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

