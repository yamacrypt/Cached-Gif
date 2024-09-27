import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cached_network_gif_provider.dart';

/// 一度だけ再生するGif
class CachedGif extends StatelessWidget {
  CachedGif(
    this.path, {
    this.width,
    this.height,
    this.color,
    this.fit,
    this.onFinish,
    super.key,
  });
  final String path;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  bool isFinished = false;
  final void Function()? onFinish;
  @override
  Widget build(BuildContext context) {
    final _cachedNetworkGifProvider = CachedNetworkGifProvider(path);
    return Image(
      image: _cachedNetworkGifProvider,
      width: width,
      height: height,
      fit: fit,
      color: color,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        final frameCount = _cachedNetworkGifProvider.frameCount;
        if (frame != null && frameCount != null && frame >= frameCount - 1) {
          if (!isFinished) {
            onFinish?.call();
            isFinished = true;
          }
          return const SizedBox.shrink();
        }
        return child;
      },
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.error);
      },
    );
  }
}
