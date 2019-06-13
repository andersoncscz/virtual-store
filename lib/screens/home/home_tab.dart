import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBackground() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: [
                Color.fromARGB(255, 211, 118, 130),
                Color.fromARGB(255, 253, 181, 168)
              ])),
        );

    Widget _buildSliverAppBar() => SliverAppBar(
          floating: true,
          snap: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('Novidades'),
            centerTitle: true,
          ),
        );

    Widget _buildFutureBuilder() => FutureBuilder<QuerySnapshot>(
          future: Firestore.instance
              .collection('home')
              .orderBy('priority-position')
              .getDocuments(),
          builder: (context, snapshot) {
            //Renders a Progress indicator while data haven't arrived yet.
            return !snapshot.hasData 
              ? SliverToBoxAdapter(
                    child: Container(
                        height: 200,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white))))
              : SliverStaggeredGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  staggeredTiles: snapshot.data.documents.map((document) => StaggeredTile.count(document.data['x'], document.data['y'])).toList(),
                  children: snapshot.data.documents.map((document) => FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: document.data['image'],
                      fit: BoxFit.cover,
                    )).toList(),
                );
          },
        );

    return Stack(
      children: <Widget>[
        _buildBodyBackground(),
        CustomScrollView(
          slivers: <Widget>[_buildSliverAppBar(), _buildFutureBuilder()],
        )
      ],
    );
  }
}
