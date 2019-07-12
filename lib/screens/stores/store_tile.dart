import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreTile extends StatelessWidget {

  final DocumentSnapshot snapshot;

  StoreTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 100,
            child: Image.network(snapshot.data['image'], fit: BoxFit.cover),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(snapshot.data['title'], textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                Text(snapshot.data['address'], textAlign: TextAlign.start),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.location_on),
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.zero,
                onPressed: () => launch('https://www.google.com/maps/search/?api=1&query=${snapshot.data['latitude']},${snapshot.data['longitude']}'),
              ),
              IconButton(
                icon: Icon(Icons.call), //Text('Ligar'),
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.zero,
                onPressed: () => launch('tel:${snapshot.data['phone']}'),
              ),              
            ],
          )
        ],
      ),
    );
  }

}