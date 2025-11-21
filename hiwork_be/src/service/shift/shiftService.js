// services/shiftService.js
const shiftRepository = require('../../repository/shift/shiftRepository');

class ShiftService {
  async getAllShifts(req) {
    return await shiftRepository.getAll(req);
  }

  async getShiftById(id) {
    const shift = await shiftRepository.getById(id);
    if (!shift) throw new Error('Không tìm thấy ca làm.');
    return shift;
  }

  async createShift(data) {
    // Validate nghiệp vụ cơ bản
    if (!data.name || !data.startTime || !data.endTime) {
      throw new Error('Vui lòng nhập đầy đủ thông tin ca làm.');
    }

    // startTime < endTime
    if (data.startTime >= data.endTime) {
      throw new Error('Giờ bắt đầu phải bé hơn giờ kết thúc.');
    }

    return await shiftRepository.create(data);
  }

  async updateShift(id, data) {
    const shift = await shiftRepository.getById(id);
    if (!shift) throw new Error('Không tìm thấy ca làm.');

    if (data.startTime && data.endTime && data.startTime >= data.endTime) {
      throw new Error('Giờ bắt đầu phải bé hơn giờ kết thúc.');
    }

    await shiftRepository.update(id, data);
    return await shiftRepository.getById(id);
  }

  async deleteShift(id) {
    const shift = await shiftRepository.getById(id);
    if (!shift) throw new Error('Không tìm thấy ca làm.');

    await shiftRepository.delete(id);
    return true;
  }
}

module.exports = new ShiftService();
