import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/components.dart';
import '../models/models.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  static MaterialPage page(User user) {
    return MaterialPage(
      name: FooderlichPages.profilePath,
      key: ValueKey(FooderlichPages.profilePath),
      child: ProfileScreen(user: user),
    );
  }

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.read<ProfileManager>().tapOnProfile(false);
          },
          icon: const Icon(Icons.close),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            _buildProfile(),
            Expanded(
              child: _buildMenu(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfile() {
    return Column(
      children: [
        CircleImage(
          imageProvider: AssetImage(user.profileImageUrl),
          imageRadius: 60,
        ),
        const SizedBox(height: 16),
        Text(
          user.firstName,
          style: const TextStyle(fontSize: 21),
        ),
        Text(user.role),
        Text(
          '${user.points} points',
          style: const TextStyle(
            fontSize: 30,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildDarkModeRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Dark mode'),
          Switch(
            value: user.darkMode,
            onChanged: (value) {
              context.read<ProfileManager>().darkMode = value;
            },
          )
        ],
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    return ListView(
      children: [
        _buildDarkModeRow(context),
        ListTile(
          title: const Text('View raywenderlich.com'),
          onTap: () {
            context.read<ProfileManager>().tapOnRayderlich(true);
          },
        ),
        ListTile(
          title: const Text('Log out'),
          onTap: () {
            context.read<ProfileManager>().tapOnProfile(false);
            context.read<AppStateManager>().logOut();
          },
        ),
      ],
    );
  }
}
