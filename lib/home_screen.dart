import 'dart:convert';
import 'package:api_test/Models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PhotosModel> PhotoList = [];
  Future<List<PhotosModel>> getPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    print(data);

    if (response.statusCode == 200) {
      for (Map i in data) {
        PhotosModel photosModel =
            PhotosModel(title: i['title'], url: i['url'], id: i['id']);
        PhotoList.add(photosModel);
      }
      return PhotoList;
    } else {
      return PhotoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(
                future: getPhotos(),
                builder: ((context, AsyncSnapshot<List<PhotosModel>> snapshot) {
                  return ListView.builder(
                    itemCount: PhotoList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              snapshot.data![index].url.toString()),
                        ),
                        subtitle: Text(snapshot.data![index].title.toString()),
                        title:
                            Text('Id: ' + snapshot.data![index].id.toString()),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
