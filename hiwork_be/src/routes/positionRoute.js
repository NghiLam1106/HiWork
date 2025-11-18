    const express = require('express');
    const router = express.Router();

    const authMiddleware = require('../middleware/authMiddleware');

    // Import controller tương ứng (giả sử bạn đã tạo)
    const positionController = require('../controllers/position/positionController');
    // Import middleware xác thực (để bảo vệ route này)
    // const authMiddleware = require('../middleware/authMiddleware');

    // Định nghĩa các endpoint
    // GET /api/positions
    router.get('/', positionController.getAllPositions);

    // POST /api/positions (Cần đăng nhập mới được tạo)
    router.post('/them-moi', authMiddleware, positionController.createPosition);

    // GET /api/positions/:id
    router.get('/:id', positionController.getPositionById);

    // PUT /api/positions/:id
    router.put('/:id', authMiddleware, positionController.updatePosition);

    // DELETE /api/positions/:id
    router.delete('/:id', authMiddleware, positionController.deletePosition);

    module.exports = router;
