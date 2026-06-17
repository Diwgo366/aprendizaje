import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final IconData icon;
  final List<String> ingredients;
  final String instructions;
  final Color color;

  const RecipeCard({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    required this.ingredients,
    required this.instructions,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ExpansionTile(
        initiallyExpanded: false,
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        expandedAlignment: Alignment.topLeft,
        childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        subtitle: Text('$time • $description', style: theme.textTheme.bodySmall),
        children: [
          const Divider(),
          const SizedBox(height: 8),
          Text('Ingredientes:', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 8),
          ...ingredients.map((i) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check_circle_outline, size: 16, color: color),
                const SizedBox(width: 8),
                Expanded(child: Text(i, style: theme.textTheme.bodyMedium)),
              ],
            ),
          )),
          const SizedBox(height: 12),
          Text('Preparación:', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 8),
          Text(instructions, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.play_circle_outline, size: 18),
            label: const Text('Ver video'),
            style: OutlinedButton.styleFrom(foregroundColor: color),
          ),
        ],
      ),
    );
  }
}
