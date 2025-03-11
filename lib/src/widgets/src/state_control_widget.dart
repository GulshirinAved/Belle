import 'package:belle/src/core/core.dart';
import 'package:belle/src/theme/view/config/theme_config.dart';
import 'package:belle/src/widgets/src/spacers/spacers.dart';
import 'package:flutter/material.dart';

// import '../widgets.dart';

class StateControlWidgetProps {
  final bool isLoading;
  final bool isError;
  final bool isEmpty;
  final bool isSliver;
  final VoidCallback? onError;
  final String? emptyTitle;
  final IconData? emptyIcon;

  const StateControlWidgetProps({
    this.isLoading = false,
    this.isError = false,
    this.isEmpty = false,
    this.isSliver = false,
    this.onError,
    this.emptyIcon,
    this.emptyTitle,
  });
}

class StateControlWidget extends StatelessWidget {
  final StateControlWidgetProps props;

  const StateControlWidget({
    super.key,
    required this.props,
  });

  @override
  Widget build(BuildContext context) {
    if (props.isSliver) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: _widget(),
      );
    }
    return _widget();
  }

  Widget _widget() {
    if (props.isLoading) {
      return const StateLoadingWidget();
    }
    if (props.isError) {
      return StateErrorWidget(onError: props.onError);
    }
    if (props.isEmpty) {
      return StateEmptyWidget(
        title: props.emptyTitle,
        icon: props.emptyIcon,
      );
    }
    return const SizedBox();
  }
}

class StateLoadingWidget extends StatelessWidget {
  const StateLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

class StateErrorWidget extends StatelessWidget {
  final VoidCallback? onError;

  const StateErrorWidget({super.key, required this.onError});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Icon(
                Icons.airplanemode_inactive_rounded,
                color: Theme.of(context).colorScheme.error,
                size: 150.0,
              ),
            ),
            const VSpacer(AppDimensions.paddingLarge),
            Center(
              child: Text(
                context.loc.error_occurred,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const VSpacer(AppDimensions.paddingLarge),
            ElevatedButton.icon(
              onPressed: onError,
              label: Text(context.loc.retry),
              icon: const Icon(Icons.refresh_rounded, color: AppColors.fullWhite,),
            ),
          ],
        ),
      ),
    );
  }
}

class StateEmptyWidget extends StatelessWidget {
  final String? title;
  final IconData? icon;
  const StateEmptyWidget({super.key, this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(
              icon,
              size: 150.0,
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          Text(
            title ?? context.loc.empty,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
