import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          _buildUserInfo(user),
          _buildSectionList(context),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildUserInfo(User? user) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.blue[50],
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: user?.photoURL != null
                ? NetworkImage(user!.photoURL!)
                : AssetImage('assets/default_avatar.png') as ImageProvider,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.displayName ?? 'User Name',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(user?.email ?? 'Email not available'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionList(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.list),
            title: Text('My Orders'),
            onTap: () {
              Navigator.pushNamed(context, '/my-orders');
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Account Details'),
            onTap: () {
              Navigator.pushNamed(context, '/account-details');
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Wishlist'),
            onTap: () {
              Navigator.pushNamed(context, '/wishlist');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () async {
          try {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, '/login');
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to log out: $e')),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
          padding: EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          'Log Out',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
