const express = require("express");
const router = express.Router();

const authMiddleware = require("../middleware/authMiddleware");
const attendanceController = require("../controllers/attendance/attendanceController");

router.get("/", attendanceController.list);
router.get("/:id", attendanceController.detail);
router.post("/", authMiddleware, attendanceController.create);
router.put("/:id", authMiddleware, attendanceController.update);
router.delete("/:id", authMiddleware, attendanceController.remove);

module.exports = router;
