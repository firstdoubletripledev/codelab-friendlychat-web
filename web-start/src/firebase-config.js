/**
 * To find your Firebase config object:
 * 
 * 1. Go to your [Project settings in the Firebase console](https://console.firebase.google.com/project/_/settings/general/)
 * 2. In the "Your apps" card, select the nickname of the app for which you need a config object.
 * 3. Select Config from the Firebase SDK snippet pane.
 * 4. Copy the config object snippet, then add it here.
 */
const config = {
    apiKey: "AIzaSyChwYSIK3WXr_xJm3gFqk8lAJS6NKxTZrk",
    authDomain: "friendlychat-afc4a.firebaseapp.com",
    projectId: "friendlychat-afc4a",
    storageBucket: "friendlychat-afc4a.appspot.com",
    messagingSenderId: "22193482612",
    appId: "1:22193482612:web:183b458a266f3817351a21",
    measurementId: "G-HGPVZPB164"
};

export function getFirebaseConfig() {
    if (!config || !config.apiKey) {
        throw new Error('No Firebase configuration object provided.' + '\n' +
            'Add your web app\'s configuration object to firebase-config.js');
    } else {
        return config;
    }
}