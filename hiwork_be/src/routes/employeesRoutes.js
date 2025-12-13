const express = require('express');
const router = express.Router();

const authMiddleware = require('../middleware/authMiddleware');
const employeeController = require('../controllers/employees/employeeController');

// ----------------------------
// EMPLOYEE ROUTES
// ----------------------------

// Lấy danh sách tất cả nhân viên (hỗ trợ phân trang)
router.get('/', employeeController.getAllEmployees);

// Lấy chi tiết 1 nhân viên theo ID
router.get('/:id', employeeController.getEmployeeById);

// Cập nhật nhân viên theo ID (có bảo vệ)
router.put('/:id', authMiddleware, employeeController.updateEmployee);

// Xóa nhân viên theo ID (có bảo vệ)
router.delete('/:id', authMiddleware, employeeController.deleteEmployee);

module.exports = router;
