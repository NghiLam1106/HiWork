// routes/authRoutes.js
const express = require('express');
const router = express.Router();
const authController = require('../controllers/auth/authController');

// Route Đăng ký: Kiểm tra input trước khi xử lý
router.post('/register', authController.register);

// Route Đăng nhập
router.post('/login', authController.login);

module.exports = router;
