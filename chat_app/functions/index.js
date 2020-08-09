const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.pushNotificationFunction = functions.firestore
    .document('chat/{message}')
    .onCreate((snapShot, context) => {
        return admin.messaging().sendToTopic('chat', {
            notification: {
                title: snapShot.data().userName,
                body: snapShot.data().text,
                clickAction: 'FLUTTER_NOTIFICATION_CLICK',
            },
        })
    });