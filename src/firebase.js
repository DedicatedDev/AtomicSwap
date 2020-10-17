import * as firebase from "firebase/app";
import 'firebase/firestore'
import "firebase/auth";

const config = {
    apiKey: "AIzaSyAPaaIi2OUJrpQx24tJME6yih1Hh34I7Uo",
    authDomain: "gymcall-9cbc4.firebaseapp.com",
    databaseURL: "https://gymcall-9cbc4.firebaseio.com",
    projectId: "gymcall-9cbc4",
    storageBucket: "gymcall-9cbc4.appspot.com",
    messagingSenderId: "1074616736329",
    appId: "1:1074616736329:web:aec35f2680108b3909bd98",
    measurementId: "G-79312LKHM8"
}

firebase.initializeApp(config);

export default firebase