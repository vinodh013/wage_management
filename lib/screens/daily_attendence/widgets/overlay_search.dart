import 'package:flutter/material.dart';
import 'package:wage_management/models/project.dart';

class DropUp extends StatefulWidget {
  TextEditingController searchBoxController;

  DropUp({super.key, required this.searchBoxController});

  @override
  State<DropUp> createState() => _DropUpState();
}

class _DropUpState extends State<DropUp> {
  final focusNode = FocusNode();
  final layerLink = LayerLink();
  OverlayEntry? entry;

  double? h;

  Projects project = Projects(projects: [
    Project(name: 'project1'),
    Project(name: 'project2'),
    Project(name: 'project3'),
    Project(name: 'project3'),
    
  ]);

  @override
  void initState() {
    super.initState();
    //  WidgetsBinding.instance.addPostFrameCallback((_) => showOverlay());

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        showOverlay();
      } else {
        hideOverlay();
      }
    });
  }

  void showOverlay() {
    final overlay = Overlay.of(context)!;
    final renderbox = context.findRenderObject() as RenderBox;
    final size = renderbox.size;

    entry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          followerAnchor: Alignment.bottomLeft,
          targetAnchor: Alignment.topLeft,
          child: buildOverlay(),
        ),
      ),
    );

    overlay.insert(entry!);
  }

  void hideOverlay() {
    entry?.remove();
    entry = null;
  }

  Widget buildOverlay() {
   
    return Material(
      elevation: 8,
      child: Column(
          children: project.projects.map((e) {
        return ListTile(
          title: Text(e.name),
          onTap: () {
            widget.searchBoxController.text = e.name;
            hideOverlay();
            focusNode.unfocus();
          },
        );
      }).toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return CompositedTransformTarget(
      link: layerLink,
      child: TextFormField(
          focusNode: focusNode,
          controller: widget.searchBoxController,
          onTap: () {},
          decoration: const InputDecoration(
              hintText: 'Search Project',
              fillColor: Color.fromARGB(217, 217, 217, 217),
              filled: true,
              border: OutlineInputBorder(borderSide: BorderSide(width: 1)))),
    );
  }
}
