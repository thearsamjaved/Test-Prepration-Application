import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GuestScreen extends StatefulWidget {
  const GuestScreen({super.key});

  @override
  State<GuestScreen> createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  late ScrollController _scrollController;
  double _scrollControllerOffset = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _scrollControllerOffset = _scrollController.offset;
        });
      });
  }

  bool get _isSliverAppbarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > (160 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          title: _isSliverAppbarExpanded
              ? FadingText(
                  Text: "Hello App", scrollOffset: _scrollControllerOffset)
              : null,
          // floating: true,
          pinned: true,
          expandedHeight: 200,
          backgroundColor: Colors.red,
          flexibleSpace: FlexibleSpaceBar(
            background: Image(
              image: AssetImage("assets/images.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ListTile(
                title: Text("Item $index"),
              );
            },
            childCount: 100,
          ),
        )
      ],
    ));
  }
}

class FadingText extends StatefulWidget {
  final String Text;
  final double scrollOffset;
  const FadingText({super.key, required this.Text, required this.scrollOffset});

  @override
  State<FadingText> createState() => _FadingTextState();
}

class _FadingTextState extends State<FadingText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.Text,
      style: TextStyle(
          color: Colors.white
              .withOpacity((widget.scrollOffset / 150).clamp(0, 1).toDouble())),
    );
  }
}
