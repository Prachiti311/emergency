//const functions = require('firebase-functions');
//const admin = require('firebase-admin');
//admin.initializeApp();
//
//exports.sendNotification = functions.firestore.document('messages/{messageId}')
//  .onCreate(async (snapshot, context) => {
//    const messageData = snapshot.data();
//    const message = `Emergency in ${messageData.location} of type ${messageData.type}`;
//
//    // Retrieve owner FCM token (replace with your logic)
//    const ownerFcmToken = await getOwnerFcmToken(messageData.ownerId);
//
//    if (!ownerFcmToken) {
//      console.warn('Could not find FCM token for owner:', messageData.ownerId);
//      return;
//    }
//
//    const payload = {
//      notification: {
//        title: 'New Emergency Report',
//        body: message,
//      },
//    };
//
//    // Send notification to the owner's device
//    return admin.messaging().sendToDevice(ownerFcmToken, payload);
//  });
//
//async function getOwnerFcmToken(ownerId) {
//  try {
//    // Retrieve the owner document from Firestore
//    const ownerDoc = await admin.firestore().collection('owners').doc(ownerId).get();
//
//    // Check if the owner document exists
//    if (ownerDoc.exists) {
//      // Extract the FCM token from the owner document data
//      const fcmToken = ownerDoc.data().fcmToken;
//      return fcmToken;
//    } else {
//      // If the owner document does not exist, log a warning and return null
//      console.warn('Owner document not found:', ownerId);
//      return null;
//    }
//  } catch (error) {
//    // Handle any errors that occur during the Firestore operation
//    console.error('Error fetching owner document:', error);
//    return null;
//  }
//}
//
//}

//
//const functions = require('firebase-functions');
//const admin = require('firebase-admin');
//admin.initializeApp();
//
//exports.sendNotification = functions.firestore.document('messages/{messageId}')
//  .onCreate((snapshot, context) => {
//    const messageData = snapshot.data();
//    const message = `Emergency in ${messageData.location} of type ${messageData.type}`;
//
//    const payload = {
//      notification: {
//        title: 'New Emergency Report',
//        body: message,
//      },
//    };
//
//    const ownerFCMToken = 'eRS02wC6S3iXRNB6OYjC4M:APA91bGs6ELOERNjAM2inqJMdrPUTZyr_FIIvM6hr5VN1mRBWU8cFBc9lM6mSAdueqC3MvGvMsYlulwrbkIOEa9AKmBeYwnTdLKIH-lmGocPmD-WecxMTK_gYxtLJgS1XHAzsIs1a2NQ'; // Replace with owner's FCM token
//    return admin.messaging().sendToDevice(ownerFCMToken, payload);
//  });
//
//const {onRequest} = require("firebase-functions/v2/https");
//const logger = require("firebase-functions/logger");
//
//


const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.sendNotification = functions.firestore
  .document('messages/{messageId}')
  .onCreate(async (snap, context) => {
    const messageData = snap.data();

    const payload = {
      notification: {
        title: 'New Emergency Reported',
        body: messageData.message,
      }
    };

    // Get the owner's device token
    const ownerToken = 'dulS_KMUTRq7QluKF7pvJB:APA91bExXm0g6Z2DOHj6vNor5JeZjPf5APou20ok6lLPjo6qy-j9pHDGsREr4jDGRE6PUf_a2u6q2TP3IZUZOFZs076nEsi3jYGchIAU8eDvkH7VSL2AyRdyjmAjcG98E78fElXn0iNe'; // Replace with the actual owner's FCM token

    // Send a notification to the owner
    await admin.messaging().sendToDevice(ownerToken, payload);

    console.log('Notification sent to owner');
  });
