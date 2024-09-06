import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CustomSocialSignInOptions extends StatelessWidget {
  const CustomSocialSignInOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SocialButton(
          icon: ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: <Color>[
                  Colors.red,
                  Colors.red,
                  Colors.yellow,
                  Colors.blue,
                  Colors.blue
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: const Icon(
              Iconsax.google_1,
              size: 40,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            // Implement Google login
          },
        ),
        SocialButton(
          icon: const Icon(Iconsax.apple, size: 40, color: Colors.black),
          onPressed: () {
            // Implement Apple login
          },
        ),
        SocialButton(
          icon: const Icon(Iconsax.facebook, size: 40, color: Colors.blue),
          onPressed: () {
            // Implement Facebook login
          },
        ),
      ],
    );
  }
}
class SocialButton extends StatefulWidget {
  const SocialButton(
      {super.key,
      required this.icon,
      required this.onPressed,
      this.backgroundColor = Colors.white,
      this.padding = 16});

  final Widget icon;
  final void Function()? onPressed;
  final Color backgroundColor;
  final double padding;

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: EdgeInsets.all(widget.padding),
          backgroundColor: widget.backgroundColor),
      onPressed: widget.onPressed,
      child: widget.icon,
    );
  }
}