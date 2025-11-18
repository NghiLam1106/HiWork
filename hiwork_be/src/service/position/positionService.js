const positionRepository = require("../../repository/position/positionRepository");

class PositionService {
  // Lấy tất cả vị trí
  async getAllPositions(req) {
    return await positionRepository.getAllPositions(req);
  }

  // Tạo mới vị trí
  async createPosition(name) {
    if (!name || name.trim() === "") {
      throw new Error("Tên chức vụ không được để trống.");
    }

    const exist = await positionRepository.findByName(name);
    if (exist) {
      throw new Error("Chức vụ này đã tồn tại.");
    }

    return await positionRepository.create({ name });
  }

  // Cập nhật vị trí
  async updatePosition(id, name) {
    const position = await positionRepository.findById(id);
    if (!position) {
      throw new Error("Không tìm thấy chức vụ.");
    }

    position.name = name;
    return await positionRepository.save(position);
  }

  // Xóa vị trí
  async deletePosition(id) {
    const position = await positionRepository.findById(id);
    if (!position) {
      throw new Error("Không tìm thấy chức vụ.");
    }

    await positionRepository.delete(position);
    return position;
  }

  // Lấy vị trí theo ID
  async getPositionById(id) {
    return await positionRepository.findById(id);
  }
}

module.exports = new PositionService();
