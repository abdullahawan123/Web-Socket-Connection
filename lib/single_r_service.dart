import 'package:signalr_flutter/signalr_flutter.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class SignalRTestService {
  late HubConnection _connection;

  Future<void> start() async {
    print("🔗 Connecting to SignalR…");

    _connection = HubConnectionBuilder()
        .withUrl(
          "http://3.149.165.128:5000/hubs",
          options: HttpConnectionOptions(
            accessTokenFactory: () async {
              return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJwaXZpcm85NjgwQGFtZXRpdGFzLmNvbSIsImp0aSI6ImZmNTYyZTk4LTY0ZjUtNDM4ZC05NDAwLTZiOTU2MDEzMGMzMCIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJwaXZpcm85NjgwQGFtZXRpdGFzLmNvbSIsImlhdCI6MTc2NDA4MzI1MywiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQnVzaW5lc3MiLCJVc2VySWQiOiJiMDU5MWQ4OC01ZTc2LTQ2YTYtYTlmMS1lNTNlY2RjOGE1Y2QiLCJleHAiOjE3NjQwOTc2NTMsImlzcyI6IkdpZ0JpZ2cuQXV0aFNlcnZpY2UiLCJhdWQiOiJHaWdCaWdnLlNlcnZpY2VzIn0.dHJei7lWX4F2obSlfotJ7iwXtEftkvJ9W27hsu8Wef4"; // <- put token
            },
          ),
        )
        .build();

    // Listen for connection state updates
    // _connection.onclose(
    //   (error) {
    //         print("❌ Connection closed: $error");
    //       }
    //       as ClosedCallback,
    // );

    // Listen to your event
    _connection.on("ReceivePrivateMessage", (args) {
      print("📩 EVENT TRIGGERED: ReceivePrivateMessage");
      print("📦 Raw args: $args");

      if (args != null && args.length >= 2) {
        print("👤 Sender: ${args[0]}");
        print("💬 Message: ${args[1]}");
      }
    });

    try {
      await _connection.start();
      print("✅ CONNECTED to SignalR");
    } catch (e) {
      print("❌ Error while connecting: $e");
    }
  }
}
