import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/common/loading_view.dart';
import 'package:gauva_userapp/core/utils/network_image.dart';
import 'package:gauva_userapp/data/models/banner_model/banner_model.dart';
import 'package:gauva_userapp/presentation/dashboard/provider/banner_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/color_palette.dart';
import '../../account_page/provider/theme_provider.dart';

class PromotionalSlider extends ConsumerStatefulWidget {
  const PromotionalSlider({super.key});

  @override
  ConsumerState<PromotionalSlider> createState() => _PromotionalSliderState();
}

class _PromotionalSliderState extends ConsumerState<PromotionalSlider> {
  int _activeIndex = 0;

  bool isDark()=> ref.read(themeModeProvider.notifier).isDarkMode();
  Future<void> _handleBannerTap(BannerModel banner) async {
    if (banner.redirectLink != null && banner.redirectLink!.isNotEmpty) {
      try {
        final uri = Uri.parse(banner.redirectLink!);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      } catch (e) {
        debugPrint('🔴 Error opening banner link: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bannerProvider);
    final showNothing = state.whenOrNull(
        error: (e) => true, success: (data) => data.isEmpty) ?? false;
    if (showNothing) {
      return const SizedBox.shrink();
    }
    return Container(
      color: isDark() ? Colors.black : ColorPalette.neutralF6,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: state.when(
        initial: () => const SizedBox.shrink(),
        loading: () => const LoadingView(),
        success: (banners) {
          if (banners.isEmpty) {
            return const SizedBox.shrink();
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CarouselSlider.builder(
                itemCount: banners.length,
                itemBuilder: (context, index, realIndex) {
                  final banner = banners[index];
                  return GestureDetector(
                    onTap: () => _handleBannerTap(banner),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Banner Image
                            if (banner.imageUrl != null &&
                                banner.imageUrl!.isNotEmpty)
                              buildNetworkImage(
                                imageUrl: banner.imageUrl!,
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                            else
                              Container(
                                color: ColorPalette.primary50,
                                child: Center(
                                  child: Icon(
                                    Icons.image,
                                    size: 48,
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            // Gradient overlay for text readability
                            if (banner.title != null ||
                                banner.shortDescription != null)
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.7),
                                        Colors.black.withOpacity(0.3),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (banner.title != null)
                                        Text(
                                          banner.title!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      if (banner.shortDescription != null)
                                        Text(
                                          banner.shortDescription!,
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.9),
                                            fontSize: 12,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 160,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  onPageChanged: (index, reason) {
                    setState(() => _activeIndex = index);
                  },
                ),
              ),
              const Gap(8),
              AnimatedSmoothIndicator(
                activeIndex: _activeIndex,
                count: banners.length,
                duration: const Duration(milliseconds: 500),
                effect: const ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  expansionFactor: 2.5,
                  radius: 50,
                  dotColor: ColorPalette.neutral70,
                  activeDotColor: ColorPalette.primary50,
                ),
              ),
            ],
          );
        },
        error: (e) => const SizedBox.shrink(),
      ),
    );
  }
}
