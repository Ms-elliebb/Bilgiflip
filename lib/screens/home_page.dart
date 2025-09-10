import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/data_providers.dart';
import '../widgets/app_background.dart';
import '../widgets/custom_list_tile.dart';
import 'topic_page.dart';
import '../widgets/custom_page_route.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsyncValue = ref.watch(categoriesProvider);

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
                  'Kategoriler',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                centerTitle: false,
              ),
            ),
            categoriesAsyncValue.when(
              data: (categories) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final category = categories[index];
                      return CustomListTile(
                        title: category.name,
                        leadingIcon: IconData(category.iconCode, fontFamily: 'MaterialIcons'),
                        onTap: () {
                          Navigator.push(
                            context,
                            CustomPageRoute(child: TopicPage(category: category)),
                          );
                        },
                      ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.3, curve: Curves.easeOut);
                    },
                    childCount: categories.length,
                  ),
                );
              },
              loading: () => const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, stackTrace) => SliverToBoxAdapter(
                child: Center(child: Text('Bir hata oluştu: $error')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
