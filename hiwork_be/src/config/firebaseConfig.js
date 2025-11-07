const admin = require('firebase-admin');
const { initializeApp, cert } = require('firebase-admin/app');
const { getAuth } = require('firebase-admin/auth');
const serviceAccount = require('../../serviceAccountKey.json');

let app;

try {
    if (admin.apps.length === 0) {   // CHỈ INIT KHI CHƯA CÓ APP
        app = initializeApp({
            credential: cert(serviceAccount),
        });
        console.log("✅ Firebase Admin SDK đã khởi tạo");
    } else {
        app = admin.app();
    }
} catch (err) {
    console.error("❌ Lỗi khởi tạo Firebase:", err);
}

const auth = getAuth(app);

module.exports = { auth, admin };
