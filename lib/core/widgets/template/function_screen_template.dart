import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';
import 'package:shopping_app/core/widgets/template/opacity_widget.dart';

// ignore: must_be_immutable
class FunctionScreenTemplate extends StatefulWidget {
  String? title, titleButtonBottom;
  Widget? screen, titleWidget, actionWidget, floatingActionButton, bottomSheet, background, customBottomNavigationBar;
  Function? onBack;
  bool? isShowBottomButton, resizeToAvoidBottomInset, isShowAppBar;
  double? heightBottomSheet;

  FunctionScreenTemplate({
    this.title,
    this.screen,
    this.titleButtonBottom,
    this.isShowBottomButton = true,
    this.bottomSheet,
    this.onBack,
    this.resizeToAvoidBottomInset,
    this.titleWidget,
    this.actionWidget,
    this.floatingActionButton,
    this.isShowAppBar = true,
    this.heightBottomSheet,
    this.background,
    this.customBottomNavigationBar,
  });

  @override
  State<FunctionScreenTemplate> createState() => _FunctionScreenTemplateState();
}

class _FunctionScreenTemplateState extends State<FunctionScreenTemplate> with WidgetsBindingObserver {
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
      if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
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
        if (widget.background != null) Positioned.fill(child: widget.background!),
        _buildScaffold(
          body: widget.screen ?? const SizedBox(),
          appBar: widget.isShowAppBar!,
        ),
        if (isOpacity) const OpacityWidget(),
      ],
    );
  }

  Widget _buildScaffold({required Widget body, required bool appBar}) {
    return Scaffold(
      extendBodyBehindAppBar: widget.background != null,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset ?? true,
      backgroundColor: widget.background != null ? Colors.transparent : AppColors.white,
      appBar: appBar ? AppBarWidget() : null,
      body: body,
      bottomNavigationBar: widget.isShowBottomButton ?? false
          ? (widget.customBottomNavigationBar ?? bottomNavigationBar(titleButtonBottom: widget.titleButtonBottom ?? "Tiếp tục"))
          : widget.bottomSheet ?? const SizedBox.shrink(),
      floatingActionButton: widget.floatingActionButton,
    );
  }

  Widget bottomNavigationBar({String? titleButtonBottom, BoxDecoration? decoration}) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
      height: widget.heightBottomSheet ?? 150,
      decoration: decoration ?? const BoxDecoration(color: Colors.white),
      child: ElevatedButton(onPressed: () {}, child: Text(titleButtonBottom ?? "Tiếp tục")),
    );
  }

  PreferredSizeWidget AppBarWidget() {
    return AppBar(
      title: widget.titleWidget ?? Text(widget.title ?? '', style: AppTextStyles.appbarTitle),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          if (widget.onBack != null) {
            widget.onBack!();
          } else {
            Navigator.pop(context);
          }
        },
      ),
      actions: [if (widget.actionWidget != null) widget.actionWidget!],
    );
  }
}