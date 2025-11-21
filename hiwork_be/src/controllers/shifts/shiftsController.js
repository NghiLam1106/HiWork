// controllers/shift/shiftController.js
const shiftService = require('../../service/shift/shiftService');

class ShiftController {
  async getAllShifts(req, res) {
    try {
      const shifts = await shiftService.getAllShifts(req);
      res.status(200).json(shifts);
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  }

  async getShiftById(req, res) {
    try {
      const shift = await shiftService.getShiftById(req.params.id);
      res.status(200).json(shift);
    } catch (err) {
      res.status(404).json({ message: err.message });
    }
  }

  async createShift(req, res) {
    try {
      const newShift = await shiftService.createShift(req.body);
      res.status(201).json({
        message: 'Tạo ca làm thành công.',
        data: newShift,
      });
    } catch (err) {
      res.status(400).json({ message: err.message });
    }
  }

  async updateShift(req, res) {
    try {
      const updatedShift = await shiftService.updateShift(
        req.params.id,
        req.body
      );
      res.status(200).json({
        message: 'Cập nhật ca làm thành công.',
        data: updatedShift,
      });
    } catch (err) {
      res.status(400).json({ message: err.message });
    }
  }

  async deleteShift(req, res) {
    try {
      await shiftService.deleteShift(req.params.id);
      res.status(200).json({ message: 'Xóa ca làm thành công.' });
    } catch (err) {
      res.status(400).json({ message: err.message });
    }
  }
}

module.exports = new ShiftController();
