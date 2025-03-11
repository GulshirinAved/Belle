import 'package:belle/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/widgets.dart';
import '../../master.dart';

class MasterPortfolioScreen extends StatefulWidget {
  const MasterPortfolioScreen({super.key});

  @override
  State<MasterPortfolioScreen> createState() => _MasterPortfolioScreenState();
}

class _MasterPortfolioScreenState extends State<MasterPortfolioScreen> {
  final _controller = GetIt.instance<MasterPortfolioController>();
  final _imagesController = GetIt.instance<MasterPortfolioImagesController>();
  final _stateController = GetIt.instance<MasterPortfolioStateController>();

  final _scrollController = ScrollController();

  @override
  void initState() {
    _controller.setContext(context);
    _imagesController.setContext(context);
    _stateController.setContext(context);
    _controller.fetchPortfolio();
    _scrollController.addListener(() {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent *
              _controller.offsetPaginationBoundary) {
        _controller.fetchMorePortfolio();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithStyledLeading(
        title: context.loc.portfolio,
        isSliver: false,
      ),
      bottomNavigationBar: StyledBackgroundContainer(
        child: Observer(builder: (context) {
          return ElevatedButtonWithState(
            isLoading: _imagesController.stateManager.isLoading,
            onPressed: () async {
              final tempImages = await _stateController.pickTempPictures();

              if (tempImages.isEmpty) {
                return;
              }
              await _imagesController.addPortfolioImages(photos: tempImages);

              if (!_imagesController.stateManager.isSuccess) {
                return;
              }
              _stateController.saveTempPictures();
              _controller.fetchPortfolio();
            },
            child: Text(context.loc.add_portfolio_images),
          );
        }),
      ),
      body: Observer(builder: (context) {
        if (!_controller.stateManager.isSuccess || _controller.isEmpty) {
          return StateControlWidget(
            props: StateControlWidgetProps(
              isLoading: _controller.stateManager.isLoading,
              isError: _controller.stateManager.isError,
              isEmpty: _controller.isEmpty,
              onError: () {
                _controller.fetchPortfolio();
              },
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            await _controller.fetchPortfolio();
          },
          child: ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingLarge,
              vertical: AppDimensions.paddingMedium,
            ),
            itemBuilder: (context, index) {
              final portfolioItem = _controller.items[index];
              return AspectRatio(
                aspectRatio: 325.0 / 166.0,
                child: StyledContainer(
                  child: Stack(
                    children: [
                      Center(
                        child: CachingImage(portfolioItem.imageUrl),
                      ),
                      Positioned(
                        top: AppDimensions.paddingMedium,
                        left: AppDimensions.paddingMedium,
                        child: IconButton(
                          onPressed: () async {
                            await _imagesController.deletePortfolioImage(
                              id: portfolioItem.id ?? 0,
                            );
                            if (!_imagesController.stateManager.isSuccess) {
                              return;
                            }
                            _controller.fetchPortfolio();
                          },
                          style: IconButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.error,
                            backgroundColor:
                                Theme.of(context).colorScheme.onSurface,
                            shape: const CircleBorder(),
                            visualDensity: VisualDensity.compact,
                          ),
                          icon: const Icon(Icons.delete_forever_outlined),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) {
              return const VSpacer(AppDimensions.paddingMedium);
            },
            itemCount: _controller.items.length,
          ),
        );
      }),
    );
  }
}
