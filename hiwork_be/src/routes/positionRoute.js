// routes/position.routes.js
const express = require('express');
const router = express.Router();

const authMiddleware = require('../middleware/authMiddleware');
const positionController = require('../controllers/position/positionController');

// ----------------------------
// POSITION ROUTES
// ----------------------------

// Lấy danh sách tất cả vị trí
router.get('/', positionController.getAllPositions);

// Tạo vị trí mới (Yêu cầu đăng nhập)
router.post('/them-moi', authMiddleware, positionController.createPosition);

// Lấy chi tiết một vị trí theo ID
router.get('/:id', positionController.getPositionById);

// Cập nhật vị trí theo ID
router.put('/:id', authMiddleware, positionController.updatePosition);

// Xóa vị trí theo ID
router.delete('/:id', authMiddleware, positionController.deletePosition);

module.exports = router;
