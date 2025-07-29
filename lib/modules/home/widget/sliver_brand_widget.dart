import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/constants/mock_data.dart';
import 'package:shopping_app/modules/brand/screen/brain_screen.dart';

import '../../../init.dart';

class SliverBrandWidget extends StatefulWidget {
  const SliverBrandWidget({super.key});

  @override
  State<SliverBrandWidget> createState() => _SliverBrandWidgetState();
}

class _SliverBrandWidgetState extends State<SliverBrandWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 60,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: AppPad.h16,
          itemCount: MockData.brands.length,
          separatorBuilder: (context, index) => SizedBox(width: 12),
          itemBuilder: (context, index) {
            final brand = MockData.brands[index];
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, BrainScreen.routeName, arguments: brand),
              child: Container(
                padding: AppPad.h16v8,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: AppBorderRadius.a16,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: AppPad.a14,
                      decoration: BoxDecoration(
                        borderRadius: AppBorderRadius.a12,
                        color: Colors.white,
                      ),
                      child: SvgPicture.asset(brand['icon']),
                    ),
                    SizedBox(width: 8),
                    Text(
                      brand['name'],
                      style: AppTextStyles.textHeader3.copyWith(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
