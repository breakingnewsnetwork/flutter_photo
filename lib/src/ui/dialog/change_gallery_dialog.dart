import 'package:flutter/material.dart';
import 'package:photo/src/entity/options.dart';
import 'package:photo/src/provider/i18n_provider.dart';
import 'package:photo_manager/photo_manager.dart';

class ChangeGalleryDialog extends StatefulWidget {
  final List<AssetPathEntity>? galleryList;
  final I18nProvider? i18n;
  final Options? options;

  const ChangeGalleryDialog({
    Key? key,
    this.galleryList,
    this.i18n,
    this.options,
  }) : super(key: key);

  @override
  _ChangeGalleryDialogState createState() => _ChangeGalleryDialogState();
}

class _ChangeGalleryDialogState extends State<ChangeGalleryDialog> {

  List<int> photosCount = [];

  @override
  void initState() {
    super.initState();
    photosCount = List.filled(widget.galleryList!.length, 0);
    getPhotosCount();
  }

  Future getPhotosCount() async {
    for (var i = 0; i < widget.galleryList!.length; i++) {
      var entity = widget.galleryList![i];
      var count = await entity.assetCountAsync;
      photosCount[i] = count;
    }

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: _buildItem,
        itemCount: widget.galleryList!.length,
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    var entity = widget.galleryList![index];
    String? text;

    if (entity.isAll) {
      text = widget.i18n?.getAllGalleryText(widget.options);
    }

    text = text ?? entity.name;

    return TextButton(
      child: ListTile(
        title: Text("$text (${photosCount[index]})"),
      ),
      onPressed: () {
        Navigator.pop(context, entity);
      },
    );
  }
}
