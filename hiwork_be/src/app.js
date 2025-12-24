require('dotenv').config(); // Tải biến môi trường từ .env
const express = require('express');
const cors = require('cors');

// Khởi tạo Firebase
require('./config/firebaseConfig');

// Khởi tạo Cloudinary
require('./config/cloudinaryConfig');

// Import Routes
const authRoutes = require('./routes/authRoutes');
const positionRoutes = require('./routes/positionRoute');
const shiftsRoutes = require('./routes/shiftsRoutes');
const profileRoutes = require('./routes/profileRoutes');
const emmployeesRoutes = require('./routes/employeesRoutes');
const companyRoutes = require('./routes/companyRoutes');
const employeeShiftRoutes = require('./routes/employeeShift');
const attendanceRoutes = require('./routes/attendanceRoutes');

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
app.use('/api/manager/auth', authRoutes);

app.use('/api/manager/positions', positionRoutes);

app.use('/api/manager/shifts', shiftsRoutes);

app.use('/api/manager/profile', profileRoutes);

app.use('/api/manager/employees', emmployeesRoutes);

app.use('/api/manager/companies', companyRoutes);

app.use('/api/manager/employee-shifts', employeeShiftRoutes);

app.use('/api/manager/cham-cong', attendanceRoutes);

// Route user
app.use('/api/user/auth', authRoutes);

app.use('/api/user/lich-lam-viec', employeeShiftRoutes);

app.use('/api/user/cham-cong', attendanceRoutes);

app.use('/api/user/profile', profileRoutes);

// Route admin
app.use('/api/admin/employees', emmployeesRoutes);

// Chạy server cho phép thiết bị ngoài kết nối
app.listen(PORT, '0.0.0.0', () => {
    console.log(`\n🚀 Server đang chạy trên tất cả địa chỉ mạng`);
    console.log(`➡ Localhost:       http://localhost:${PORT}`);
    console.log(`➡ Trên thiết bị khác (điện thoại/giả lập): http://<ip-máy-tính>:${PORT}`);
});
