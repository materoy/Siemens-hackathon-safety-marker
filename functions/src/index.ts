import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp(functions.config().firebase);

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

export const alertsTrigger = functions.firestore.document("alerts/{alertId}")
  .onWrite(async (snapshot) => {
    const title = snapshot.after.get("title");
    const description = snapshot.after.get("description");
    const message : admin.messaging.Message = {
      condition: "",
      notification: {
        title: title,
        body: description
      },
      data: {
        click_action: "FLUTTER_NOTIFICATION_CLICK",
        title: "title",
        body: "body",
      },
      android: {
        priority: "high"
      },
    };

    var response =  await admin.messaging().send(message)

    console.log(title)
    console.log(response)
  });


