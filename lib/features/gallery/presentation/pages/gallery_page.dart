import 'package:esl/core/loaders/loading_widget.dart';
import 'package:esl/features/gallery/presentation/blocs/gallery_bloc.dart';
import 'package:esl/features/home/presentation/widgets/grouped_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    if (!_isInitialized) {
      context.read<GalleryBloc>().add(const GetGallery());
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _isInitialized = false;
    super.dispose();
  }

  /// Refresh gallery data
  Future<void> _refreshGallery() async {
    context.read<GalleryBloc>().add(const RefreshGallery());
    // Wait a bit to ensure refresh is triggered
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshGallery,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            BlocBuilder<GalleryBloc, GalleryState>(
              builder: (context, state) {
                if (state is GalleryLoading) {
                  return const Center(child: Column(children: [LoadingWidget()]));
                } else if (state is GalleryLoaded) {
                  return Column(
                    children: state.galleries.map((gallery) {
                      final isFirstIndex =
                          state.galleries.first.category == gallery.category;
                      return GroupedImage(
                        category: gallery.category,
                        isExpanded: isFirstIndex,
                        links: gallery.items.map((e) => e.mediaUrl).toList(),
                      );
                    }).toList(),
                  );
                } else if (state is GalleryError) {
                  return Center(child: Text(state.message));
                } else if (state is GalleryEmpty) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
