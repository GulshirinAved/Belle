import 'package:belle/src/core/core.dart';
import 'package:belle/src/widgets/src/state_control_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../../../../theme/theme.dart';
import '../../../../../utils/utils.dart';
import '../../../client.dart';

class ClientExploreSearch extends SearchDelegate<void> {
  final ClientExploreSearchController controller;

  ClientExploreSearch(this.controller) {
    controller.fetchPreviousSearches();
  }

  final debouncer = Debouncer();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Observer(
      builder: (_) {
        if (!controller.stateManager.isSuccess ||
            (controller.stateManager.isSuccess && controller.items.isEmpty)) {
          return Center(
            child: StateControlWidget(
              props: StateControlWidgetProps(
                isLoading: controller.stateManager.isLoading,
                isError: controller.stateManager.isError,
                onError: () {
                  controller.fetchMasters(query);
                },
                isEmpty: controller.items.isEmpty,
                isSliver: false,
              ),
            ),
          );
        }
        return GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: AppDimensions.paddingMedium,
          crossAxisSpacing: AppDimensions.paddingMedium,
          childAspectRatio: 160 / 250,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingLarge,
            vertical: AppDimensions.paddingLarge,
          ),
          children: controller.items.map((value) {
            return MasterGridCardWithBookNowWidget(
              master: value,
              onTap: () {
                context.pushNamed(
                  ClientRoutes.masterInfo,
                  extra: {'master_id': value.masterId},
                );
              },
            );
          }).toList(),
        );
      },
    );
  }

  @override
  void dispose() {
    debouncer.dispose();
    controller.clearData();
    super.dispose();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Observer(builder: (context) {
        return ListView.separated(
          itemCount: controller.previousSearches.length,
          separatorBuilder: (_, __) {
            return const Divider();
          },
          itemBuilder: (context, index) {
            final element = controller.previousSearches[index];
            return ListTile(
              title: Text(element),
              leading: IconButton(
                onPressed: () {
                  controller.removePreviousSearchAt(index);
                },
                icon: const Icon(Icons.close_rounded),
              ),
              trailing: IconButton(
                onPressed: () {
                  query = element;
                  controller.fetchMasters(query);
                  showResults(context);
                },
                icon: const Icon(Icons.arrow_outward),
              ),
            );
          },
        );
      });
    }
    debouncer.debounce(
      isEmpty: query.isEmpty,
      emptyCallback: () {
        controller.clearData();

      },
      successCallback: () {
        controller.fetchMasters(query);
      },
    );
    return Observer(
      builder: (_) {
        if (!controller.stateManager.isSuccess ||
            (controller.stateManager.isSuccess && controller.items.isEmpty)) {
          return Center(
            child: StateControlWidget(
              props: StateControlWidgetProps(
                isLoading: controller.stateManager.isLoading,
                isError: controller.stateManager.isError,
                onError: () {
                  controller.fetchMasters(query);
                },
                isEmpty: controller.items.isEmpty,
                isSliver: false,
              ),
            ),
          );
        }
        return GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: AppDimensions.paddingMedium,
          crossAxisSpacing: AppDimensions.paddingMedium,
          childAspectRatio: 160 / 250,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingLarge,
            vertical: AppDimensions.paddingLarge,
          ),
          children: controller.items.map((value) {
            return MasterGridCardWithBookNowWidget(
              master: value,
              onTap: () {
                context.pushNamed(
                  ClientRoutes.masterInfo,
                  extra: {'master_id': value.masterId},
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
