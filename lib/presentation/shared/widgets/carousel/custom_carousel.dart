import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/presentation/shared/widgets/carousel/carousel_page_indicator.dart';

class CustomCarousel extends StatefulWidget {
  final List<Widget> children;
  final ValueChanged<int>? onPageChanged;

  const CustomCarousel({super.key, required this.children, this.onPageChanged});

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  final ScrollController _controller = ScrollController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.hasClients) {
        final page =
            (_controller.offset / _controller.position.viewportDimension)
                .round();
        if (page != _currentPage) {
          setState(() => _currentPage = page);
          widget.onPageChanged?.call(page);
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .center,
      spacing: AppSpacing.spacingS,
      children: [
        Container(
          margin: .only(bottom: AppSpacing.spacingM),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                controller: _controller,
                scrollDirection: .horizontal,
                physics: const PageScrollPhysics(),
                child: Row(
                  crossAxisAlignment: .start,
                  children: widget.children
                      .map(
                        (child) => Container(
                          padding: .symmetric(horizontal: AppSpacing.spacingS),
                          width: constraints.maxWidth,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: AppBorders.mediumBorderRadius,
                          ),
                          child: child,
                        ),
                      )
                      .toList(),
                ),
              );
            },
          ),
        ),
        CarouselPageIndicator(
          indicatorsCount: widget.children.length,
          currentIndex: _currentPage,
        ),
      ],
    );
  }
}
