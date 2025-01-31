import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(String) onSectionSelected;

  const CustomAppBar({
    super.key,
    required this.onSectionSelected,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg2.jpg'),
          fit: BoxFit.cover,
          opacity: 0.5,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/logo2.png',
                height: 45,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _NavButton(
                    title: 'Resumen',
                    onTap: () => onSectionSelected('resumen'),
                  ),
                  const SizedBox(width: 24),
                  _NavButton(
                    title: 'Historial',
                    onTap: () => onSectionSelected('historial'),
                  ),
                  const SizedBox(width: 24),
                  _NavButton(
                    title: 'Añadir',
                    onTap: () => onSectionSelected('añadir'),
                  ),
                ],
              ),
              const SizedBox(width: 45), // Balance para el logo
            ],
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavButton({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
        ),
      ),
    );
  }
}
