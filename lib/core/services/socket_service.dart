// ignore_for_file: avoid_print

import 'package:esl/core/networks/api_endpoints.dart';
import 'package:injectable/injectable.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

@singleton
class SocketService {
  late io.Socket socket;
  static String serverUrl = baseUrl.replaceAll('/api', '');

  void initSocket({String? accessToken}) {
    final options = <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'reconnection': true,
      'reconnectionAttempts': 5,
      'reconnectionDelay': 3000,
    };

    if (accessToken != null) {
      options['extraHeaders'] = {'Cookie': 'accessToken=$accessToken'};
    }

    socket = io.io(serverUrl, options);
    _setupSocketListeners();
  }

  void _setupSocketListeners() {
    socket.on('connect', (_) {
      print('Socket connected');
    });
    socket.onConnect((_) {
      print('Socket connected');
    });

    socket.onError((error) {
      print('Socket error: $error');
    });

    socket.onConnectError((error) {
      print('Socket connection error: $error');
    });

    socket.onDisconnect((_) {
      print('Socket disconnected');
    });
  }

  void connect() {
      print('Socket connecting');
      if (socket.connected) {
        print('Socket connected');
      }else{
        print('Socket not connected connecting... ${socket.connected}');
        socket.connect();
        print('Socket not connected connecting... ${socket.connected}');
      }
  }

  void emit(String event, dynamic data) {
      socket.emit(event, data);
  }

  void on(String event, Function(dynamic) handler) {
    socket.on(event, handler);
  }

  void off(String event) {
    socket.off(event);
  }

  void dispose() {
    socket.dispose();
  }

  void sendMessage({required String content, required String sessionId}) {
    final payload = {'content': content, 'sessionId': sessionId};
    emit('new:message', payload);
  }
}
