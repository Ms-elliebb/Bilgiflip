import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/flashcard_model.dart';
import '../models/topic_model.dart';
import '../services/progress_service.dart';

class FlashcardNotifier extends StateNotifier<List<Flashcard>> {
  final List<Flashcard> _originalFlashcards;
  final ProgressService _progressService;

  FlashcardNotifier(this._originalFlashcards, this._progressService)
      : super(_originalFlashcards) {
    _loadKnownCards();
  }

  Future<void> _loadKnownCards() async {
    final knownCardIds = await _progressService.getKnownCards();
    final updatedList = state.map((card) {
      return card.copyWith(isKnown: knownCardIds.contains(card.id));
    }).toList();
    state = updatedList;
  }

  Future<void> markCardAsKnown(int index, bool isKnown) async {
    if (index < 0 || index >= state.length) return;

    final cardToUpdate = state[index];
    final updatedCard = cardToUpdate.copyWith(isKnown: isKnown);

    if (isKnown) {
      await _progressService.saveCardAsKnown(cardToUpdate.id);
    } else {
      await _progressService.saveCardAsUnknown(cardToUpdate.id);
    }

    final updatedList = List<Flashcard>.from(state);
    updatedList[index] = updatedCard;
    state = updatedList;
    
    final originalIndex = _originalFlashcards.indexWhere((c) => c.id == cardToUpdate.id);
    if (originalIndex != -1) {
      _originalFlashcards[originalIndex] = updatedCard;
    }
  }

  void reset() {
    state = _originalFlashcards.map((card) => card.copyWith(isKnown: false)).toList();
    // Note: Resetting in-memory state, not clearing persistent storage here.
    // This could be a design choice. For a full reset, one might clear known cards from progressService.
  }

  void startReviewSession() {
    final reviewList = _originalFlashcards.where((card) => !card.isKnown).toList();
    if (reviewList.isNotEmpty) {
      state = reviewList.map((card) => card.copyWith(isKnown: false)).toList();
    }
  }

  List<Flashcard> get allCards => _originalFlashcards;
}

final flashcardProvider = StateNotifierProvider.family<FlashcardNotifier,
    List<Flashcard>, ({Topic topic, ProgressService progressService})>(
  (ref, params) {
    final copiedFlashcards = params.topic.flashcards.map((c) => c.copyWith()).toList();
    return FlashcardNotifier(copiedFlashcards, params.progressService);
  },
);
