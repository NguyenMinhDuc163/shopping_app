import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/init.dart';
import 'package:shopping_app/modules/auth/sign_in/repository/sign_in_repo.dart';
import 'package:shopping_app/modules/cart/screen/cart_screen.dart';
import 'package:shopping_app/modules/home/widget/new_arrival_widget.dart';
import 'package:shopping_app/modules/home/widget/search_bar_delegate.dart';
import 'package:shopping_app/modules/home/widget/sliver_brand_widget.dart';
import 'package:shopping_app/modules/home/widget/sliver_header_widget.dart';
import 'package:shopping_app/modules/home/widget/sliver_row_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();
  static const String routeName = '/HomeScreen';
  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      isShowBottomButton: false,
      isShowAppBar: true,
      isShowDrawer: true,
      leadingWidget: IconButton(
        icon: SvgPicture.asset(IconPath.iconMenu),
        onPressed: () async {
          context.read<SignInRepo>().authLocalDataSource.deleteToken();
          final token =await  context.read<SignInRepo>().authLocalDataSource.getToken();
          print("====> ${token}");
        },
      ),
      actionsWidget: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, CartScreen.routeName),
          child: SvgPicture.asset(IconPath.iconBag),
        ),
      ],
      screen: _Main(),
    );
  }
}

class _Main extends StatefulWidget {
  const _Main();
  @override
  State<_Main> createState() => _MainState();
}

// TODO theme extention
class _MainState extends State<_Main> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverHeaderWidget(),

        SliverPersistentHeader(pinned: true, delegate: SearchBarDelegate()),

        SliverRowWidget(label: 'Choose Brand', value: 'View All'),

        SliverBrandWidget(),

        SliverRowWidget(label: 'New Arrival', value: 'View All'),

        NewArrivalWidget(),
      ],
    );
  }
}
