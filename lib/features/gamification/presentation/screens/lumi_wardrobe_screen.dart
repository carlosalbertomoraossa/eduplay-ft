import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/providers/child_progress_provider.dart';
import '../../../../core/providers/lumi_customization_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/lumi_lion_mascot.dart';

/// Armario de Lumi: permite a niños de la Generación Alfa personalizar su
/// pañoleta, accesorio y estela del látigo usando monedas ganadas aprendiendo.
class LumiWardrobeScreen extends ConsumerStatefulWidget {
  const LumiWardrobeScreen({super.key});

  @override
  ConsumerState<LumiWardrobeScreen> createState() => _LumiWardrobeScreenState();
}

class _LumiWardrobeScreenState extends ConsumerState<LumiWardrobeScreen> {
  LumiItemCategory _selectedCategory = LumiItemCategory.scarf;

  void _onItemTap(LumiShopItem item) {
    final customization = ref.read(lumiCustomizationProvider);
    final customNotifier = ref.read(lumiCustomizationProvider.notifier);

    if (customization.isUnlocked(item.id)) {
      customNotifier.equipItem(item);
      return;
    }

    final coins = ref.read(childProgressProvider).coins;
    if (coins < item.costCoins) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFFEA580C),
          content: Text(
            'Te faltan ${item.costCoins - coins} monedas. ¡Completa misiones o lecciones para ganarlas!',
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
      return;
    }

    final spent = ref.read(childProgressProvider.notifier).spendCoins(item.costCoins);
    if (spent) {
      customNotifier.unlockAndEquip(item);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFF10B981),
          content: Text(
            '¡Desbloqueaste ${item.name}! Lumi ya lo lleva puesto',
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = ref.watch(childProgressProvider);
    final customization = ref.watch(lumiCustomizationProvider);
    final items = LumiCatalog.items
        .where((i) => i.category == _selectedCategory)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFDF7),
        foregroundColor: EduPlayColors.textDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/home'),
        ),
        title: const Text(
          'Armario de Lumi',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFF59E0B), width: 1.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🪙', style: TextStyle(fontSize: 15)),
                const SizedBox(width: 4),
                Text(
                  '${progress.coins}',
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    color: Color(0xFF92400E),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Vista previa viva de Lumi con su outfit equipado
          Container(
            margin: const EdgeInsets.fromLTRB(16, 4, 16, 14),
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  customization.equipped.trailPrimaryColor.withValues(alpha: 0.20),
                  const Color(0xFFFEF9C3),
                  const Color(0xFFE0F2FE),
                ],
              ),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: customization.equipped.scarfPrimaryColor
                    .withValues(alpha: 0.45),
                width: 2,
              ),
            ),
            child: Column(
              children: [
                LumiLionMascot(
                  size: 132,
                  expressionVariant: 1,
                  outfit: customization.equipped,
                )
                    .animate(key: ValueKey(customization.equipped))
                    .scale(
                      begin: const Offset(0.92, 0.92),
                      duration: 280.ms,
                      curve: Curves.elasticOut,
                    ),
                const SizedBox(height: 8),
                const Text(
                  '¡Tu estilo se ve en el inicio y dentro del juego!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    color: EduPlayColors.textDark,
                  ),
                ),
              ],
            ),
          ),

          // Pestañas de categorías
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _CategoryChip(
                  label: '🧣 Pañoletas',
                  selected: _selectedCategory == LumiItemCategory.scarf,
                  onTap: () => setState(
                    () => _selectedCategory = LumiItemCategory.scarf,
                  ),
                ),
                const SizedBox(width: 8),
                _CategoryChip(
                  label: '👑 Accesorios',
                  selected: _selectedCategory == LumiItemCategory.accessory,
                  onTap: () => setState(
                    () => _selectedCategory = LumiItemCategory.accessory,
                  ),
                ),
                const SizedBox(width: 8),
                _CategoryChip(
                  label: '✨ Estelas',
                  selected: _selectedCategory == LumiItemCategory.trail,
                  onTap: () => setState(
                    () => _selectedCategory = LumiItemCategory.trail,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Catálogo de ítems
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.05,
              ),
              itemCount: items.length,
              itemBuilder: (_, index) {
                final item = items[index];
                final unlocked = customization.isUnlocked(item.id);
                final equipped = customization.isEquipped(item);
                return _WardrobeItemCard(
                  item: item,
                  unlocked: unlocked,
                  equipped: equipped,
                  canAfford: progress.coins >= item.costCoins,
                  onTap: () => _onItemTap(item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? EduPlayColors.primaryBlue : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected
                  ? EduPlayColors.primaryBlue
                  : EduPlayColors.primaryBlue.withValues(alpha: 0.25),
              width: 1.8,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: selected ? Colors.white : EduPlayColors.textDark,
            ),
          ),
        ),
      ),
    );
  }
}

class _WardrobeItemCard extends StatelessWidget {
  final LumiShopItem item;
  final bool unlocked;
  final bool equipped;
  final bool canAfford;
  final VoidCallback onTap;

  const _WardrobeItemCard({
    required this.item,
    required this.unlocked,
    required this.equipped,
    required this.canAfford,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: equipped
              ? item.previewColor.withValues(alpha: 0.14)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: equipped
                ? item.previewColor
                : item.previewColor.withValues(alpha: 0.30),
            width: equipped ? 2.6 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: item.previewColor.withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: item.previewColor.withValues(alpha: 0.20),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(item.emoji, style: const TextStyle(fontSize: 26)),
            ),
            Column(
              children: [
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w800,
                    fontSize: 13.5,
                    color: EduPlayColors.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.description,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 11,
                    color: EduPlayColors.textMedium,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: equipped
                    ? const Color(0xFF10B981)
                    : unlocked
                        ? const Color(0xFFE0F2FE)
                        : (canAfford
                            ? const Color(0xFFFEF08A)
                            : const Color(0xFFF1F5F9)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                equipped
                    ? '✓ Puesto'
                    : unlocked
                        ? 'Usar'
                        : '🪙 ${item.costCoins}',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: equipped
                      ? Colors.white
                      : unlocked
                          ? const Color(0xFF0369A1)
                          : (canAfford
                              ? const Color(0xFF92400E)
                              : const Color(0xFF64748B)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
