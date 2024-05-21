import 'package:palate_prestige/socketIO/socket_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  void sendMessage(String message, String name) {
    _socketClient.emit('sendMessage', {'message': message, 'namee': name});
  }


  void newOrder(Map<String, dynamic> orderJson) {
    _socketClient.emit('newOrder', orderJson);

     //When an event recieved from server, data is added to the stream
    _socketClient.on('fetchOrder', (data) =>{
      print(data)
    });
    

  }

  void fetchData() {
    _socketClient.on('fetchOrder', (data) {
      print(data);
    });
  }
}
