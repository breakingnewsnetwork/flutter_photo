import 'dart:async';

import 'package:photo_manager/photo_manager.dart';

class AssetProvider {
  Map<AssetPathEntity?, AssetPaging> _dataMap = {};

  AssetPathEntity? _current;

  AssetPathEntity? get current => _current;

  set current(AssetPathEntity? current) {
    _current = current;
    if (_dataMap[current] == null) {
      final paging = AssetPaging(current);
      _dataMap[current] = paging;
    }
  }

  List<AssetEntity> get data => _dataMap[current]?.data ?? [];

  Future<void> loadMore() async {
    final paging = getPaging();
    if (paging != null) {
      await paging.loadMore();
    }
  }

  void clear() {
    _dataMap = {};
    final paging = AssetPaging(current);
    _dataMap[current] = paging;
  }

  AssetPaging? getPaging() => _dataMap[current];

  bool get noMore => getPaging()?.noMore ?? false;

  int get count => data.length;
}

class AssetPaging {
  int page = 0;

  List<AssetEntity> data = [];

  final AssetPathEntity? path;

  final int pageCount;

  bool noMore = false;

  Future<void>? _loading;

  AssetPaging(this.path, {this.pageCount = 50});

  /// Concurrent calls share the in-flight request, so the same page is never
  /// fetched and appended twice (which would shift every following index).
  Future<void> loadMore() {
    return _loading ??= _loadMore().whenComplete(() => _loading = null);
  }

  Future<void> _loadMore() async {
    if (noMore == true) {
      return;
    }
    var data = await path!.getAssetListPaged(page: page, size: pageCount);
    if (data.length == 0) {
      noMore = true;
    }
    page++;
    this.data.addAll(data);
  }
}
