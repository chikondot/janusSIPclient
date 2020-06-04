import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

enum GroovinListTileStyle {
  /// Use a title font that's appropriate for a [GroovinListTile] in a list.
  list,

  /// Use a title font that's appropriate for a [GroovinListTile] that appears in a [Drawer].
  drawer,
}

/// An inherited widget that defines color and style parameters for [GroovinListTile]s
/// in this widget's subtree.
///
/// Values specified here are used for [GroovinListTile] properties that are not given
/// an explicit non-null value.
///
/// The [Drawer] widget specifies a tile theme for its children which sets
/// [style] to [GroovinListTileStyle.drawer].
class ListTileTheme extends InheritedWidget {
  /// Creates a list tile theme that controls the color and style parameters for
  /// [GroovinListTile]s.
  const ListTileTheme({
    Key key,
    this.dense = false,
    this.style = GroovinListTileStyle.list,
    this.selectedColor,
    this.iconColor,
    this.textColor,
    this.contentPadding,
    Widget child,
  }) : super(key: key, child: child);

  /// Creates a list tile theme that controls the color and style parameters for
  /// [GroovinListTile]s, and merges in the current list tile theme, if any.
  ///
  /// The [child] argument must not be null.
  static Widget merge({
    Key key,
    bool dense,
    GroovinListTileStyle style,
    Color selectedColor,
    Color iconColor,
    Color textColor,
    EdgeInsetsGeometry contentPadding,
    @required Widget child,
  }) {
    assert(child != null);
    return Builder(
      builder: (BuildContext context) {
        final ListTileTheme parent = ListTileTheme.of(context);
        return ListTileTheme(
          key: key,
          dense: dense ?? parent.dense,
          style: style ?? parent.style,
          selectedColor: selectedColor ?? parent.selectedColor,
          iconColor: iconColor ?? parent.iconColor,
          textColor: textColor ?? parent.textColor,
          contentPadding: contentPadding ?? parent.contentPadding,
          child: child,
        );
      },
    );
  }

  /// If true then [GroovinListTile]s will have the vertically dense layout.
  final bool dense;

  /// If specified, [style] defines the font used for [GroovinListTile] titles.
  final GroovinListTileStyle style;

  /// If specified, the color used for icons and text when a [GroovinListTile] is selected.
  final Color selectedColor;

  /// If specified, the icon color used for enabled [GroovinListTile]s that are not selected.
  final Color iconColor;

  /// If specified, the text color used for enabled [GroovinListTile]s that are not selected.
  final Color textColor;

  /// The tile's internal padding.
  ///
  /// Insets a [GroovinListTile]'s contents: its [leading], [title], [subtitle],
  /// and [trailing] widgets.
  final EdgeInsetsGeometry contentPadding;

  /// The closest instance of this class that encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// ListTileTheme theme = ListTileTheme.of(context);
  /// ```
  static ListTileTheme of(BuildContext context) {
    final ListTileTheme result = context.inheritFromWidgetOfExactType(ListTileTheme);
    return result ?? const ListTileTheme();
  }

  @override
  bool updateShouldNotify(ListTileTheme oldWidget) {
    return dense != oldWidget.dense ||
        style != oldWidget.style ||
        selectedColor != oldWidget.selectedColor ||
        iconColor != oldWidget.iconColor ||
        textColor != oldWidget.textColor ||
        contentPadding != oldWidget.contentPadding;
  }
}

/// Where to place the control in widgets that use [GroovinListTile] to position a
/// control next to a label.
///
/// See also:
///
///  * [CheckboxListTile], which combines a [GroovinListTile] with a [Checkbox].
///  * [RadioListTile], which combines a [GroovinListTile] with a [Radio] button.
enum GroovinListTileControlAffinity {
  /// Position the control on the leading edge, and the secondary widget, if
  /// any, on the trailing edge.
  leading,

  /// Position the control on the trailing edge, and the secondary widget, if
  /// any, on the leading edge.
  trailing,

  /// Position the control relative to the text in the fashion that is typical
  /// for the current platform, and place the secondary widget on the opposite
  /// side.
  platform,
}

/// Represents a custom ListTile that
class GroovinListTile extends StatelessWidget {
  /// Creates a list tile.
  ///
  /// If [isThreeLine] is true, then [subtitle] must not be null.
  ///
  /// Requires one of its ancestors to be a [Material] widget.
  const GroovinListTile({
    Key key,
    this.inkwellRadius,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.isThreeLine = false,
    this.dense,
    this.contentPadding,
    this.enabled = true,
    this.onTap,
    this.onLongPress,
    this.selected = false,
  })  : assert(isThreeLine != null),
        assert(enabled != null),
        assert(selected != null),
        assert(!isThreeLine || subtitle != null),
        super(key: key);

  final BorderRadius inkwellRadius;

  /// A widget to display before the title.
  ///
  /// Typically an [Icon] or a [CircleAvatar] widget.
  final Widget leading;

  /// The primary content of the list tile.
  ///
  /// Typically a [Text] widget.
  final Widget title;

  /// Additional content displayed below the title.
  ///
  /// Typically a [Text] widget.
  final Widget subtitle;

  /// A widget to display after the title.
  ///
  /// Typically an [Icon] widget.
  final Widget trailing;

  /// Whether this list tile is intended to display three lines of text.
  ///
  /// If false, the list tile is treated as having one line if the subtitle is
  /// null and treated as having two lines if the subtitle is non-null.
  final bool isThreeLine;

  /// Whether this list tile is part of a vertically dense list.
  ///
  /// If this property is null then its value is based on [ListTileTheme.dense].
  final bool dense;

  /// The tile's internal padding.
  ///
  /// Insets a [GroovinListTile]'s contents: its [leading], [title], [subtitle],
  /// and [trailing] widgets.
  ///
  /// If null, `EdgeInsets.symmetric(horizontal: 16.0)` is used.
  final EdgeInsetsGeometry contentPadding;

  /// Whether this list tile is interactive.
  ///
  /// If false, this list tile is styled with the disabled color from the
  /// current [Theme] and the [onTap] and [onLongPress] callbacks are
  /// inoperative.
  final bool enabled;

  /// Called when the user taps this list tile.
  ///
  /// Inoperative if [enabled] is false.
  final GestureTapCallback onTap;

  /// Called when the user long-presses on this list tile.
  ///
  /// Inoperative if [enabled] is false.
  final GestureLongPressCallback onLongPress;

  /// If this tile is also [enabled] then icons and text are rendered with the same color.
  ///
  /// By default the selected color is the theme's primary color. The selected color
  /// can be overridden with a [ListTileTheme].
  final bool selected;

  /// Add a one pixel border in between each tile. If color isn't specified the
  /// [ThemeData.dividerColor] of the context's [Theme] is used.
  ///
  /// See also:
  ///
  /// * [Divider], which you can use to obtain this effect manually.
  static Iterable<Widget> divideTiles(
      {BuildContext context, @required Iterable<Widget> tiles, Color color}) sync* {
    assert(tiles != null);
    assert(color != null || context != null);

    final Iterator<Widget> iterator = tiles.iterator;
    final bool isNotEmpty = iterator.moveNext();

    final Decoration decoration = BoxDecoration(
      border: Border(
        bottom: Divider.createBorderSide(context, color: color),
      ),
    );

    Widget tile = iterator.current;
    while (iterator.moveNext()) {
      yield DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: decoration,
        child: tile,
      );
      tile = iterator.current;
    }
    if (isNotEmpty) yield tile;
  }

  Color _iconColor(ThemeData theme, ListTileTheme tileTheme) {
    if (!enabled) return theme.disabledColor;

    if (selected && tileTheme?.selectedColor != null) return tileTheme.selectedColor;

    if (!selected && tileTheme?.iconColor != null) return tileTheme.iconColor;

    switch (theme.brightness) {
      case Brightness.light:
        return selected ? theme.primaryColor : Colors.black45;
      case Brightness.dark:
        return selected ? theme.accentColor : null; // null - use current icon theme color
    }
    assert(theme.brightness != null);
    return null;
  }

  Color _textColor(ThemeData theme, ListTileTheme tileTheme, Color defaultColor) {
    if (!enabled) return theme.disabledColor;

    if (selected && tileTheme?.selectedColor != null) return tileTheme.selectedColor;

    if (!selected && tileTheme?.textColor != null) return tileTheme.textColor;

    if (selected) {
      switch (theme.brightness) {
        case Brightness.light:
          return theme.primaryColor;
        case Brightness.dark:
          return theme.accentColor;
      }
    }
    return defaultColor;
  }

  bool _isDenseLayout(ListTileTheme tileTheme) {
    return dense != null ? dense : (tileTheme?.dense ?? false);
  }

  TextStyle _titleTextStyle(ThemeData theme, ListTileTheme tileTheme) {
    TextStyle style;
    if (tileTheme != null) {
      switch (tileTheme.style) {
        case GroovinListTileStyle.drawer:
          style = theme.textTheme.body2;
          break;
        case GroovinListTileStyle.list:
          style = theme.textTheme.subhead;
          break;
      }
    } else {
      style = theme.textTheme.subhead;
    }
    final Color color = _textColor(theme, tileTheme, style.color);
    return _isDenseLayout(tileTheme)
        ? style.copyWith(fontSize: 13.0, color: color)
        : style.copyWith(color: color);
  }

  TextStyle _subtitleTextStyle(ThemeData theme, ListTileTheme tileTheme) {
    final TextStyle style = theme.textTheme.body1;
    final Color color = _textColor(theme, tileTheme, theme.textTheme.caption.color);
    return _isDenseLayout(tileTheme)
        ? style.copyWith(color: color, fontSize: 12.0)
        : style.copyWith(color: color);
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final ThemeData theme = Theme.of(context);
    final ListTileTheme tileTheme = ListTileTheme.of(context);

    IconThemeData iconThemeData;
    if (leading != null || trailing != null)
      iconThemeData = IconThemeData(color: _iconColor(theme, tileTheme));

    Widget leadingIcon;
    if (leading != null) {
      leadingIcon = IconTheme.merge(
        data: iconThemeData,
        child: leading,
      );
    }

    final TextStyle titleStyle = _titleTextStyle(theme, tileTheme);
    final Widget titleText = AnimatedDefaultTextStyle(
        style: titleStyle, duration: kThemeChangeDuration, child: title ?? const SizedBox());

    Widget subtitleText;
    TextStyle subtitleStyle;
    if (subtitle != null) {
      subtitleStyle = _subtitleTextStyle(theme, tileTheme);
      subtitleText = AnimatedDefaultTextStyle(
        style: subtitleStyle,
        duration: kThemeChangeDuration,
        child: subtitle,
      );
    }

    Widget trailingIcon;
    if (trailing != null) {
      trailingIcon = IconTheme.merge(
        data: iconThemeData,
        child: trailing,
      );
    }

    const EdgeInsets _defaultContentPadding = EdgeInsets.symmetric(horizontal: 16.0);
    final TextDirection textDirection = Directionality.of(context);
    final EdgeInsets resolvedContentPadding = contentPadding?.resolve(textDirection) ??
        tileTheme?.contentPadding?.resolve(textDirection) ??
        _defaultContentPadding;

    return InkWell(
      borderRadius: inkwellRadius,
      onTap: enabled ? onTap : null,
      onLongPress: enabled ? onLongPress : null,
      child: Semantics(
        selected: selected,
        enabled: enabled,
        child: SafeArea(
          top: false,
          bottom: false,
          minimum: resolvedContentPadding,
          child: _GroovinListTile(
            leading: leadingIcon,
            title: titleText,
            subtitle: subtitleText,
            trailing: trailingIcon,
            isDense: _isDenseLayout(tileTheme),
            isThreeLine: isThreeLine,
            textDirection: textDirection,
            titleBaselineType: titleStyle.textBaseline,
            subtitleBaselineType: subtitleStyle?.textBaseline,
          ),
        ),
      ),
    );
  }
}

// Identifies the children of a _ListTileElement.
enum _ListTileSlot {
  leading,
  title,
  subtitle,
  trailing,
}

class _GroovinListTile extends RenderObjectWidget {
  const _GroovinListTile({
    Key key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    @required this.isThreeLine,
    @required this.isDense,
    @required this.textDirection,
    @required this.titleBaselineType,
    this.subtitleBaselineType,
  })  : assert(isThreeLine != null),
        assert(isDense != null),
        assert(textDirection != null),
        assert(titleBaselineType != null),
        super(key: key);

  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final bool isThreeLine;
  final bool isDense;
  final TextDirection textDirection;
  final TextBaseline titleBaselineType;
  final TextBaseline subtitleBaselineType;

  @override
  _GroovinListTileElement createElement() => _GroovinListTileElement(this);

  @override
  _RenderGroovinListTile createRenderObject(BuildContext context) {
    return _RenderGroovinListTile(
      isThreeLine: isThreeLine,
      isDense: isDense,
      textDirection: textDirection,
      titleBaselineType: titleBaselineType,
      subtitleBaselineType: subtitleBaselineType,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderGroovinListTile renderObject) {
    renderObject
      ..isThreeLine = isThreeLine
      ..isDense = isDense
      ..textDirection = textDirection
      ..titleBaselineType = titleBaselineType
      ..subtitleBaselineType = subtitleBaselineType;
  }
}

class _GroovinListTileElement extends RenderObjectElement {
  _GroovinListTileElement(_GroovinListTile widget) : super(widget);

  final Map<_ListTileSlot, Element> slotToChild = <_ListTileSlot, Element>{};
  final Map<Element, _ListTileSlot> childToSlot = <Element, _ListTileSlot>{};

  @override
  _GroovinListTile get widget => super.widget;

  @override
  _RenderGroovinListTile get renderObject => super.renderObject;

  @override
  void visitChildren(ElementVisitor visitor) {
    slotToChild.values.forEach(visitor);
  }

  @override
  void forgetChild(Element child) {
    assert(slotToChild.values.contains(child));
    assert(childToSlot.keys.contains(child));
    final _ListTileSlot slot = childToSlot[child];
    childToSlot.remove(child);
    slotToChild.remove(slot);
  }

  void _mountChild(Widget widget, _ListTileSlot slot) {
    final Element oldChild = slotToChild[slot];
    final Element newChild = updateChild(oldChild, widget, slot);
    if (oldChild != null) {
      slotToChild.remove(slot);
      childToSlot.remove(oldChild);
    }
    if (newChild != null) {
      slotToChild[slot] = newChild;
      childToSlot[newChild] = slot;
    }
  }

  @override
  void mount(Element parent, dynamic newSlot) {
    super.mount(parent, newSlot);
    _mountChild(widget.leading, _ListTileSlot.leading);
    _mountChild(widget.title, _ListTileSlot.title);
    _mountChild(widget.subtitle, _ListTileSlot.subtitle);
    _mountChild(widget.trailing, _ListTileSlot.trailing);
  }

  void _updateChild(Widget widget, _ListTileSlot slot) {
    final Element oldChild = slotToChild[slot];
    final Element newChild = updateChild(oldChild, widget, slot);
    if (oldChild != null) {
      childToSlot.remove(oldChild);
      slotToChild.remove(slot);
    }
    if (newChild != null) {
      slotToChild[slot] = newChild;
      childToSlot[newChild] = slot;
    }
  }

  @override
  void update(_GroovinListTile newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    _updateChild(widget.leading, _ListTileSlot.leading);
    _updateChild(widget.title, _ListTileSlot.title);
    _updateChild(widget.subtitle, _ListTileSlot.subtitle);
    _updateChild(widget.trailing, _ListTileSlot.trailing);
  }

  void _updateRenderObject(RenderObject child, _ListTileSlot slot) {
    switch (slot) {
      case _ListTileSlot.leading:
        renderObject.leading = child;
        break;
      case _ListTileSlot.title:
        renderObject.title = child;
        break;
      case _ListTileSlot.subtitle:
        renderObject.subtitle = child;
        break;
      case _ListTileSlot.trailing:
        renderObject.trailing = child;
        break;
    }
  }

  @override
  void insertChildRenderObject(RenderObject child, dynamic slotValue) {
    assert(child is RenderBox);
    assert(slotValue is _ListTileSlot);
    final _ListTileSlot slot = slotValue;
    _updateRenderObject(child, slot);
    assert(renderObject.childToSlot.keys.contains(child));
    assert(renderObject.slotToChild.keys.contains(slot));
  }

  @override
  void removeChildRenderObject(RenderObject child) {
    assert(child is RenderBox);
    assert(renderObject.childToSlot.keys.contains(child));
    _updateRenderObject(null, renderObject.childToSlot[child]);
    assert(!renderObject.childToSlot.keys.contains(child));
    assert(!renderObject.slotToChild.keys.contains(slot));
  }

  @override
  void moveChildRenderObject(RenderObject child, dynamic slotValue) {
    assert(false, 'not reachable');
  }
}

class _RenderGroovinListTile extends RenderBox {
  _RenderGroovinListTile({
    @required bool isDense,
    @required bool isThreeLine,
    @required TextDirection textDirection,
    @required TextBaseline titleBaselineType,
    TextBaseline subtitleBaselineType,
  })  : assert(isDense != null),
        assert(isThreeLine != null),
        assert(textDirection != null),
        assert(titleBaselineType != null),
        _isDense = isDense,
        _isThreeLine = isThreeLine,
        _textDirection = textDirection,
        _titleBaselineType = titleBaselineType,
        _subtitleBaselineType = subtitleBaselineType;

  static const double _minLeadingWidth = 40.0;
  // The horizontal gap between the titles and the leading/trailing widgets
  static const double _horizontalTitleGap = 16.0;
  // The minimum padding on the top and bottom of the title and subtitle widgets.
  static const double _minVerticalPadding = 4.0;

  final Map<_ListTileSlot, RenderBox> slotToChild = <_ListTileSlot, RenderBox>{};
  final Map<RenderBox, _ListTileSlot> childToSlot = <RenderBox, _ListTileSlot>{};

  RenderBox _updateChild(RenderBox oldChild, RenderBox newChild, _ListTileSlot slot) {
    if (oldChild != null) {
      dropChild(oldChild);
      childToSlot.remove(oldChild);
      slotToChild.remove(slot);
    }
    if (newChild != null) {
      childToSlot[newChild] = slot;
      slotToChild[slot] = newChild;
      adoptChild(newChild);
    }
    return newChild;
  }

  RenderBox _leading;
  RenderBox get leading => _leading;
  set leading(RenderBox value) {
    _leading = _updateChild(_leading, value, _ListTileSlot.leading);
  }

  RenderBox _title;
  RenderBox get title => _title;
  set title(RenderBox value) {
    _title = _updateChild(_title, value, _ListTileSlot.title);
  }

  RenderBox _subtitle;
  RenderBox get subtitle => _subtitle;
  set subtitle(RenderBox value) {
    _subtitle = _updateChild(_subtitle, value, _ListTileSlot.subtitle);
  }

  RenderBox _trailing;
  RenderBox get trailing => _trailing;
  set trailing(RenderBox value) {
    _trailing = _updateChild(_trailing, value, _ListTileSlot.trailing);
  }

  // The returned list is ordered for hit testing.
  Iterable<RenderBox> get _children sync* {
    if (leading != null) yield leading;
    if (title != null) yield title;
    if (subtitle != null) yield subtitle;
    if (trailing != null) yield trailing;
  }

  bool get isDense => _isDense;
  bool _isDense;
  set isDense(bool value) {
    assert(value != null);
    if (_isDense == value) return;
    _isDense = value;
    markNeedsLayout();
  }

  bool get isThreeLine => _isThreeLine;
  bool _isThreeLine;
  set isThreeLine(bool value) {
    assert(value != null);
    if (_isThreeLine == value) return;
    _isThreeLine = value;
    markNeedsLayout();
  }

  TextDirection get textDirection => _textDirection;
  TextDirection _textDirection;
  set textDirection(TextDirection value) {
    assert(value != null);
    if (_textDirection == value) return;
    _textDirection = value;
    markNeedsLayout();
  }

  TextBaseline get titleBaselineType => _titleBaselineType;
  TextBaseline _titleBaselineType;
  set titleBaselineType(TextBaseline value) {
    assert(value != null);
    if (_titleBaselineType == value) return;
    _titleBaselineType = value;
    markNeedsLayout();
  }

  TextBaseline get subtitleBaselineType => _subtitleBaselineType;
  TextBaseline _subtitleBaselineType;
  set subtitleBaselineType(TextBaseline value) {
    if (_subtitleBaselineType == value) return;
    _subtitleBaselineType = value;
    markNeedsLayout();
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    for (RenderBox child in _children) child.attach(owner);
  }

  @override
  void detach() {
    super.detach();
    for (RenderBox child in _children) child.detach();
  }

  @override
  void redepthChildren() {
    _children.forEach(redepthChild);
  }

  @override
  void visitChildren(RenderObjectVisitor visitor) {
    _children.forEach(visitor);
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    final List<DiagnosticsNode> value = <DiagnosticsNode>[];
    void add(RenderBox child, String name) {
      if (child != null) value.add(child.toDiagnosticsNode(name: name));
    }

    add(leading, 'leading');
    add(title, 'title');
    add(subtitle, 'subtitle');
    add(trailing, 'trailing');
    return value;
  }

  @override
  bool get sizedByParent => false;

  static double _minWidth(RenderBox box, double height) {
    return box == null ? 0.0 : box.getMinIntrinsicWidth(height);
  }

  static double _maxWidth(RenderBox box, double height) {
    return box == null ? 0.0 : box.getMaxIntrinsicWidth(height);
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    final double leadingWidth = leading != null
        ? math.max(leading.getMinIntrinsicWidth(height), _minLeadingWidth) + _horizontalTitleGap
        : 0.0;
    return leadingWidth +
        math.max(_minWidth(title, height), _minWidth(subtitle, height)) +
        _maxWidth(trailing, height);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final double leadingWidth = leading != null
        ? math.max(leading.getMaxIntrinsicWidth(height), _minLeadingWidth) + _horizontalTitleGap
        : 0.0;
    return leadingWidth +
        math.max(_maxWidth(title, height), _maxWidth(subtitle, height)) +
        _maxWidth(trailing, height);
  }

  double get _defaultTileHeight {
    final bool hasSubtitle = subtitle != null;
    final bool isTwoLine = !isThreeLine && hasSubtitle;
    final bool isOneLine = !isThreeLine && !hasSubtitle;

    if (isOneLine) return isDense ? 48.0 : 56.0;
    if (isTwoLine) return isDense ? 64.0 : 72.0;
    return isDense ? 76.0 : 88.0;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return math.max(_defaultTileHeight,
        title.getMinIntrinsicHeight(width) + (subtitle?.getMinIntrinsicHeight(width) ?? 0.0));
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return computeMinIntrinsicHeight(width);
  }

  @override
  double computeDistanceToActualBaseline(TextBaseline baseline) {
    assert(title != null);
    final BoxParentData parentData = title.parentData;
    return parentData.offset.dy + title.getDistanceToActualBaseline(baseline);
  }

  static double _boxBaseline(RenderBox box, TextBaseline baseline) {
    return box.getDistanceToBaseline(baseline);
  }

  static Size _layoutBox(RenderBox box, BoxConstraints constraints) {
    if (box == null) return Size.zero;
    box.layout(constraints, parentUsesSize: true);
    return box.size;
  }

  static void _positionBox(RenderBox box, Offset offset) {
    final BoxParentData parentData = box.parentData;
    parentData.offset = offset;
  }

  // All of the dimensions below were taken from the Material Design spec:
  // https://material.io/design/components/lists.html#specs
  @override
  void performLayout() {
    final bool hasLeading = leading != null;
    final bool hasSubtitle = subtitle != null;
    final bool hasTrailing = trailing != null;
    final bool isTwoLine = !isThreeLine && hasSubtitle;
    final bool isOneLine = !isThreeLine && !hasSubtitle;
    final BoxConstraints looseConstraints = constraints.loosen();

    final double tileWidth = looseConstraints.maxWidth;
    final Size leadingSize = _layoutBox(leading, looseConstraints);
    final Size trailingSize = _layoutBox(trailing, looseConstraints);

    final double titleStart =
        hasLeading ? math.max(_minLeadingWidth, leadingSize.width) + _horizontalTitleGap : 0.0;
    final BoxConstraints textConstraints = looseConstraints.tighten(
      width:
          tileWidth - titleStart - (hasTrailing ? trailingSize.width + _horizontalTitleGap : 0.0),
    );
    final Size titleSize = _layoutBox(title, textConstraints);
    final Size subtitleSize = _layoutBox(subtitle, textConstraints);

    double titleBaseline;
    double subtitleBaseline;
    if (isTwoLine) {
      titleBaseline = isDense ? 28.0 : 32.0;
      subtitleBaseline = isDense ? 48.0 : 52.0;
    } else if (isThreeLine) {
      titleBaseline = isDense ? 22.0 : 28.0;
      subtitleBaseline = isDense ? 42.0 : 48.0;
    } else {
      assert(isOneLine);
    }

    double tileHeight;
    double titleY;
    double subtitleY;
    if (!hasSubtitle) {
      tileHeight = math.max(_defaultTileHeight, titleSize.height + 2.0 * _minVerticalPadding);
      titleY = (tileHeight - titleSize.height) / 2.0;
    } else {
      assert(subtitleBaselineType != null);
      titleY = titleBaseline - _boxBaseline(title, titleBaselineType);
      subtitleY = subtitleBaseline - _boxBaseline(subtitle, subtitleBaselineType);
      tileHeight = _defaultTileHeight;

      // If the title and subtitle overlap, move the title upwards by half
      // the overlap and the subtitle down by the same amount, and adjust
      // tileHeight so that both titles fit.
      final double titleOverlap = titleY + titleSize.height - subtitleY;
      if (titleOverlap > 0.0) {
        titleY -= titleOverlap / 2.0;
        subtitleY += titleOverlap / 2.0;
      }

      // If the title or subtitle overflow tileHeight then punt: title
      // and subtitle are arranged in a column, tileHeight = column height plus
      // _minVerticalPadding on top and bottom.
      if (titleY < _minVerticalPadding ||
          (subtitleY + subtitleSize.height + _minVerticalPadding) > tileHeight) {
        tileHeight = titleSize.height + subtitleSize.height + 2.0 * _minVerticalPadding;
        titleY = _minVerticalPadding;
        subtitleY = titleSize.height + _minVerticalPadding;
      }
    }

    final double leadingY = (tileHeight - leadingSize.height) / 2.0;
    final double trailingY = (tileHeight - trailingSize.height) / 2.0;

    switch (textDirection) {
      case TextDirection.rtl:
        {
          if (hasLeading) _positionBox(leading, Offset(tileWidth - leadingSize.width, leadingY));
          final double titleX = hasTrailing ? trailingSize.width + _horizontalTitleGap : 0.0;
          _positionBox(title, Offset(titleX, titleY));
          if (hasSubtitle) _positionBox(subtitle, Offset(titleX, subtitleY));
          if (hasTrailing) _positionBox(trailing, Offset(0.0, trailingY));
          break;
        }
      case TextDirection.ltr:
        {
          if (hasLeading) _positionBox(leading, Offset(0.0, leadingY));
          _positionBox(title, Offset(titleStart, titleY));
          if (hasSubtitle) _positionBox(subtitle, Offset(titleStart, subtitleY));
          if (hasTrailing)
            _positionBox(trailing, Offset(tileWidth - trailingSize.width, trailingY));
          break;
        }
    }

    size = constraints.constrain(Size(tileWidth, tileHeight));
    assert(size.width == constraints.constrainWidth(tileWidth));
    assert(size.height == constraints.constrainHeight(tileHeight));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    void doPaint(RenderBox child) {
      if (child != null) {
        final BoxParentData parentData = child.parentData;
        context.paintChild(child, parentData.offset + offset);
      }
    }

    doPaint(leading);
    doPaint(title);
    doPaint(subtitle);
    doPaint(trailing);
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  bool hitTestChildren(HitTestResult result, {@required Offset position}) {
    assert(position != null);
    for (RenderBox child in _children) {
      final BoxParentData parentData = child.parentData;
      if (child.hitTest(result, position: position - parentData.offset)) return true;
    }
    return false;
  }
}
