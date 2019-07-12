import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:virtual_store/widgets/gradient_background_color.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

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
                height: 400,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
                )
              )
            )
          : SliverStaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              staggeredTiles: snapshot.data.documents.map((document) => StaggeredTile.count(document.data['x'], document.data['y'])).toList(),
              children: snapshot.data.documents.map((document) => FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: document.data['image'],
                  fit: BoxFit.cover,
                )).toList(),
            );
      },
    );

    Widget _buildBody() => CustomScrollView(
      slivers: <Widget>[
        _buildSliverAppBar(), 
        _buildFutureBuilder()
      ],
    );


    return Stack(
      children: <Widget>[
        GradientBackgroundColor(),
        _buildBody()
      ],
    );
  }
}
