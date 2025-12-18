// routes/company.routes.js
const express = require('express');
const router = express.Router();

const authMiddleware = require('../middleware/authMiddleware');
const companyController = require('../controllers/company/companyController');

// ----------------------------
// COMPANY ROUTES
// ----------------------------

// Lấy danh sách tất cả công ty
router.get('/', companyController.getAllCompanies);

// Tạo công ty mới (Yêu cầu đăng nhập)
router.post('/them-moi', authMiddleware, companyController.createCompany);

// Lấy chi tiết một công ty theo ID
router.get('/:id', companyController.getCompanyById);

// Cập nhật công ty theo ID
router.put('/:id', authMiddleware, companyController.updateCompany);

// Xóa công ty theo ID
router.delete('/:id', authMiddleware, companyController.deleteCompany);
module.exports = router;
