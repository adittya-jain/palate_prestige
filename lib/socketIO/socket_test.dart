import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:palate_prestige/socketIO/socket_methods.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class SocketPage extends StatefulWidget {
  @override
  _SocketTestState createState() => _SocketTestState();
}

class _SocketTestState extends State<SocketPage> {
  

  final SocketMethods _socketMethods = SocketMethods();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebSocket Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (()=> _socketMethods.sendMessage("Hey there", "aditya" ) ),
          child: Text('Send Data'),
        ),
      ),
    );
  }

  

  // ... (rest of your widget code)
}
