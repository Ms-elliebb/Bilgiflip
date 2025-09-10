import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category_model.dart';
import '../providers/data_providers.dart';
import '../utils/app_colors.dart';
import '../widgets/app_background.dart';
import '../widgets/custom_list_tile.dart';
import '../widgets/custom_page_route.dart';
import 'flashcard_page.dart';
import 'package:google_fonts/google_fonts.dart';

class TopicPage extends ConsumerWidget {
  final Category category;

  const TopicPage({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final knownCardsAsyncValue = ref.watch(knownCardsProvider);

    return Scaffold(
      body: AppBackground(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 120.0,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                title: Text(
                  category.name,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                centerTitle: false,
              ),
            ),
            knownCardsAsyncValue.when(
              data: (knownCardIds) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final topic = category.topics[index];
                      final totalCardCount = topic.flashcards.length;
                      if (totalCardCount == 0) {
                        return CustomListTile(
                          title: topic.name,
                          leadingIcon: Icons.article_outlined,
                          onTap: () {
                            Navigator.push(
                              context,
                              CustomPageRoute(child: FlashcardPage(topic: topic)),
                            );
                          },
                        ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.3, curve: Curves.easeOut);
                      }

                      final knownCardCount = topic.flashcards
                          .where((card) => knownCardIds.contains(card.id))
                          .length;
                      final progress = knownCardCount / totalCardCount;

                      return CustomListTile(
                        title: topic.name,
                        leadingIcon: Icons.article_outlined,
                        onTap: () {
                          Navigator.push(
                            context,
                            CustomPageRoute(child: FlashcardPage(topic: topic)),
                          );
                        },
                        trailing: SizedBox(
                          width: 50,
                          height: 50,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: progress,
                                strokeWidth: 3.0,
                                backgroundColor: Colors.white.withOpacity(0.2),
                                valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
                              ),
                              Text(
                                '${(progress * 100).toInt()}%',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.kPrimaryText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.3, curve: Curves.easeOut);
                    },
                    childCount: category.topics.length,
                  ),
                );
              },
              loading: () => const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (err, stack) => SliverToBoxAdapter(
                child: Center(child: Text('Hata: $err')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
