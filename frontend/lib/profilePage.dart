import 'package:flutter/material.dart';
import 'Auth.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({this.isReady, this.user});

  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double screenTextScale(BuildContext context) {
    return MediaQuery.textScaleFactorOf(context);
  }

  final bool isReady;
  final String imageUrl = 'https://i.imgur.com/hlCsBwp.jpg';

  final User user;

  final bool isEditable = false;

  @override
  Widget build(BuildContext context) {
    if (isReady) {
      return profileContainer(context);
    } else {
      return Container(color: Colors.white);
    }
  }

  NetworkImage getProfileImage() {
    if (user.imageUrl == null) {
      return NetworkImage(
          'https://russiancouncil.ru/local/templates/main/img/user.jpg');
    }
    return NetworkImage(user.imageUrl);
  }

  Widget makeInfoRow(BuildContext context, {Icon icon, String text}) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Text(
            text,
            style: TextStyle(
              fontSize: screenTextScale(context) * 15,
            ),
          ),
        ],
      ),
    );
  }

  /* Makes user info rows */
  Widget makeUserInfo(BuildContext context) {
    List<Widget> infoRows = new List();

    Widget workRow = makeInfoRow(
      context,
      icon: Icon(
        Icons.work,
        semanticLabel: 'work icon',
      ),
      text:
          (" - " + user.position.toString() + " at " + user.company.toString()),
    );

    if (user.company != null && user.position != null) {
      infoRows.add(workRow);
    }

    Widget interestsRow = makeInfoRow(
      context,
      icon: Icon(
        Icons.star,
        semanticLabel: 'interests icon',
      ),
      text: " - " + "Likes " + 'pere',
    );

    if (false) {
      // TODO: add condition
      infoRows.add(interestsRow);
    }

    Widget speakerRow = makeInfoRow(
      context,
      icon: Icon(
        Icons.mic,
        // size: screenSize(context).aspectRatio *
        //     0.03, // relativo ao ecra
        semanticLabel: 'speaker icon',
      ),
      text: " - Speaker at OpenCX",
    );

    if (user.isSpeaker) {
      infoRows.add(speakerRow);
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [workRow, interestsRow, speakerRow],
      ),
    );
  }

  /* User profile container */
  Widget profileContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: screenWidth(context) * 0.3,
            child: CircleAvatar(
              backgroundImage: getProfileImage(),
              radius: screenWidth(context) * 0.25,
            ),
          ),
          Container(
            width: screenWidth(context) * 0.55,
            height: screenHeight(context) * 0.07,
            color: Colors.transparent,
            padding: EdgeInsets.only(
              top: screenHeight(context) * 0.01,
              bottom: screenHeight(context) * 0.01,
              left: screenWidth(context) * 0.01,
              right: screenWidth(context) * 0.01,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0)),
              ),
              padding: EdgeInsets.only(
                top: screenHeight(context) * 0.01,
                bottom: screenHeight(context) * 0.01,
                left: screenWidth(context) * 0.01,
                right: screenWidth(context) * 0.01,
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  user.fullName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          makeUserInfo(context)
        ],
      ),
    );
  }
}
