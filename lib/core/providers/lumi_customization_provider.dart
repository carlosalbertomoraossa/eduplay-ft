import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _scarfKey = 'lumi_outfit_scarf';
const _accessoryKey = 'lumi_outfit_accessory';
const _trailKey = 'lumi_outfit_trail';
const _unlockedItemsKey = 'lumi_unlocked_items';

enum LumiScarfId {
  emerald,
  skyBlue,
  coralFestive,
  galaxyPurple,
  colombiaTricolor,
}

enum LumiAccessoryId {
  none,
  explorerGoggles,
  goldenStar,
  gamerHeadset,
  royalCrown,
}

enum LumiTrailId {
  emeraldClassic,
  rainbowPastel,
  goldenStar,
  tangerineSpark,
}

enum LumiItemCategory { scarf, accessory, trail }

class LumiOutfit {
  final LumiScarfId scarf;
  final LumiAccessoryId accessory;
  final LumiTrailId trail;

  const LumiOutfit({
    this.scarf = LumiScarfId.emerald,
    this.accessory = LumiAccessoryId.none,
    this.trail = LumiTrailId.emeraldClassic,
  });

  Color get scarfPrimaryColor => switch (scarf) {
        LumiScarfId.emerald => const Color(0xFF10B981),
        LumiScarfId.skyBlue => const Color(0xFF0EA5E9),
        LumiScarfId.coralFestive => const Color(0xFFF43F5E),
        LumiScarfId.galaxyPurple => const Color(0xFF8B5CF6),
        LumiScarfId.colombiaTricolor => const Color(0xFFFACC15),
      };

  Color get scarfSecondaryColor => switch (scarf) {
        LumiScarfId.emerald => const Color(0xFF047857),
        LumiScarfId.skyBlue => const Color(0xFF0369A1),
        LumiScarfId.coralFestive => const Color(0xFFBE123C),
        LumiScarfId.galaxyPurple => const Color(0xFF5B21B6),
        LumiScarfId.colombiaTricolor => const Color(0xFF1D4ED8),
      };

  bool get isTricolorScarf => scarf == LumiScarfId.colombiaTricolor;

  Color get trailPrimaryColor => switch (trail) {
        LumiTrailId.emeraldClassic => const Color(0xFF34D399),
        LumiTrailId.rainbowPastel => const Color(0xFFF472B6),
        LumiTrailId.goldenStar => const Color(0xFFFACC15),
        LumiTrailId.tangerineSpark => const Color(0xFFFB923C),
      };

  Color get trailGlowColor => switch (trail) {
        LumiTrailId.emeraldClassic => const Color(0xFF10B981),
        LumiTrailId.rainbowPastel => const Color(0xFF38BDF8),
        LumiTrailId.goldenStar => const Color(0xFFF59E0B),
        LumiTrailId.tangerineSpark => const Color(0xFFEF4444),
      };

  LumiOutfit copyWith({
    LumiScarfId? scarf,
    LumiAccessoryId? accessory,
    LumiTrailId? trail,
  }) {
    return LumiOutfit(
      scarf: scarf ?? this.scarf,
      accessory: accessory ?? this.accessory,
      trail: trail ?? this.trail,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is LumiOutfit &&
      other.scarf == scarf &&
      other.accessory == accessory &&
      other.trail == trail;

  @override
  int get hashCode => Object.hash(scarf, accessory, trail);
}

class LumiShopItem {
  final String id;
  final LumiItemCategory category;
  final String name;
  final String description;
  final String emoji;
  final int costCoins;
  final Color previewColor;
  final LumiScarfId? scarfId;
  final LumiAccessoryId? accessoryId;
  final LumiTrailId? trailId;

  const LumiShopItem({
    required this.id,
    required this.category,
    required this.name,
    required this.description,
    required this.emoji,
    required this.costCoins,
    required this.previewColor,
    this.scarfId,
    this.accessoryId,
    this.trailId,
  });
}

class LumiCatalog {
  static const List<LumiShopItem> items = [
    // ── Pañoletas ──
    LumiShopItem(
      id: 'scarf_emerald',
      category: LumiItemCategory.scarf,
      name: 'Pañoleta Esmeralda',
      description: 'Clásica de Lumi Explorador',
      emoji: '💚',
      costCoins: 0,
      previewColor: Color(0xFF10B981),
      scarfId: LumiScarfId.emerald,
    ),
    LumiShopItem(
      id: 'scarf_sky',
      category: LumiItemCategory.scarf,
      name: 'Pañoleta Cielo',
      description: 'Brisa fresca de las montañas',
      emoji: '💙',
      costCoins: 30,
      previewColor: Color(0xFF0EA5E9),
      scarfId: LumiScarfId.skyBlue,
    ),
    LumiShopItem(
      id: 'scarf_coral',
      category: LumiItemCategory.scarf,
      name: 'Pañoleta Coral',
      description: 'Energía vibrante de aventura',
      emoji: '❤️',
      costCoins: 40,
      previewColor: Color(0xFFF43F5E),
      scarfId: LumiScarfId.coralFestive,
    ),
    LumiShopItem(
      id: 'scarf_galaxy',
      category: LumiItemCategory.scarf,
      name: 'Pañoleta Galaxia',
      description: 'Morado brillante de estrellas',
      emoji: '💜',
      costCoins: 55,
      previewColor: Color(0xFF8B5CF6),
      scarfId: LumiScarfId.galaxyPurple,
    ),
    LumiShopItem(
      id: 'scarf_colombia',
      category: LumiItemCategory.scarf,
      name: 'Pañoleta Tricolor',
      description: 'Orgullo colombiano 🇨🇴',
      emoji: '🇨🇴',
      costCoins: 75,
      previewColor: Color(0xFFFACC15),
      scarfId: LumiScarfId.colombiaTricolor,
    ),
    // ── Accesorios ──
    LumiShopItem(
      id: 'acc_none',
      category: LumiItemCategory.accessory,
      name: 'Sin accesorio',
      description: 'Orejitas y melena al natural',
      emoji: '🦁',
      costCoins: 0,
      previewColor: Color(0xFFFBBF24),
      accessoryId: LumiAccessoryId.none,
    ),
    LumiShopItem(
      id: 'acc_goggles',
      category: LumiItemCategory.accessory,
      name: 'Gafas de Explorador',
      description: 'Listo para saltar más alto',
      emoji: '🥽',
      costCoins: 45,
      previewColor: Color(0xFF38BDF8),
      accessoryId: LumiAccessoryId.explorerGoggles,
    ),
    LumiShopItem(
      id: 'acc_star',
      category: LumiItemCategory.accessory,
      name: 'Broche Estrella',
      description: 'Estrella dorada en la melena',
      emoji: '🌟',
      costCoins: 50,
      previewColor: Color(0xFFFACC15),
      accessoryId: LumiAccessoryId.goldenStar,
    ),
    LumiShopItem(
      id: 'acc_headset',
      category: LumiItemCategory.accessory,
      name: 'Audífonos Gamer',
      description: 'Ritmo total para resolver retos',
      emoji: '🎧',
      costCoins: 70,
      previewColor: Color(0xFFEC4899),
      accessoryId: LumiAccessoryId.gamerHeadset,
    ),
    LumiShopItem(
      id: 'acc_crown',
      category: LumiItemCategory.accessory,
      name: 'Coronita Real',
      description: 'Campeón del Cuaderno Mágico',
      emoji: '👑',
      costCoins: 95,
      previewColor: Color(0xFFF59E0B),
      accessoryId: LumiAccessoryId.royalCrown,
    ),
    // ── Estelas y látigo ──
    LumiShopItem(
      id: 'trail_emerald',
      category: LumiItemCategory.trail,
      name: 'Liana Esmeralda',
      description: 'Destello verde clásico',
      emoji: '✨',
      costCoins: 0,
      previewColor: Color(0xFF34D399),
      trailId: LumiTrailId.emeraldClassic,
    ),
    LumiShopItem(
      id: 'trail_rainbow',
      category: LumiItemCategory.trail,
      name: 'Estela Arcoíris',
      description: 'Chispas pastel multicolor',
      emoji: '🌈',
      costCoins: 55,
      previewColor: Color(0xFFF472B6),
      trailId: LumiTrailId.rainbowPastel,
    ),
    LumiShopItem(
      id: 'trail_golden',
      category: LumiItemCategory.trail,
      name: 'Cometa Dorado',
      description: 'Brillo solar en cada dash',
      emoji: '⭐',
      costCoins: 65,
      previewColor: Color(0xFFFACC15),
      trailId: LumiTrailId.goldenStar,
    ),
    LumiShopItem(
      id: 'trail_tangerine',
      category: LumiItemCategory.trail,
      name: 'Chispa Mandarina',
      description: 'Velocidad naranja ardiente',
      emoji: '🔥',
      costCoins: 65,
      previewColor: Color(0xFFFB923C),
      trailId: LumiTrailId.tangerineSpark,
    ),
  ];

  static const Set<String> defaultUnlockedIds = {
    'scarf_emerald',
    'acc_none',
    'trail_emerald',
  };
}

class LumiCustomizationState {
  final LumiOutfit equipped;
  final Set<String> unlockedItemIds;

  const LumiCustomizationState({
    this.equipped = const LumiOutfit(),
    this.unlockedItemIds = LumiCatalog.defaultUnlockedIds,
  });

  bool isUnlocked(String itemId) => unlockedItemIds.contains(itemId);

  bool isEquipped(LumiShopItem item) {
    if (item.scarfId != null) return equipped.scarf == item.scarfId;
    if (item.accessoryId != null) return equipped.accessory == item.accessoryId;
    if (item.trailId != null) return equipped.trail == item.trailId;
    return false;
  }
}

final lumiCustomizationProvider =
    StateNotifierProvider<LumiCustomizationNotifier, LumiCustomizationState>(
  (ref) => LumiCustomizationNotifier(),
);

class LumiCustomizationNotifier extends StateNotifier<LumiCustomizationState> {
  final SharedPreferences? _prefs;

  LumiCustomizationNotifier([this._prefs]) : super(_load(_prefs));

  static LumiCustomizationState _load(SharedPreferences? prefs) {
    if (prefs == null) return const LumiCustomizationState();
    final scarfName = prefs.getString(_scarfKey);
    final accName = prefs.getString(_accessoryKey);
    final trailName = prefs.getString(_trailKey);
    final unlocked = {
      ...LumiCatalog.defaultUnlockedIds,
      ...(prefs.getStringList(_unlockedItemsKey) ?? const []),
    };

    final scarf = LumiScarfId.values.firstWhere(
      (e) => e.name == scarfName,
      orElse: () => LumiScarfId.emerald,
    );
    final acc = LumiAccessoryId.values.firstWhere(
      (e) => e.name == accName,
      orElse: () => LumiAccessoryId.none,
    );
    final trail = LumiTrailId.values.firstWhere(
      (e) => e.name == trailName,
      orElse: () => LumiTrailId.emeraldClassic,
    );

    return LumiCustomizationState(
      equipped: LumiOutfit(scarf: scarf, accessory: acc, trail: trail),
      unlockedItemIds: unlocked,
    );
  }

  void _persist(LumiCustomizationState next) {
    state = next;
    _prefs?.setString(_scarfKey, next.equipped.scarf.name);
    _prefs?.setString(_accessoryKey, next.equipped.accessory.name);
    _prefs?.setString(_trailKey, next.equipped.trail.name);
    _prefs?.setStringList(_unlockedItemsKey, next.unlockedItemIds.toList());
  }

  void unlockAndEquip(LumiShopItem item) {
    final nextUnlocked = {...state.unlockedItemIds, item.id};
    final nextOutfit = _applyItem(state.equipped, item);
    _persist(LumiCustomizationState(
      equipped: nextOutfit,
      unlockedItemIds: nextUnlocked,
    ));
  }

  void equipItem(LumiShopItem item) {
    if (!state.isUnlocked(item.id)) return;
    _persist(LumiCustomizationState(
      equipped: _applyItem(state.equipped, item),
      unlockedItemIds: state.unlockedItemIds,
    ));
  }

  LumiOutfit _applyItem(LumiOutfit current, LumiShopItem item) {
    if (item.scarfId != null) return current.copyWith(scarf: item.scarfId);
    if (item.accessoryId != null) {
      return current.copyWith(accessory: item.accessoryId);
    }
    if (item.trailId != null) return current.copyWith(trail: item.trailId);
    return current;
  }
}
