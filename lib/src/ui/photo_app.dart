import 'package:flutter/material.dart';
import 'package:photo/src/provider/asset_provider.dart';

import 'package:photo_manager/photo_manager.dart';

import 'package:photo/src/entity/options.dart';
import 'package:photo/src/provider/config_provider.dart';
import 'package:photo/src/provider/i18n_provider.dart';
import 'package:photo/src/ui/page/photo_main_page.dart';

class PhotoApp extends StatelessWidget {
  final Options options;
  final I18nProvider provider;
  final List<AssetPathEntity> photoList;
  final List<AssetEntity> pickedAssetList;
  final AssetProvider assetProvider;
  const PhotoApp({
    Key key,
    this.options,
    this.provider,
    this.photoList,
    this.pickedAssetList,
    this.assetProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pickerProvider = PhotoPickerProvider(
      provider: provider,
      options: options,
      pickedAssetList: pickedAssetList,
      assetProvider: assetProvider,
      key: ObjectKey('photo-app-provider'),
      child: PhotoMainPage(
        key:  ObjectKey('photo-app-main-page'),
        onClose: (List<AssetEntity> value) {
          Navigator.pop(context, value);
        },
        options: options,
        photoList: photoList,
      ),
    );

    return pickerProvider;
  }
}
