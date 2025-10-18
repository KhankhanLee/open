import 'package:flutter/material.dart';

/// 반응형 레이아웃을 위한 유틸리티 클래스
class ResponsiveLayout {
  /// 화면 크기 기준
  static const double mobileMaxWidth = 600;
  static const double tabletMaxWidth = 1024;

  /// 현재 화면이 모바일인지 확인
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileMaxWidth;
  }

  /// 현재 화면이 태블릿인지 확인
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileMaxWidth && width < tabletMaxWidth;
  }

  /// 현재 화면이 데스크탑인지 확인
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= tabletMaxWidth;
  }

  /// 화면 크기에 따라 다른 값을 반환
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context)) {
      return desktop ?? tablet ?? mobile;
    } else if (isTablet(context)) {
      return tablet ?? mobile;
    }
    return mobile;
  }

  /// 반응형 패딩
  static EdgeInsets padding(BuildContext context) {
    return EdgeInsets.all(
      value(context, mobile: 16.0, tablet: 24.0, desktop: 32.0),
    );
  }

  /// 반응형 수평 패딩
  static EdgeInsets horizontalPadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: value(context, mobile: 16.0, tablet: 24.0, desktop: 32.0),
    );
  }

  /// 반응형 수직 패딩
  static EdgeInsets verticalPadding(BuildContext context) {
    return EdgeInsets.symmetric(
      vertical: value(context, mobile: 8.0, tablet: 12.0, desktop: 16.0),
    );
  }

  /// 그리드 컬럼 개수
  static int gridColumns(BuildContext context) {
    return value(context, mobile: 2, tablet: 3, desktop: 4);
  }

  /// 최대 컨텐츠 너비 (데스크탑에서 너무 넓어지지 않도록)
  static double maxContentWidth(BuildContext context) {
    return value(context, mobile: double.infinity, tablet: 800, desktop: 1200);
  }
}

/// 반응형 컨테이너 위젯
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final EdgeInsetsGeometry? padding;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? ResponsiveLayout.maxContentWidth(context),
        ),
        padding: padding ?? ResponsiveLayout.padding(context),
        child: child,
      ),
    );
  }
}

/// 반응형 그리드 뷰
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double? maxWidth;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.spacing = 16.0,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final columns = ResponsiveLayout.gridColumns(context);

    return ResponsiveContainer(
      maxWidth: maxWidth,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
          childAspectRatio: 1,
        ),
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
      ),
    );
  }
}

/// 반응형 Row/Column 자동 전환
class ResponsiveRowColumn extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double spacing;

  const ResponsiveRowColumn({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.spacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    if (isMobile) {
      return Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: _addSpacing(children, spacing, Axis.vertical),
      );
    } else {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: _addSpacing(children, spacing, Axis.horizontal),
      );
    }
  }

  List<Widget> _addSpacing(List<Widget> children, double spacing, Axis axis) {
    if (children.isEmpty) return children;

    final List<Widget> spacedChildren = [];
    for (int i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i < children.length - 1) {
        spacedChildren.add(
          axis == Axis.horizontal
              ? SizedBox(width: spacing)
              : SizedBox(height: spacing),
        );
      }
    }
    return spacedChildren;
  }
}
