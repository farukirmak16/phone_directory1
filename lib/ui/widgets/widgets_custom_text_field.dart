import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final String? initialValue;

  const CustomTextField({
    super.key,
    this.onChanged,
    this.obscureText = false,
    this.hintText,
    this.hintStyle,
    this.controller,
    this.initialValue,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  late TextEditingController _internalController;

  @override
  void initState() {
    super.initState();
    _internalController =
        widget.controller ?? TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _internalController,
      onChanged: widget.onChanged,
      obscureText: _obscureText && widget.obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.08),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey.withOpacity(0.60),
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      ),
    );
  }
}
