import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';

// Media source abstraction
class MediaSource {
  final String? url;
  final File? file;

  MediaSource.fromUrl(this.url) : file = null;
  MediaSource.fromFile(this.file) : url = null;

  bool get isVideo {
    final path = url ?? file?.path;
    return path?.endsWith('.mp4') == true || path?.endsWith('.mov') == true;
  }

  bool get isNetworkSource => url != null;
}

class MediaGallery extends StatefulWidget {
  final List<MediaSource> mediaSources;
  final bool autoScroll;
  final Duration autoScrollDuration;

  MediaGallery({
    super.key,
    required this.mediaSources,
    this.autoScroll = true,
    this.autoScrollDuration = const Duration(seconds: 3),
  });

  MediaGallery.fromUrls(
    List<String> urls, {
    super.key,
    bool autoScroll = true,
    Duration autoScrollDuration = const Duration(seconds: 3),
  }) : mediaSources = urls.map((url) => MediaSource.fromUrl(url)).toList(),
       autoScroll = autoScroll,
       autoScrollDuration = autoScrollDuration;

  MediaGallery.fromFiles(
    List<File> files, {
    super.key,
    bool autoScroll = true,
    Duration autoScrollDuration = const Duration(seconds: 3),
  }) : mediaSources = files.map((file) => MediaSource.fromFile(file)).toList(),
       autoScroll = autoScroll,
       autoScrollDuration = autoScrollDuration;

  @override
  State<MediaGallery> createState() => _MediaGalleryState();
}

class _MediaGalleryState extends State<MediaGallery> {
  late PageController _pageController;
  late Timer _autoScrollTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    if (widget.autoScroll && widget.mediaSources.length > 1) {
      _startAutoScroll();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoScrollTimer?.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(widget.autoScrollDuration, (timer) {
      if (_currentPage < widget.mediaSources.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(_currentPage, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  void _nextPage() {
    if (_currentPage < widget.mediaSources.length - 1) {
      _currentPage++;
      _pageController.animateToPage(_currentPage, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      _pageController.animateToPage(_currentPage, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use maximum available width with responsive height
        double containerWidth = constraints.maxWidth;
        double containerHeight = (containerWidth * 800) / 1430; // 1430:800 aspect ratio (width:height)

        // Use full available width to eliminate extra space
        containerWidth = constraints.maxWidth;
        containerHeight = (containerWidth * 900) / 1430; // Increased height for better visibility

        return Center(
          child: Container(
            // width: containerWidth,
            // height: containerHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => SwipeMediaScreen(mediaSources: widget.mediaSources));
                  },
                  child: Container(
                    // width: containerWidth,
                    // height: containerHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: Offset(0, 4))],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: widget.mediaSources.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return buildMediaWidget(
                            widget.mediaSources[index],
                            width: containerWidth,
                            height: containerHeight,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                if (widget.mediaSources.length > 1) ...[
                  // Navigation buttons for desktop/web
                  Positioned(
                    left: 12,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4, offset: Offset(0, 2)),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(Icons.chevron_left, size: 28, color: Colors.white),
                        onPressed: _previousPage,
                        padding: EdgeInsets.all(8),
                        constraints: BoxConstraints(),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4, offset: Offset(0, 2)),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(Icons.chevron_right, size: 28, color: Colors.white),
                        onPressed: _nextPage,
                        padding: EdgeInsets.all(8),
                        constraints: BoxConstraints(),
                      ),
                    ),
                  ),
                  // Page indicators
                  Positioned(
                    bottom: 16,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          widget.mediaSources.length,
                          (index) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            width: _currentPage == index ? 20 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: _currentPage == index ? Colors.white : Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildMediaWidget(MediaSource source, {double? height, double? width}) {
    String url = source.isNetworkSource ? source.url! : source.file!.path;
    if (source.isNetworkSource &&
        !((source.url!.toLowerCase().contains('.png') ||
            source.url!.toLowerCase().contains('.jpeg') ||
            source.url!.toLowerCase().contains('.jpg')))) {
      url = "https://images.weserv.nl/?url=${Uri.encodeComponent(url)}&w=640&h=640&fit=cover&output=webp&q=30&l=9&il&af=auto";
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        // height: height,
        // width: width,
        color: Colors.grey[200],
        child:
            source.isVideo
                ? FutureBuilder<String?>(
                  future: _generateVideoThumbnail(source.isNetworkSource ? source.url! : source.file!.path),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                              strokeWidth: 3,
                            ),
                            SizedBox(height: 8),
                            Text('Loading...', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError || !snapshot.hasData) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.videocam_off, color: Colors.grey[400], size: 48),
                            SizedBox(height: 8),
                            Text('Video preview unavailable', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                          ],
                        ),
                      );
                    } else {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.file(
                            File(snapshot.data!),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(child: Icon(Icons.videocam_off, color: Colors.grey[400], size: 48));
                            },
                          ),
                          Positioned(
                            bottom: 12,
                            right: 12,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), shape: BoxShape.circle),
                              child: Icon(Icons.play_circle_outline, color: Colors.white, size: 28),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                )
                : source.isNetworkSource
                ? Image.network(
                 url,
                  fit: BoxFit.scaleDown,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            value:
                                loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                    : null,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                            strokeWidth: 3,
                          ),
                          SizedBox(height: 8),
                          Text('Loading image...', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                        ],
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.broken_image, color: Colors.grey[400], size: 48),
                          SizedBox(height: 8),
                          Text('Image failed to load', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                        ],
                      ),
                    );
                  },
                )
                : Image.file(
                  source.file!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.broken_image, color: Colors.grey[400], size: 48),
                          SizedBox(height: 8),
                          Text('Image failed to load', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                        ],
                      ),
                    );
                  },
                ),
      ),
    );
  }

  Future<String?> _generateVideoThumbnail(String videoPath) async {
    try {
      final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: videoPath,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.JPEG,
        timeMs: 2000, // Generate thumbnail at 2 seconds
        quality: 75,
      );

      return thumbnailPath;
    } catch (e) {
      print('Error generating thumbnail: $e');
      return null;
    }
  }
}

// Rest of the classes remain the same...
class SwipeMediaScreen extends StatefulWidget {
  final List<MediaSource> mediaSources;
  final int initialIndex;

  SwipeMediaScreen({required this.mediaSources, this.initialIndex = 0});

  @override
  _SwipeMediaScreenState createState() => _SwipeMediaScreenState();
}

class _SwipeMediaScreenState extends State<SwipeMediaScreen> {
  late PageController _pageController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    Fluttertoast.showToast(msg: 'Swipe to see more media', fontSize: 18, backgroundColor: Colors.white12);
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, iconTheme: IconThemeData(color: Colors.white)),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.mediaSources.length,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final source = widget.mediaSources[index];
          return source.isVideo ? VideoPlayerScreen(source: source) : FullScreenImagePreview(source: source);
        },
      ),
    );
  }
}

class FullScreenImagePreview extends StatelessWidget {
  final MediaSource source;

  FullScreenImagePreview({required this.source});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          source.isNetworkSource
              ? Image.network(source.url!, fit: BoxFit.contain)
              : Image.file(source.file!, fit: BoxFit.contain),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final MediaSource source;

  VideoPlayerScreen({required this.source});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.source.isNetworkSource
              ? VideoPlayerController.networkUrl(Uri.parse(widget.source.url!))
              : VideoPlayerController.file(widget.source.file!)
          ..initialize().then((_) {
            setState(() {});
            _controller.setVolume(1.0);
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  void _toggleMute() {
    setState(() {
      if (_isMuted) {
        _controller.setVolume(1.0);
      } else {
        _controller.setVolume(0.0);
      }
      _isMuted = !_isMuted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child:
            _controller.value.isInitialized
                ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      VideoPlayer(_controller),
                      GestureDetector(
                        onTap: _togglePlayPause,
                        child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 50),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 20,
                        child: IconButton(
                          icon: Icon(_isMuted ? Icons.volume_off : Icons.volume_up, color: Colors.white),
                          onPressed: _toggleMute,
                        ),
                      ),
                    ],
                  ),
                )
                : CircularProgressIndicator(),
      ),
    );
  }
}
