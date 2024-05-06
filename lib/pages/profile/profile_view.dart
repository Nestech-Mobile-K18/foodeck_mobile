import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/pages/export.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Future<void> logout() async {
    // print('logout gmail gg');

    // var isSignedIn = await GoogleSignIn().isSignedIn();
    // if (isSignedIn) await GoogleSignIn().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 24.dp),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 88.dp,
                height: 88.dp,
                // aspectRatio: 1,
                child: const CircleAvatar(
                  backgroundImage:
                      NetworkImage('https://picsum.photos/id/64/4326/2884'),
                ),
              ),
              SizedBox(
                height: 5.dp,
              ),
              Text('John Doe',
                  style:
                      TextStyle(fontSize: 20.dp, fontWeight: FontWeight.w700)),
              SizedBox(
                height: 5.dp,
              ),
              Text('Lahore, Pakistan',
                  style: TextStyle(fontSize: 17.dp, color: Colors.grey)),
              SizedBox(
                height: 40.dp,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 12.dp),
                  child: Text('Account Settings',
                      style: TextStyle(
                          fontSize: 15.dp,
                          fontWeight: FontWeight.bold,
                          color: ColorsGlobal.globalPink)),
                ),
              ),
              ListView(
                // scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(), // fix cannot scroll in listview mobile
                children: [
                  ListTile(
                      leading: const Icon(Icons.account_circle_outlined),
                      trailing: IconButton(
                        icon: const Icon(Icons.navigate_next),
                        onPressed: () {},
                      ),
                      title: Text('Edit Account',
                          style: TextStyle(fontSize: 17.dp))),
                  const Divider(),
                  ListTile(
                      leading: const Icon(Icons.location_on_outlined),
                      trailing: IconButton(
                        icon: const Icon(Icons.navigate_next),
                        onPressed: () {},
                      ),
                      title: Text('My locations',
                          style: TextStyle(fontSize: 17.dp))),
                  const Divider(),
                  ListTile(
                      leading: const Icon(
                        CupertinoIcons.cube_box,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.navigate_next),
                        onPressed: () {},
                      ),
                      title:
                          Text('My Orders', style: TextStyle(fontSize: 17.dp))),
                  const Divider(),
                  ListTile(
                      leading: const Icon(Icons.payment),
                      trailing: IconButton(
                        icon: const Icon(Icons.navigate_next),
                        onPressed: () {},
                      ),
                      title: Text('Payment Methods',
                          style: TextStyle(fontSize: 17.dp))),
                  const Divider(),
                  ListTile(
                      leading: const Icon(Icons.star_outline_outlined),
                      trailing: IconButton(
                        icon: const Icon(Icons.navigate_next),
                        onPressed: () {},
                      ),
                      title: Text('My reviews',
                          style: TextStyle(fontSize: 17.dp))),
                  const Divider(),
                ],
              ),
              SizedBox(
                height: 40.dp,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 12.dp),
                  child: Text('General Settings',
                      style: TextStyle(
                          fontSize: 15.dp,
                          fontWeight: FontWeight.bold,
                          color: ColorsGlobal.globalPink)),
                ),
              ),
              ListView(
                // scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(), // fix cannot scroll in listview mobile
                children: [
                  ListTile(
                      leading:
                          const Icon(CupertinoIcons.exclamationmark_circle),
                      trailing: IconButton(
                        icon: const Icon(Icons.navigate_next),
                        onPressed: () {},
                      ),
                      title:
                          Text('About us', style: TextStyle(fontSize: 17.dp))),
                  const Divider(),
                  ListTile(
                      leading: const Icon(Icons.logout),
                      trailing: IconButton(
                        icon: const Icon(Icons.navigate_next),
                        onPressed: () => logout(),
                      ),
                      title:
                          Text('Log out', style: TextStyle(fontSize: 17.dp))),
                  const Divider(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
