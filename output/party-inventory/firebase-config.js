// ---------------------------------------------------------------------------
// Live sharing. This is the only file you need to edit.
//
// Set firebaseConfig to null and the app runs entirely in this browser: every
// board is private to the machine that made it, nothing is sent anywhere, and
// the page makes no external requests at all.
//
// With a config, boards become live — everyone holding a board's link sees the
// same inventory, and changes appear on every screen as they happen.
//
//   1. console.firebase.google.com -> Add project (no billing needed).
//   2. Build -> Realtime Database -> Create database, "Start in locked mode".
//   3. Rules tab -> paste firebase-rules.json -> Publish.
//   4. Project settings -> Your apps -> Web (</>) -> register an app.
//   5. Paste the config block it gives you below, exactly as shown. Keep the
//      name it comes with; the app accepts firebaseConfig or FIREBASE_CONFIG.
//
// It must include databaseURL. The console sometimes omits it: copy it from the
// Realtime Database page, it looks like
// https://<project>-default-rtdb.<region>.firebasedatabase.app
//
// These keys are public by design. They are shipped to every browser that opens
// the page and there is no way to hide them, so committing them is fine. They
// are not a password. What keeps a board private is that its id is unguessable
// and that the rules deny anyone the ability to list what boards exist.
// ---------------------------------------------------------------------------

const firebaseConfig = {
  apiKey: "AIzaSyB6yBXawmHeoA6eLec66Vf_tmojJBGHU-Y",
  authDomain: "dnd-party-inventory-8861b.firebaseapp.com",
  databaseURL: "https://dnd-party-inventory-8861b-default-rtdb.europe-west1.firebasedatabase.app",
  projectId: "dnd-party-inventory-8861b",
  storageBucket: "dnd-party-inventory-8861b.firebasestorage.app",
  messagingSenderId: "466801361934",
  appId: "1:466801361934:web:80ab183c33ec16c39b685f"
};
