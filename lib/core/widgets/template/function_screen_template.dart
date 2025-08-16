import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/constants/icon_path.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_pad.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';
import 'package:shopping_app/core/widgets/template/button_widget.dart';
import 'package:shopping_app/core/widgets/template/opacity_widget.dart';
import 'package:shopping_app/core/widgets/will_unfocus_form_scope.dart';

// ignore: must_be_immutable
class FunctionScreenTemplate extends StatefulWidget {
  String? title, titleButtonBottom;
  Widget? screen,
      titleWidget,
      floatingActionButton,
      background,
      customBottomNavigationBar;
  bool resizeToAvoidBottomInset;
  bool isShowDrawer, isShowBottomButton, isShowAppBar;
  Widget? leadingWidget;
  List<Widget>? actionsWidget;
  Function? onClickBottomButton, onBack;
  Color? backgroundColor;

  FunctionScreenTemplate({
    super.key,
    this.title,
    this.screen,
    this.titleButtonBottom,
    this.isShowBottomButton = true,
    this.onBack,
    this.resizeToAvoidBottomInset = true,
    this.titleWidget,
    this.floatingActionButton,
    this.isShowAppBar = true,
    this.isShowDrawer = false,
    this.background,
    this.customBottomNavigationBar,
    this.leadingWidget,
    this.actionsWidget,
    this.onClickBottomButton,
    this.backgroundColor,
  });

  @override
  State<FunctionScreenTemplate> createState() => _FunctionScreenTemplateState();
}

class _FunctionScreenTemplateState extends State<FunctionScreenTemplate>
    with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isOpacity = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    try {
      if (state == AppLifecycleState.paused ||
          state == AppLifecycleState.inactive) {
        setState(() => isOpacity = true);
      } else if (state == AppLifecycleState.resumed) {
        setState(() => isOpacity = false);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.background != null)
          Positioned.fill(child: widget.background!),
        _buildScaffold(
          body: widget.screen ?? const SizedBox(),
          appBar: widget.isShowAppBar,
        ),
        if (isOpacity) const OpacityWidget(),
      ],
    );
  }

  Widget _buildScaffold({required Widget body, required bool appBar}) {
    return WillUnfocusFormScope(
      child: Scaffold(
        extendBodyBehindAppBar: widget.background != null,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        backgroundColor:
            widget.background != null
                ? Colors.transparent
                : widget.backgroundColor ?? AppColors.white,
        appBar: appBar ? appBarWidget() : null,
        body: SafeArea(child: body),
        bottomNavigationBar:
            widget.isShowBottomButton
                ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    (widget.customBottomNavigationBar ??
                        ButtonWidget(
                          title: widget.titleButtonBottom,
                          padding: AppPad.v24,
                          onPressed: widget.onClickBottomButton ?? () {},
                        )),
                  ],
                )
                : null,
        floatingActionButton: widget.floatingActionButton,
      ),
    );
  }

  // TODO tang kich thuoc nut back
  PreferredSizeWidget appBarWidget() {
    return AppBar(
      backgroundColor: widget.backgroundColor ?? AppColors.white,
      toolbarHeight: 55,
      elevation: 0,
      leading: Padding(
        padding: AppPad.a8,
        child: CircleAvatar(
          backgroundColor: AppColors.lightGray,
          child:
              widget.leadingWidget ??
              (widget.isShowDrawer
                  ? IconButton(
                    icon: SvgPicture.asset(IconPath.iconMenu),
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                  )
                  : IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      if (widget.onBack != null) {
                        widget.onBack!();
                      } else {
                        Navigator.of(context).maybePop();
                      }
                    },
                  )),
        ),
      ),
      title:
          widget.titleWidget ??
          (widget.title != null
              ? Text(widget.title!, style: AppTextStyles.textHeader3)
              : null),
      centerTitle: true,
      actions:
          widget.actionsWidget
              ?.map(
                (e) => Padding(
                  padding: AppPad.a8,
                  child: CircleAvatar(
                    backgroundColor: AppColors.lightGray,
                    child: e,
                  ),
                ),
              )
              .toList(),
    );
  }
}
