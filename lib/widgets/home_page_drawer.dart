import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
           DrawerHeader(            
            decoration: const BoxDecoration(
              color: Colors.pink,
            ),
            child: Stack(
              children:[
                 IconButton(onPressed: (){Get.back();}, icon: const Icon(Iconsax.arrow_left_2_copy)),
                const Center(
                child: Text(
                  'To Do App',
                  style: TextStyle(
                      color: Colors.white, fontSize: 30, fontFamily: 'Huglove'),
                ),
              ),
        ]),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {Get.toNamed('/homePage');},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
