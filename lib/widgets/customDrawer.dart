import 'package:flutter/material.dart';
import 'package:solar_system/pages/homePage.dart';
import 'package:solar_system/theme/app_colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primary,
            ),
            child: Row(
              children: [
                Icon(Icons.sunny, color: Colors.white, size: 40),
                SizedBox(width: 10),
                Text(
                  'النظام الشمسي',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: AppColors.primary),
            title: const Text(
              'الصفحة الرئيسية',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, color: AppColors.primary),
            title: const Text(
              'عن التطبيق',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('عن التطبيق'),
                  content: const Text('هذا تطبيق بسيط للنظام الشمسي.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('حسنا',
                          style: TextStyle(color: AppColors.primary)),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help, color: AppColors.primary),
            title: const Text(
              'مساعدة',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('مساعدة'),
                  content: const Text(
                      'لاستخدام هذا التطبيق، اضغط على ابدأ لبدء التعلم على النظام الشمسي.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('حسنا',
                          style: TextStyle(color: AppColors.primary)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
