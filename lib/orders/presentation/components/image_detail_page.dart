import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:path_provider/path_provider.dart';

class ImageDetailPage extends StatefulWidget {
  final String imagePath;

  const ImageDetailPage({super.key, required this.imagePath});

  @override
  State<ImageDetailPage> createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  Future<void> _downloadImage() async {
    var imageId = await ImageDownloader.downloadImage(
        "https://raw.githubusercontent.com/wiki/ko2ic/image_downloader/images/flutter.png");
    if (imageId == null) {
      return;
    }
    // final appDocDir = await getApplicationDocumentsDirectory();

    // log("downloading ");

    // final taskId = await FlutterDownloader.enqueue(
    //   url: widget.imagePath,
    //   fileName: 'downloaded_image.png',
    //   savedDir: appDocDir.path,
    //   showNotification: true,
    //   openFileFromNotification: true,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                // Wrap the Image.network widget inside an Expanded widget
                child: Hero(
                  tag: "image_${widget.imagePath.hashCode}",
                  child: Image.network(
                    widget.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 50, // Set the height to 50
                    width: double.infinity,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: ElevatedButton(
                      onPressed: _downloadImage,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      child: const Text(
                        "Telecharger la photo",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
