import 'package:book_tracker/model/user.dart';
import 'package:book_tracker/screens/login_page.dart';
import 'package:book_tracker/widgets/create_profile.dart';
import 'package:book_tracker/widgets/input_decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference userCollectionReference =
        FirebaseFirestore.instance.collection('users');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        elevation: 0.0,
        toolbarHeight: 77,
        centerTitle: false,
        title: Row(
          children: [
            Text(
              'A.Reader',
              style: Theme.of(context).textTheme.headline6.copyWith(
                  color: Colors.redAccent, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          StreamBuilder<QuerySnapshot>(
            stream: userCollectionReference.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final userListStream = snapshot.data.docs.map((user) {
                return MUser.fromDocument(user);
              }).where((user) {
                print(user.displayName);

                return (user.uid == FirebaseAuth.instance.currentUser.uid);
              }).toList(); //[user]

              MUser curUser = userListStream[0];

              return Column(
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: InkWell(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(curUser.avatarUrl != null
                            ? curUser.avatarUrl
                            : 'https://i.pravatar.cc/300'),
                        backgroundColor: Colors.white,
                        child: Text(''),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            // return createProfileMobile(context, userListStream,
                            //     FirebaseAuth.instance.currentUser, null);
                            return createProfileDialog(context, curUser);
                          },
                        );
                      },
                    ),
                  ),
                  Text(
                    curUser.displayName.toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black),
                  )
                ],
              );
            },
          ),
          TextButton.icon(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  return Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                });
              },
              icon: Icon(Icons.logout),
              label: Text(''))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookSearchPage(),
              ));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}

class BookSearchPage extends StatelessWidget {
  final TextEditingController _searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Search'),
        backgroundColor: Colors.redAccent,
      ),
      body: Material(
        elevation: 0.0,
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                        child: TextField(
                      controller: _searchTextController,
                      decoration: buildInputDecoration(
                          label: 'Search', hintText: 'Flutter Development'),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
