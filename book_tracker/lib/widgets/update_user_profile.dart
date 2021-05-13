import 'package:book_tracker/model/user.dart';
import 'package:book_tracker/widgets/input_decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateUserProfile extends StatelessWidget {
  const UpdateUserProfile({
    Key key,
    @required this.user,
    @required TextEditingController displayNameTextController,
    @required TextEditingController profesionTextController,
    @required TextEditingController quoteTextController,
    @required TextEditingController avatarTextController,
  })  : _displayNameTextController = displayNameTextController,
        _profesionTextController = profesionTextController,
        _quoteTextController = quoteTextController,
        _avatarTextController = avatarTextController,
        super(key: key);

  final MUser user;
  final TextEditingController _displayNameTextController;
  final TextEditingController _profesionTextController;
  final TextEditingController _quoteTextController;
  final TextEditingController _avatarTextController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('Edit ${user.displayName}'),
      ),
      content: Form(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(user.avatarUrl != null
                      ? user.avatarUrl
                      : 'https://i.pravatar.cc/300'),
                  radius: 50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _displayNameTextController,
                  decoration:
                      buildInputDecoration(label: 'Your name', hintText: ''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _profesionTextController,
                  decoration:
                      buildInputDecoration(label: 'Profession', hintText: ''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _quoteTextController,
                  decoration: buildInputDecoration(
                      label: 'Favorite quote', hintText: ''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _avatarTextController,
                  decoration:
                      buildInputDecoration(label: 'Avatar url', hintText: ''),
                ),
              )
            ],
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              onPressed: () {
                final userChangedName =
                    user.displayName != _displayNameTextController.text;

                final userChangedAvatar =
                    user.avatarUrl != _avatarTextController.text;
                final userChangedProfession =
                    user.profession != _profesionTextController.text;
                final userChangedQuote =
                    user.quote != _quoteTextController.text;

                final userNeedUpdate = userChangedName ||
                    userChangedAvatar ||
                    userChangedProfession ||
                    userChangedQuote;

                if (userNeedUpdate) {
                  print('Updating...');
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.id)
                      .update(MUser(
                              uid: user.uid,
                              displayName: _displayNameTextController.text,
                              avatarUrl: _avatarTextController.text,
                              profession: _profesionTextController.text,
                              quote: _quoteTextController.text)
                          .toMap());
                }
                Navigator.of(context).pop();
              },
              child: Text('Update')),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel')),
        )
      ],
    );
  }
}
