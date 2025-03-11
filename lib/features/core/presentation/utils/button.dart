import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function()? ontap;
  final String title;
  final bool loading;
  final bool enabled;

  const Button({
    super.key,
    this.ontap,
    required this.title,
    required this.loading,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FilledButton(
      onPressed: enabled ? ontap : null,
      style: FilledButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        backgroundColor:enabled? Colors.blueAccent:Colors.grey.shade400,
      ),
      child:
          loading
              ? CircularProgressIndicator(color: theme.colorScheme.primary)
              : Text(title, style: TextStyle(color: theme.colorScheme.primary)),
    );
  }
}
