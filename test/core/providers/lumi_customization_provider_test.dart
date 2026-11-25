import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:edplay_ft/core/providers/lumi_customization_provider.dart';

void main() {
  group('LumiCustomizationNotifier', () {
    test('desbloquea, equipa y persiste outfit de Lumi', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      final notifier = LumiCustomizationNotifier(prefs);
      expect(notifier.state.equipped.scarf, LumiScarfId.emerald);
      expect(notifier.state.equipped.accessory, LumiAccessoryId.none);

      final tricolor = LumiCatalog.items
          .firstWhere((i) => i.id == 'scarf_colombia');
      final goggles = LumiCatalog.items
          .firstWhere((i) => i.id == 'acc_goggles');

      // No equipa algo bloqueado sin desbloquear
      notifier.equipItem(tricolor);
      expect(notifier.state.equipped.scarf, LumiScarfId.emerald);

      // Desbloquea y equipa
      notifier.unlockAndEquip(tricolor);
      notifier.unlockAndEquip(goggles);
      expect(notifier.state.equipped.scarf, LumiScarfId.colombiaTricolor);
      expect(notifier.state.equipped.accessory, LumiAccessoryId.explorerGoggles);

      // Persiste en SharedPreferences
      final reloaded = LumiCustomizationNotifier(prefs);
      expect(reloaded.state.equipped.scarf, LumiScarfId.colombiaTricolor);
      expect(reloaded.state.equipped.accessory, LumiAccessoryId.explorerGoggles);
      expect(reloaded.state.isUnlocked('scarf_colombia'), isTrue);
    });
  });
}
