import 'package:flutter/material.dart';

class FeedsView extends StatelessWidget {
  final Widget child;
  const FeedsView({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class MoreNewsComponent extends StatefulWidget {
  final Function itemCreated;
  final Widget child;
  MoreNewsComponent({Key key, this.itemCreated, this.child}) : super(key: key);

  @override
  _MoreNewsComponentState createState() => _MoreNewsComponentState();
}

class _MoreNewsComponentState extends State<MoreNewsComponent> {
  @override
  void initState() {
    if (widget.itemCreated != null) {
      widget.itemCreated();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }
}
