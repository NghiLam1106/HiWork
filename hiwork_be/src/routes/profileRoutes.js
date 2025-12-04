const express = require("express");
const router = express.Router();

const authMiddleware = require("../middleware/authMiddleware");
const uploadAvatar = require("../middleware/uploadAvatar");
const profileController = require("../controllers/profile/profileController");

// Lấy thông tin cá nhân từ token người dùng
router.get("/:id", authMiddleware, profileController.getProfile);

// Cập nhật thông tin cá nhân
router.put("/:id", authMiddleware, profileController.updateProfile);

// Cập nhật avatar người dùng
router.put("/:id/avatar", authMiddleware, uploadAvatar.single("avatar"), profileController.updateAvatar);
module.exports = router;
