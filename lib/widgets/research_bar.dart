import 'package:flutter/material.dart';

class ReSearchBar extends StatefulWidget {
  final String? hintText;
  final Color? colorSearch;
  final ValueChanged<String>? onChanged;

  const ReSearchBar({super.key, this.hintText, this.colorSearch, this.onChanged});

  @override
  _ReSearchBarState createState() => _ReSearchBarState();
}

class _ReSearchBarState extends State<ReSearchBar> {
  final TextEditingController _controller = TextEditingController();

  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      _showClearButton = _controller.text.isNotEmpty;
    });

    // Call the onChanged function if provided
    if (widget.onChanged != null) {
      widget.onChanged!(_controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: widget.colorSearch ?? Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          const SizedBox(width: 15),
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: widget.hintText ?? 'Search ...',
                hintStyle: const TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          _showClearButton
              ? GestureDetector(
                  onTap: () {
                    _controller.clear();
                  },
                  child: const Icon(Icons.cancel),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
