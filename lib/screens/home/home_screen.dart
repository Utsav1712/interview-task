import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_assets.dart';

import '../../widgets/category_item.dart';
import '../../widgets/search_input_field.dart';
import '../../widgets/section_header.dart';
import '../../widgets/trending_card.dart';
import '../../widgets/experience_card.dart';
import '../../widgets/flash_deal_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late final TextEditingController _destinationController;
  late final TextEditingController _dateController;
  late final TextEditingController _travelersController;

  @override
  void initState() {
    super.initState();
    _destinationController = TextEditingController(
      text: 'Dubai, United Arab Emirates',
    );
    _dateController = TextEditingController(text: '1 July - 3 July');
    _travelersController = TextEditingController(text: '2 Travelers - 1 room');
  }

  @override
  void dispose() {
    _destinationController.dispose();
    _dateController.dispose();
    _travelersController.dispose();
    super.dispose();
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF5E29CD),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        final start = DateFormat('d MMM').format(picked.start);
        final end = DateFormat('d MMM').format(picked.end);
        _dateController.text = '$start - $end';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchCard(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRecentSearch(),
                  _buildHotAndTrending(),
                  _buildLifeExperience(),
                  _buildFlashDeals(),
                  _buildPromoBanners(),
                  SizedBox(height: 100.h), // Space for bottom nav
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButton: _buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 60.h,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF32C5FF), Color(0xFF5E29CD)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10.h,
            right: -10.w,
            child: Image.asset(
              AppAssets.palmTrees,
              height: 80.h,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchCard() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.r),
          bottomRight: Radius.circular(32.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Categories
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CategoryItem(
                  label: 'Hotels',
                  iconPath: AppAssets.building,
                  isSelected: true,
                  onTap: () {},
                ),
                SizedBox(width: 12.w),
                CategoryItem(
                  label: 'Flights',
                  iconPath: AppAssets.airplane,
                  onTap: () {},
                ),
                SizedBox(width: 12.w),
                CategoryItem(
                  label: 'Life Experience',
                  iconPath: AppAssets.location,
                  onTap: () {},
                ),
                SizedBox(width: 12.w),
                CategoryItem(
                  label: 'Cars',
                  iconPath: AppAssets.taxi,
                  onTap: () {},
                ),
                SizedBox(width: 12.w),
                CategoryItem(
                  label: 'Cruises',
                  iconPath: AppAssets.ship,
                  onTap: () {},
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          // Search Inputs
          SearchInputField(
            icon: Icons.location_on_outlined,
            title: 'Destination',
            controller: _destinationController,
          ),
          SearchInputField(
            icon: Icons.calendar_today_outlined,
            title: 'Date',
            controller: _dateController,
            onTap: _selectDateRange,
            readOnly: true,
            showCursor: false,
          ),
          SearchInputField(
            icon: Icons.person_outline,
            title: 'Travelers',
            controller: _travelersController,
          ),
          SizedBox(height: 16.h),
          // Search Button
          Container(
            width: double.infinity,
            height: 48.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF32C5FF), Color(0xFF5E29CD)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Center(
              child: Text(
                'Search',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Recent Search'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildRecentSearchItem(
                'HOTELS',
                'Dubai',
                '12 Aug - 25 Aug',
                '1 Room • 2 travellers',
              ),
              _buildRecentSearchItem(
                'FLIGHTS',
                'Dubai.. to Delhi (DEL)',
                '12 Aug - 25 Aug',
                '2 travellers',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentSearchItem(
    String tag,
    String title,
    String date,
    String info,
  ) {
    return Container(
      width: 180.w,
      margin: EdgeInsets.only(right: 12.w),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tag,
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            title,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Text(
            date,
            style: TextStyle(fontSize: 10.sp, color: Colors.grey),
          ),
          Text(
            info,
            style: TextStyle(fontSize: 10.sp, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildHotAndTrending() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'Hot & Trending',
          subtitle: 'We bring exclusive offers for The Club members, daily.',
        ),
        Row(
          children: [
            _buildTab('The Club Select', true),
            _buildTab('The Club Hotel', false),
          ],
        ),
        SizedBox(height: 16.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const TrendingCard(
                title: 'Bali Seascape Beach Club-Rental',
                date: 'Candidasa, Indonesia',
                stats: '4.5',
                imagePath: AppAssets.resort,
                badge: 'Use Maximum Loyalty Points',
              ),
              const TrendingCard(
                title: 'Bali Seascape Beach Club-Rental',
                date: 'Candidasa, Indonesia',
                stats: '4.5',
                imagePath: AppAssets.resort,
                badge: 'Use Maximum Loyalty Points',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTab(String label, bool isSelected) {
    return Container(
      margin: EdgeInsets.only(right: 16.w),
      padding: EdgeInsets.only(bottom: 4.h),
      decoration: BoxDecoration(
        border: isSelected
            ? const Border(bottom: BorderSide(color: Colors.blue, width: 2))
            : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.blue : Colors.black54,
        ),
      ),
    );
  }

  Widget _buildLifeExperience() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'Life Experience®',
          subtitle: 'Discover the magic of a Life Experience.',
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const ExperienceCard(
                title: 'Mediterranean Cruise Experience',
                location: 'Starts 2nd Nov 2025\n8 Days 7 Nights',
                price: '\$699',
                imagePath: AppAssets.cruise,
              ),
              const ExperienceCard(
                title: 'Mediterranean Cruise Experience',
                location: 'Starts 2nd Nov 2025\n8 Days 7 Nights',
                price: '\$699',
                imagePath: AppAssets.cruise,
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              'Explore more',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFlashDeals() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Flash Deals',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Every day, we bring you 3 world-class\nunbeatable hotel offers!',
            style: TextStyle(color: Colors.white70, fontSize: 12.sp),
          ),
          SizedBox(height: 16.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const FlashDealCard(
                  title: 'Millennium Plaza Downtown Hotel, Dubai',
                  subtitle: 'Dubai, United Arab Emirates',
                  rating: '4.5',
                  imagePath: AppAssets.livingRoom,
                ),
                const FlashDealCard(
                  title: 'Millennium Plaza Downtown Hotel, Dubai',
                  subtitle: 'Dubai, United Arab Emirates',
                  rating: '4.5',
                  imagePath: AppAssets.livingRoom,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoBanners() {
    return Column(
      children: [
        _buildBanner(
          AppAssets.sparkleIcon,
          'Apply for your\nTravel visa today',
          'Get Started',
          const Color(0xFFF0F2FF),
        ),
        SizedBox(height: 16.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Image.asset(
            AppAssets.esimBanner,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _buildBanner(
    String iconPath,
    String text,
    String buttonText,
    Color bgColor,
  ) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Image.asset(iconPath, width: 40.r, height: 40.r),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFF5E29CD),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomAppBar(
      color: Colors.white,
      shape: const _SmoothNotchedRectangle(),
      notchMargin: 12,
      elevation: 10,
      child: SizedBox(
        height: 60.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_filled, 'Home', 0),
            _buildNavItem(Icons.confirmation_number_outlined, 'My Trips', 1),
            SizedBox(width: 52.w), // Extra space for the wider scoop
            _buildNavItem(Icons.favorite_border, 'Wishlist', 2),
            _buildNavItem(Icons.person_outline, 'Account', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    final Color color = isSelected
        ? const Color(0xFF5E29CD)
        : const Color(0xFF7D7D7D);
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 26.r),
          SizedBox(height: 2.h),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11.sp,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAB() {
    return Transform.translate(
      offset: Offset(0, 8.h),
      child: GestureDetector(
        onTap: () {},
        child: Image.asset(AppAssets.sparkleIcon, width: 96.r, height: 96.r),
      ),
    );
  }
}

class _SmoothNotchedRectangle extends NotchedShape {
  const _SmoothNotchedRectangle();
  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) return Path()..addRect(host);
    final double notchRadius = guest.width / 2.5; // Wider scoop
    const double s1 = 15.0;
    const double s2 = 1.0;
    final double r = notchRadius;
    final double p1x = guest.center.dx - (r + s2) - s1;
    final double n2 = r + s2;

    return Path()
      ..moveTo(host.left, host.top)
      ..lineTo(p1x, host.top)
      ..relativeQuadraticBezierTo(s1, 0, s1 + s2, s2)
      ..relativeArcToPoint(
        Offset(2 * n2, 0),
        radius: Radius.circular(n2),
        clockwise: false,
      )
      ..relativeQuadraticBezierTo(s2, -s2, s1 + s2, -s2)
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();
  }
}
