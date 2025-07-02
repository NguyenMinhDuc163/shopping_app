import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_pad.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';
import 'package:shopping_app/core/widgets/drawer_widget.dart';
import 'package:shopping_app/core/widgets/template/opacity_widget.dart';

// ignore: must_be_immutable
class FunctionScreenTemplate extends StatefulWidget {
  String? title, titleButtonBottom;
  Widget? screen,
      titleWidget,
      actionWidget,
      floatingActionButton,
      background,
      customBottomNavigationBar;
  bool? resizeToAvoidBottomInset;
  bool isShowDrawer, isShowBottomButton, isShowAppBar;
  Widget? leadingWidget;
  List<Widget>? actionsWidget;
  Function? onClickBottomButton,onBack;
  FunctionScreenTemplate({
    this.title,
    this.screen,
    this.titleButtonBottom,
    this.isShowBottomButton = true,
    this.onBack,
    this.resizeToAvoidBottomInset,
    this.titleWidget,
    this.actionWidget,
    this.floatingActionButton,
    this.isShowAppBar = true,
    this.isShowDrawer = false,
    this.background,
    this.customBottomNavigationBar,
    this.leadingWidget,
    this.actionsWidget,
    this.onClickBottomButton
  });

  @override
  State<FunctionScreenTemplate> createState() => _FunctionScreenTemplateState();
}

class _FunctionScreenTemplateState extends State<FunctionScreenTemplate>
    with WidgetsBindingObserver {
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
    return Scaffold(
      extendBodyBehindAppBar: widget.background != null,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset ?? true,
      backgroundColor:
          widget.background != null ? Colors.transparent : AppColors.white,
      appBar: appBar ? appBarWidget() : null,
      drawer: widget.isShowDrawer ? DrawerWidget() : null,
      body: body,
      bottomNavigationBar:
          widget.isShowBottomButton ? (widget.customBottomNavigationBar ??
                  bottomNavigationBar(titleButtonBottom: widget.titleButtonBottom,))
              : const SizedBox.shrink(),
      floatingActionButton: widget.floatingActionButton,
    );
  }

  Widget bottomNavigationBar({String? titleButtonBottom}) {
    return ElevatedButton(
      onPressed: () {
          widget.onClickBottomButton?.call();
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.lavenderColor),
        padding: WidgetStateProperty.all(AppPad.v24),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide.none,
          ),
        ),
      ),
      child: Text(titleButtonBottom ?? "Tiếp tục", style: AppTextStyles.button),
    );
  }

  PreferredSizeWidget appBarWidget() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading:
          widget.leadingWidget ??
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (widget.onBack != null) {
                widget.onBack!();
              } else {
                Navigator.of(context).maybePop();
              }
            },
          ),
      title:
          widget.titleWidget ??
          (widget.title != null
              ? Text(widget.title!, style: AppTextStyles.text)
              : null),
      centerTitle: true,
      actions: widget.actionsWidget,
    );
  }
}
