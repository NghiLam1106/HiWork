const express = require("express");
const router = express.Router();

const authMiddleware = require("../middleware/authMiddleware");
const employeeShiftController = require("../controllers/employeeShift/employeeShiftController");

router.get("/", employeeShiftController.list);
router.get("/:id", employeeShiftController.detail);
router.post("/", authMiddleware, employeeShiftController.create);
router.put("/:id", authMiddleware, employeeShiftController.update);
router.delete("/:id", authMiddleware, employeeShiftController.remove);

module.exports = router;
