import 'dart:ui';

import 'package:book_tracker/model/book.dart';
import 'package:book_tracker/model/user.dart';

import 'package:book_tracker/widgets/update_user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


Widget createProfileMobile(
    BuildContext context, List<MUser> list, User authUser, int booksRead) {
  TextEditingController _displayNameTextController =
      TextEditingController(text: list[0].displayName);
  TextEditingController _professionTextController =
      TextEditingController(text: list[0].profession);
  TextEditingController _avatarTextController =
      TextEditingController(text: list[0].avatarUrl);
  TextEditingController _quoteTextController =
      TextEditingController(text: list[0].quote);

  Widget widget;

  CollectionReference books = FirebaseFirestore.instance.collection('books');

  for (var user in list) {
    widget = Container(
      color: Colors.white,
      //height: 100,
      margin: EdgeInsets.all(23),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(user.avatarUrl == null
                      ? 'https://media.istockphoto.com/photos/ethnic-profile-picture-id185249635?k=6&m=185249635&s=612x612&w=0&h=8U5SlsY9iGJcHqBSxd_r6PLbgGFylccForDTK8drYcg='
                      : user.avatarUrl),
                  radius: 50,
                ),
              ),
              Spacer(),
              Container(
                margin: const EdgeInsets.only(bottom: 103),
                child: TextButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    label: Text('')),
              )
            ],
          ),
          Text(
            'Books Read ($booksRead)',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.redAccent),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${user.displayName.toUpperCase()}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              TextButton.icon(
                  // style: TextButton.styleFrom(
                  //     primary: Colors.white,
                  //     backgroundColor: Colors.blueGrey.shade100),
                  icon: Icon(
                    Icons.mode_edit,
                    color: Colors.black12,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return UpdateUserProfile(
                            user: user,
                            displayNameTextController:
                                _displayNameTextController,
                            profesionTextController: _professionTextController,
                            quoteTextController: _quoteTextController,
                            avatarTextController: _avatarTextController);
                      },
                    );
                  },
                  label: Text('')),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${user.profession}',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          SizedBox(
            width: 100,
            height: 2,
            child: Container(
              color: Colors.red,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 100,
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.blueGrey.shade100,
                    ),
                    color: Color(0xfff1f3f6),
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    )),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Text(
                        'Favorite Quote:',
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        width: 100,
                        height: 2,
                        child: Container(
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          (user.quote == null)
                              ? 'Favorite Book Quote : Life is great when you\'re not hungry...'
                              : " \"${user.quote} \"",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(fontStyle: FontStyle.italic),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  return widget;
}
