// routes/shift.routes.js
const express = require('express');
const router = express.Router();

const authMiddleware = require('../middleware/authMiddleware');
const shiftController = require('../controllers/shifts/shiftsController');

// ----------------------------
// SHIFT ROUTES
// ----------------------------

// Lấy danh sách tất cả ca làm
router.get('/', shiftController.getAllShifts);

// Tạo ca làm mới (Yêu cầu đăng nhập)
router.post('/them-moi', authMiddleware, shiftController.createShift);

// Lấy chi tiết 1 ca làm theo ID
router.get('/:id', shiftController.getShiftById);

// Cập nhật ca làm theo ID
router.put('/:id', authMiddleware, shiftController.updateShift);

// Xóa ca làm theo ID
router.delete('/:id', authMiddleware, shiftController.deleteShift);

module.exports = router;
