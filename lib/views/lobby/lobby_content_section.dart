import 'dart:convert';
import 'package:aroundu/designs/colors.designs.dart';
import 'package:aroundu/designs/fonts.designs.dart';
import 'package:aroundu/models/lobby.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
// import 'package:aroundu/models/lobby_model.dart';

class NewLobbyContentSection extends StatefulWidget {
  final ContentModel content;
  final double? height;
  final bool isDark;

  const NewLobbyContentSection({
    super.key,
    required this.content,
    this.height,
    this.isDark = false,
  });

  @override
  State<NewLobbyContentSection> createState() => _NewLobbyContentSectionState();
}

class _NewLobbyContentSectionState extends State<NewLobbyContentSection> {
  late QuillController _controller;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    try {
      if (widget.content.body.isNotEmpty) {
        final delta = jsonDecode(widget.content.body);
        _controller = QuillController(
          document: Document.fromJson(delta),
          selection: const TextSelection.collapsed(offset: 0),
          readOnly: true,
        );
      } else {
        _controller = QuillController.basic();
      }
      setState(() {
        _isLoaded = true;
      });
    } catch (e) {
      // If parsing fails, create a new document with the text as plain text
      _controller = QuillController.basic();
      _controller.document.insert(0, widget.content.body);
      setState(() {
        _isLoaded = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double sw(double size) => screenWidth * size;
    double sh(double size) => screenHeight * size;

    bool isDark = widget.isDark;

    if (!_isLoaded) {
      return Center(child: CircularProgressIndicator());
    }

    return Container(
      padding: EdgeInsets.all(16),
      constraints: BoxConstraints(maxHeight: widget.height ?? sh(0.5)),

      decoration: BoxDecoration(
        color:isDark ? DesignColors.bgDark : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color:isDark ?DesignColors.secondary: Colors.grey.shade100, width: 1),
      ),
      child: QuillEditor.basic(
        controller: _controller,
        // readOnly: true,
        config: QuillEditorConfig(
          maxHeight: widget.height ?? sh(0.5),
          customStyles: DefaultStyles(
            placeHolder: DefaultTextBlockStyle(
              DesignFonts.poppins.copyWith(
                fontSize: 14,
                color: DesignColors.secondary,
              ),
              const HorizontalSpacing(0, 0),
              const VerticalSpacing(0, 0),
              const VerticalSpacing(0, 0),
              null,
            ),
            lists: DefaultListBlockStyle(
              TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: isDark ? DesignColors.primaryFontDark : DesignColors.primary, // This will apply to bullet text
              ),
              const HorizontalSpacing(0, 0),
              const VerticalSpacing(0, 0),
              const VerticalSpacing(0, 0),
              null,
              null,
            ),
            paragraph: DefaultTextBlockStyle(
              TextStyle(
                fontFamily: 'Poppins',
                fontSize:  14,
                color: isDark ? DesignColors.primaryFontDark : DesignColors.primary,
                overflow: TextOverflow.ellipsis,
              ),
              const HorizontalSpacing(0, 0),
              const VerticalSpacing(0, 0),
              const VerticalSpacing(0, 0),
              null,
            ),
          ),
          padding: EdgeInsets.zero,
          // readOnly: true,
          showCursor: false,
          autoFocus: false,
          expands: false,
          scrollable: true,
          enableSelectionToolbar: true,
        ),
      ),
    );
  }
}
