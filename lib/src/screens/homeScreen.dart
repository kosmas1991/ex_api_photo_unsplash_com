import 'package:flutter/material.dart';
import '../models/images.dart';
import '../services/services.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //
  bool _loading = true;
  List<Result> _results;
  String search = 'world';
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = search;
    Services.getImages(search).then((results) {
      setState(() {
        _results = results;
        _loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
      appBar: AppBar(
        title: Text(_loading? 'Loading...': 'Images about $search'),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  hintStyle: TextStyle(color: Colors.black38),
                  hintText: 'World'
                ),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  setState(() {
                    search = value;
                    Services.getImages(search).then((results) {
                      setState(() {
                        _results = results;
                        _loading = false;
                      });
                    });
                  });
                },
                controller: controller,
              ),
            ),
            Flexible(
              flex: 9,
              child: ListView.builder(
                itemCount: _results == null? 0 : _results.length,
                itemBuilder: (context, index) {
                  var result = _results[index];
                  return CachedNetworkImage(
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    imageUrl: result.urls.small,
                  );
                },),
            ),
          ],
        )
      ),
    );
  }
}
