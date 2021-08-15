part of '../photo_main_page.dart';

class _BottomWidget extends StatefulWidget {
  final ValueChanged<AssetPathEntity>? onGalleryChange;

  final Options? options;

  final I18nProvider? provider;

  final SelectedProvider? selectedProvider;

  final String galleryName;

  final GalleryListProvider? galleryListProvider;
  final VoidCallback? onTapPreview;

  const _BottomWidget({
    Key? key,
    this.onGalleryChange,
    this.options,
    this.provider,
    this.selectedProvider,
    this.galleryName = "",
    this.galleryListProvider,
    this.onTapPreview,
  }) : super(key: key);

  @override
  __BottomWidgetState createState() => __BottomWidgetState();
}

class __BottomWidgetState extends State<_BottomWidget> {
  Options? get options => widget.options;

  I18nProvider? get i18nProvider => widget.provider;

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontSize: 14.0);
    const textPadding = const EdgeInsets.symmetric(horizontal: 16.0);
    return Container(
      color: options!.themeColor,
      child: SafeArea(
        bottom: true,
        top: false,
        child: Container(
          height: 52.0,
          child: Row(
            children: <Widget>[
              TextButton(
                onPressed: () async {
                  await _showGallerySelectDialog();
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.transparent;
                        return null; // Defer to the widget's default.
                      }),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 44.0,
                  padding: textPadding,
                  child: Text(
                    widget.galleryName,
                    style: textStyle.copyWith(color: options!.textColor),
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              TextButton(
                onPressed: widget.onTapPreview,
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(options!.textColor ?? Colors.white),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.transparent;
                        if (states.contains(MaterialState.disabled))
                          return options!.disableColor;
                        if (states.contains(MaterialState.disabled))
                          return options!.disableColor;
                        return null; // Defer to the widget's default.
                      }),
                ),
                child: Container(
                  height: 44.0,
                  alignment: Alignment.center,
                  child: Text(
                    i18nProvider!.getPreviewText(
                        options, widget.selectedProvider),
                    style: textStyle,
                  ),
                  padding: textPadding,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showGallerySelectDialog() async {
    var result = await showModalBottomSheet(
      context: context,
      builder: (ctx) =>
          ChangeGalleryDialog(
            galleryList: widget.galleryListProvider!.galleryPathList,
            i18n: i18nProvider,
            options: options,
          ),
    );

    if (result != null) widget.onGalleryChange?.call(result);
  }
}
