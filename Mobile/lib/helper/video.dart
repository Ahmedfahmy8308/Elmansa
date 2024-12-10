import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the video controller (for example, a local video asset)
    _controller = VideoPlayerController.asset('assets/videos/v1.mp4')
      ..setLooping(true) // Optional: loop the video
      ..setVolume(1.0); // Optional: set the volume (0.0 to 1.0)

    // Initialize the controller and video player
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); // Dispose the controller when no longer needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Video Player')),
      body: Center(
        child: FutureBuilder<void>(
          future: _initializeVideoPlayerFuture, // Wait for video initialization
          builder: (context, snapshot) {
            // If the video is not yet initialized, show a loading spinner
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              );
            } else {
              return CircularProgressIndicator(); // Show loading until video is ready
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Play/Pause the video when the button is pressed
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
