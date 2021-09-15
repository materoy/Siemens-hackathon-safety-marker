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
    var imagesUrl: string[] = snapshot.after.get("images");
    var imageUrl : string  = "https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FHazard_symbol&psig=AOvVaw1UZgQZEi0p-etfZyPdh_OE&ust=1631425985622000&source=images&cd=vfe&ved=0CAkQjRxqFwoTCICKts6d9vICFQAAAAAdAAAAABAE";
    if (imagesUrl != null) {
      imageUrl = imagesUrl[0];
    }
    const message: admin.messaging.Message = {
      topic: "alerts",
      notification: {
        title: title,
        body: description,
        imageUrl: imageUrl,
      },
      // data: {
      //   click_action: "FLUTTER_NOTIFICATION_CLICK",
      //   title: "title",
      //   body: "body",
      // },
      android: {
        priority: "high"
      },
    };

    await admin.messaging().send(message)

  });


