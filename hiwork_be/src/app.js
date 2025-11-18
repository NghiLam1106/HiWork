require('dotenv').config(); // Tải biến môi trường từ .env
const express = require('express');
const cors = require('cors');

// Khởi tạo Firebase
require('./config/firebaseConfig');

// Import Routes
const authRoutes = require('./routes/authRoutes');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors({ origin: true, credentials: true }));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Route test
app.get('/', (req, res) => {
    res.status(200).send("Chào mừng đến với API Firebase Express!");
});

// Route xác thực
app.use('/api/auth', authRoutes);

// Chạy server cho phép thiết bị ngoài kết nối
app.listen(PORT, '0.0.0.0', () => {
    console.log(`\n🚀 Server đang chạy trên tất cả địa chỉ mạng`);
    console.log(`➡ Localhost:       http://localhost:${PORT}`);
    console.log(`➡ Trên thiết bị khác (điện thoại/giả lập): http://<ip-máy-tính>:${PORT}`);
});
