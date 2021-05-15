import 'package:book_tracker/constants/constants.dart';
import 'package:book_tracker/model/book.dart';
import 'package:book_tracker/widgets/book_rating.dart';
import 'package:book_tracker/widgets/two_sided_roundbutton.dart';
import 'package:flutter/material.dart';

class ReadingListCard extends StatelessWidget {
  final String image;
  final String title;
  final String author;
  final double rating;
  final String buttonText;
  final Book book;
  final bool isBookRad;
  final Function pressDetails;
  final Function pressRead;

  const ReadingListCard(
      {Key key,
      this.image,
      this.title,
      this.author,
      this.rating = 4.5,
      this.buttonText,
      this.book,
      this.isBookRad,
      this.pressDetails,
      this.pressRead})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24, bottom: 0),
      width: 202,
      child: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                height: 244,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(29),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 33,
                          color: kShadowColor)
                    ]),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              image,
              width: 100,
            ),
          ),
          Positioned(
              top: 34,
              right: 10,
              child: Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                  BookRating(score: (rating))
                ],
              )),
          Positioned(
              top: 160,
              child: Container(
                height: 85,
                width: 202,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6, left: 24),
                      child: RichText(
                        maxLines: 2,
                        text: TextSpan(
                            style: TextStyle(color: kBlackColor),
                            children: [
                              TextSpan(
                                  text: '$title\n',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: author,
                                  style: TextStyle(color: kLightBlackColor)),
                            ]),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Text('Details'),
                        ),
                        Expanded(
                            child: TwoSidedRoundeButton(
                                text: buttonText,
                                press: pressRead,
                                color: kLightPurple))
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
