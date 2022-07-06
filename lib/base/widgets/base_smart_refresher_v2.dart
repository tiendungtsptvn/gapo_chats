import 'package:base_flutter/theme/colors.dart';
import 'package:base_flutter/theme/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BaseSmartFresherV2 extends StatefulWidget {
  final Widget child;
  final Future Function()? onRefresh;
  final Future Function()? onLoadMore;

  const BaseSmartFresherV2({
    Key? key,
    required this.child,
    this.onRefresh,
    this.onLoadMore,
  }) : super(key: key);

  @override
  BaseSmartFresherV2State createState() => BaseSmartFresherV2State();
}

class BaseSmartFresherV2State extends State<BaseSmartFresherV2> {
  RefreshController? _refreshController;

  @override
  void initState() {
    super.initState();
    if (enableSmartRefresher) {
      _refreshController = RefreshController();
    }
  }

  @override
  void dispose() {
    _refreshController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!enableSmartRefresher) return widget.child;
    bool isRtl = Directionality.of(context) == TextDirection.rtl;
    return SmartRefresher(
      controller: _refreshController!,
      header: const ClassicHeader(
          refreshingIcon: CupertinoActivityIndicator(color: GPColor.workPrimary),
          refreshingText: "",
          releaseText: "",
          idleText: "",
          idleIcon: Icon(Icons.arrow_downward),
          completeText: "",
          completeIcon: Icon(Icons.done, color: GPColor.workPrimary,),
          releaseIcon: CupertinoActivityIndicator(color: GPColor.workPrimary)),
      footer: ClassicFooter(
        iconPos: isRtl ? IconPosition.right : IconPosition.left,
        loadingIcon: const CupertinoActivityIndicator(color: GPColor.workPrimary),
        loadingText: "Loading",
        textStyle: textStyle(GPTypography.headingMedium)!.merge(
          const TextStyle(color: GPColor.workPrimary)
        ),
        idleText: "",
        idleIcon: null,
      ),
      onRefresh: onRefresh,
      onLoading: onLoadMore,
      enablePullDown: widget.onRefresh != null,
      enablePullUp: widget.onLoadMore != null,
      child: widget.child,
    );
  }

  bool get enableSmartRefresher {
    return widget.onRefresh != null || widget.onLoadMore != null;
  }

  void onRefresh() async {
    await widget.onRefresh?.call();
    _refreshController?.refreshCompleted();
  }

  void onLoadMore() async {
    await widget.onLoadMore?.call();
    _refreshController?.loadComplete();
  }
}
