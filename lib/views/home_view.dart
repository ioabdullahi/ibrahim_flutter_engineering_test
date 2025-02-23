import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibrahim_abdullahi_flutter_engineering_translation_test/models/category.dart';
import '../viewmodels/home_viewmodel.dart';
import '../widgets/offer_card.dart';
import 'package:ibrahim_abdullahi_flutter_engineering_translation_test/core/app_colors.dart';
import 'package:ibrahim_abdullahi_flutter_engineering_translation_test/core/app_text_styles.dart';
import 'package:ibrahim_abdullahi_flutter_engineering_translation_test/core/image_constants.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _bottomNavController;
  late AnimationController _buyRentController;
  late Animation<Offset> _slideInFromLeft;
  late Animation<Offset> _slideInOffers;
  late Animation<Offset> _welcomeSlideUp;
  late Animation<double> _buyBounce;
  late Animation<double> _rentBounce;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _bottomNavController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _buyRentController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));

    _slideInFromLeft = Tween<Offset>(
      begin: const Offset(-0.3, 0),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _slideController, curve: Curves.easeInOut));

    _slideInOffers = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _slideController, curve: Curves.easeInOut));

    // Welcome Text Animation
    _welcomeSlideUp = Tween<Offset>(
      begin: const Offset(0, 0.5), // Start from below
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    // Buy/Rent Buttons Bounce In Animation
    _buyBounce = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _buyRentController, curve: Curves.bounceOut));

    _rentBounce = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _buyRentController, curve: Curves.bounceOut));

    Future.delayed(const Duration(milliseconds: 300), () {
      _slideController.forward();
      Future.delayed(const Duration(milliseconds: 400), () {
        _buyRentController.forward();
        _bottomNavController.forward();
      });
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _bottomNavController.dispose();
    _buyRentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = ref.watch(homeViewModelProvider);

    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // City Selector and Profile Icon Section
                      SlideTransition(
                        position: _slideInFromLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(color: AppColors.white),
                              child: Row(
                                children: [
                                  Image.asset(ImageConstants.locationIcon,
                                      width: 20, height: 20),
                                  const SizedBox(width: 5),
                                  Text("Saint Petersburg",
                                      style: AppTextStyles.heading),
                                ],
                              ),
                            ),
                            const CircleAvatar(
                              radius: 18,
                              backgroundImage:
                                  AssetImage(ImageConstants.officialPortrait),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Welcome Text Section
                      SlideTransition(
                        position: _welcomeSlideUp,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Hi, Marina", style: AppTextStyles.body),
                            Text("let’s select your perfect place",
                                style: AppTextStyles.main),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // BUY / RENT Options Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ScaleTransition(
                            scale: _buyBounce,
                            child: CategoryButton(
                              title: "BUY",
                              count: 1034,
                              isSelected: true,
                              isCircular: true,
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 15),
                          ScaleTransition(
                            scale: _rentBounce,
                            child: CategoryButton(
                              title: "RENT",
                              count: 2212,
                              isSelected: false,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // First Offer Card to be full width
              if (homeViewModel.offerCards.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SlideTransition(
                      position: _slideInOffers,
                      child: OfferCard(
                        location: homeViewModel.offerCards[0].location,
                        imageUrl: homeViewModel.offerCards[0].imageUrl,
                        isFullWidth: true,
                      ),
                    ),
                  ),
                ),

              // Remaining OfferCard in Grid
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return SlideTransition(
                        position: _slideInOffers,
                        child: OfferCard(
                          location: homeViewModel.offerCards[index].location,
                          imageUrl: homeViewModel.offerCards[index].imageUrl,
                          isFullWidth: false,
                        ),
                      );
                    },
                    childCount: homeViewModel.offerCards.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
