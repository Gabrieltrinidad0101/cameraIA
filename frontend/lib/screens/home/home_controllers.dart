// ignore: library_prefixes
import 'package:frontend/constants/socket_path_url.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeController {
  getCamerasVideos(cb) async {
    List listOfFrames = [];
    String url = await getSocketUrl();
    IO.Socket socket;
    socket = IO.io(
        url,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders(
                {'Connection': 'upgrade', 'Upgrade': 'websocket'}) // optional
            .build());
    socket.connect();
    socket.emit("cameras_video", "start");
    socket.on("get_cameras_video", (frames) {
      cb(frames);
    });
  }
}
