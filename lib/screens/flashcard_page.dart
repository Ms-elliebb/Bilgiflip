import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_syntax_highlighter/flutter_syntax_highlighter.dart';
import '../models/topic_model.dart';
import '../providers/data_providers.dart';
import '../providers/flashcard_provider.dart';
import '../utils/app_colors.dart';
import '../widgets/app_background.dart';
import '../widgets/flashcard_view.dart';
import 'results_page.dart';

class FlashcardPage extends ConsumerStatefulWidget {
  final Topic topic;

  const FlashcardPage({super.key, required this.topic});

  @override
  ConsumerState<FlashcardPage> createState() => _FlashcardPageState();
}

class _FlashcardPageState extends ConsumerState<FlashcardPage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  void _onButtonPressed(bool isKnown) {
    final progressService = ref.read(progressServiceProvider);
    final notifier = ref.read(
        flashcardProvider((topic: widget.topic, progressService: progressService)).notifier);
    notifier.markCardAsKnown(_currentIndex, isKnown);

    final flashcards = notifier.allCards;
    final totalCards = flashcards.length;

    if (_currentIndex == totalCards - 1) {
      final knownCount = flashcards.where((c) => c.isKnown).length;
      final unknownCount = totalCards - knownCount;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsPage(
            knownCount: knownCount,
            unknownCount: unknownCount,
            totalCount: totalCards,
            topic: widget.topic,
          ),
        ),
      );
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final progressService = ref.read(progressServiceProvider);
    final flashcards = ref.watch(flashcardProvider((topic: widget.topic, progressService: progressService)));
    final knownCards = flashcards.where((c) => c.isKnown).length;
    final totalCards = flashcards.length;
    final progress = totalCards > 0 ? knownCards / totalCards : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.topic.name),
            if (totalCards > 0)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  'Kart ${_currentIndex + 1} / $totalCards',
                  style: const TextStyle(fontSize: 16, color: AppColors.kSecondaryText),
                ),
              ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.kCardBackground,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.kSuccessColor),
          ),
        ),
      ),
      body: AppBackground(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: totalCards,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final flashcard = flashcards[index];
                  return FlipCard(
                    speed: 600,
                    front: FlashcardView(
                      isKnown: flashcard.isKnown,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          flashcard.question,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ),
                    back: FlashcardView(
                      isKnown: flashcard.isKnown,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: _buildAnswer(flashcard.answer),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            _buildControlButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => _onButtonPressed(false),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.kErrorColor,
                side: const BorderSide(color: AppColors.kErrorColor, width: 2),
              ),
              child: const Text('Tekrar Et'),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: ElevatedButton(
              onPressed: () => _onButtonPressed(true),
              child: const Text('Biliyorum'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswer(String text) {
    final isCode = text.trim().startsWith('```') && text.trim().endsWith('```');
    if (isCode) {
      return _buildCodeBlock(text);
    } else {
      return Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineSmall,
      );
    }
  }

  Widget _buildCodeBlock(String code) {
    final codeBlock =
        code.trim().replaceAll('```dart', '').replaceAll('```', '').trim();
    return SyntaxHighlighter(
      code: codeBlock,
      isDarkMode: true,
    );
  }
}
