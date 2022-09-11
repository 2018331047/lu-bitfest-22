// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyCFVCofwPy4KMJOVlP6aYX2TIoXSUU_nCs",
  authDomain: "bus-management-f5706.firebaseapp.com",
  projectId: "bus-management-f5706",
  storageBucket: "bus-management-f5706.appspot.com",
  messagingSenderId: "235467325200",
  appId: "1:235467325200:web:2df56118a5fe8b11936f95",
};

// Initialize Firebase
export const app = initializeApp(firebaseConfig);
export const database = getFirestore(app);
