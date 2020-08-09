import "package:flutter/material.dart";

import 'bubble.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String userName;
  final String userImage;
  final bool isMe;
  final Key key;

  MessageBubble(this.userName, this.userImage, this.message, this.isMe,
      {this.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 5,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 5,
          ),
          child: BubbleMessage(
            painter: BubblePainter(
                isMe ? Colors.grey[300] : Theme.of(context).accentColor, isMe),
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  top: -15,
                  left: isMe ? -25 : null,
                  right: isMe ? null : -25,
                  child: CircleAvatar(
                    backgroundColor:
                        isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                    backgroundImage: NetworkImage(userImage),
                    radius: 19,
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 250.0,
                    minWidth: 50.0,
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
                  child: Column(
                    crossAxisAlignment: isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        userName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isMe
                              ? Colors.black
                              : Theme.of(context)
                                  .accentTextTheme
                                  .headline6
                                  .color,
                        ),
                      ),
                      Text(
                        message,
                        style: TextStyle(
                          color: isMe
                              ? Colors.black
                              : Theme.of(context)
                                  .accentTextTheme
                                  .headline6
                                  .color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import "package:flutter/material.dart";

// class MessageBubble extends StatelessWidget {
//   final String message;
//   final String userId;
//   final bool isMe;
//   final Key key;

//   MessageBubble(this.userId, this.message, this.isMe, {this.key});

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;

//     return Row(
//       mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//       children: <Widget>[
//         Container(
//           decoration: BoxDecoration(
//             color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(12),
//               topRight: Radius.circular(12),
//               bottomRight: !isMe ? Radius.circular(12) : Radius.circular(0),
//               bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
//             ),
//           ),
//           width: width * 0.55,
//           padding: EdgeInsets.symmetric(
//             vertical: 10,
//             horizontal: 15,
//           ),
//           margin: EdgeInsets.symmetric(
//             vertical: 5,
//             horizontal: 10,
//           ),
//           child: Column(
//             crossAxisAlignment:
//                 isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//             children: <Widget>[
//               FutureBuilder<Object>(
//                   future: Firestore.instance
//                       .collection('users')
//                       .document(userId)
//                       .get(),
//                   builder: (context, AsyncSnapshot<dynamic> snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return Text(
//                         "Loading...",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: isMe
//                               ? Colors.black
//                               : Theme.of(context)
//                                   .accentTextTheme
//                                   .headline6
//                                   .color,
//                         ),
//                       );
//                     } else {
//                       return Text(
//                         snapshot.data['userName'],
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: isMe
//                               ? Colors.black
//                               : Theme.of(context)
//                                   .accentTextTheme
//                                   .headline6
//                                   .color,
//                         ),
//                       );
//                     }
//                   }),
//               Text(
//                 message,
//                 style: TextStyle(
//                   color: isMe
//                       ? Colors.black
//                       : Theme.of(context).accentTextTheme.headline6.color,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
