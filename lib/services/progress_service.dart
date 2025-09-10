import 'package:shared_preferences/shared_preferences.dart';

class ProgressService {
  static const String _knownCardsKey = 'known_cards';

  Future<void> saveCardAsKnown(String cardId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> knownCards = prefs.getStringList(_knownCardsKey) ?? [];
    if (!knownCards.contains(cardId)) {
      knownCards.add(cardId);
      await prefs.setStringList(_knownCardsKey, knownCards);
    }
  }

  Future<void> saveCardAsUnknown(String cardId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> knownCards = prefs.getStringList(_knownCardsKey) ?? [];
    if (knownCards.contains(cardId)) {
      knownCards.remove(cardId);
      await prefs.setStringList(_knownCardsKey, knownCards);
    }
  }

  Future<List<String>> getKnownCards() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_knownCardsKey) ?? [];
  }
}
