import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo/photo.dart';
import 'package:photo_manager/photo_manager.dart';

class PickedExample extends StatefulWidget {
  @override
  _PickedExampleState createState() => _PickedExampleState();
}

class _PickedExampleState extends State<PickedExample> {
  List<AssetEntity> picked = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cross Picked asset"),
      ),
      body: Column(
        children: <Widget>[
          TextButton.icon(
              onPressed: _pickAsset, icon: Icon(Icons.assignment), label: Text("Pick asset")),
          ListTile(
            title: Text("picked asset count = ${picked.length}"),
          ),
        ],
      ),
    );
  }

  void _pickAsset() async {
    final result = await PhotoPicker.pickAsset(
      context: context,
      pickedAssetList: picked,
      assetProvider: AssetProvider(),
    );
    if (result != null && result.isNotEmpty) {
      picked.clear();
      picked.addAll(result);
      if (mounted) {
        setState(() {});
      }
    }
  }
}
