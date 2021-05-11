import 'package:book_tracker/model/user.dart';
import 'package:book_tracker/widgets/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget createProfileDialog(BuildContext context, MUser curUser) {
  final TextEditingController _displayNameTextController =
      TextEditingController(text: curUser.displayName);
  final TextEditingController _profesionTextController =
      TextEditingController(text: curUser.profession);

  final TextEditingController _quoteTextController =
      TextEditingController(text: curUser.quote);
  final TextEditingController _avatarTextController =
      TextEditingController(text: curUser.avatarUrl);

  return AlertDialog(
    content: Container(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(curUser.avatarUrl == null
                  ? 'https://i.pravatar.cc/300'
                  : curUser.avatarUrl),
              radius: 50,
            )
          ],
        ),
        Text(
          'Books Read',
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
                curUser.displayName.toUpperCase(),
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            TextButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Center(
                        child: Text('Edit ${curUser.displayName}'),
                      ),
                      content: Form(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(
                                      curUser.avatarUrl != null
                                          ? curUser.avatarUrl
                                          : 'https://i.pravatar.cc/300'),
                                  radius: 50,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _displayNameTextController,
                                  decoration: buildInputDecoration(
                                      label: 'Your name', hintText: ''),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _profesionTextController,
                                  decoration: buildInputDecoration(
                                      label: 'Profession', hintText: ''),
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
                                  decoration: buildInputDecoration(
                                      label: 'Avatar url', hintText: ''),
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
                              onPressed: () {}, child: Text('Update')),
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
                  },
                );
              },
              icon: Icon(
                Icons.mode_edit,
                color: Colors.black12,
              ),
              label: Text(''),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${curUser.profession}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(
          width: 100,
          height: 2,
          child: Container(
            color: Colors.red,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.blueGrey.shade100),
              color: HexColor('#f1f3f6'),
              borderRadius: BorderRadius.all(Radius.circular(4))),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Text('Favorite Quote:',
                    style: TextStyle(
                      color: Colors.black,
                    )),
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
                      curUser.quote == null
                          ? 'Favorite book quote: Life is great...'
                          : " \" ${curUser.quote} \"",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontStyle: FontStyle.italic),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    )),
  );
}
