// ---------------------------------------------------------------------------
// Live sharing. This is the only file you need to edit.
//
// Leave it as it is and the app runs entirely in this browser: every board is
// private to the machine it was made on, nothing is sent anywhere, and the page
// makes no external requests at all.
//
// Paste a Firebase config below and boards become live — everyone holding a
// board's link sees the same inventory, and changes appear on every screen as
// they happen.
//
//   1. console.firebase.google.com → Add project (no billing needed).
//   2. Build → Realtime Database → Create database. Pick a region near you and
//      choose "Start in locked mode".
//   3. Rules tab → paste the contents of firebase-rules.json → Publish.
//   4. Project settings → Your apps → Web (</>) → register an app.
//   5. Copy the config object it shows you and paste it in below.
//
// Make sure the object includes databaseURL — it looks like
// https://<project>-default-rtdb.<region>.firebasedatabase.app — and add it by
// hand from the Realtime Database page if the console left it out.
//
// These keys are public by design: they are shipped to every browser that opens
// the page, and there is no way to hide them. They are not a password. What
// keeps a board private is that its id is unguessable, and that the rules deny
// anyone the ability to list what boards exist. See the README.
// ---------------------------------------------------------------------------

const FIREBASE_CONFIG = null;

/*  Replace the line above with your own, like this:

const FIREBASE_CONFIG = {
  apiKey: "AIzaSyExampleExampleExampleExampleExample",
  authDomain: "my-party-inventory.firebaseapp.com",
  databaseURL: "https://my-party-inventory-default-rtdb.europe-west1.firebasedatabase.app",
  projectId: "my-party-inventory",
  appId: "1:123456789012:web:0123456789abcdef",
};

*/
