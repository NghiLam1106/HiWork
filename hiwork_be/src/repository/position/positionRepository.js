const { position: Position } = require("../../models");

class PositionRepository {
  // Lấy tất cả
  async getAllPositions(req) {
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const offset = (page - 1) * limit;

    const { count, rows } = await Position.findAndCountAll({
      limit,
      offset,
      order: [["createdAt", "ASC"]],
    });

    return {
      data: rows,
      pagination: {
        totalItems: count,
        currentPage: page,
        totalPages: Math.ceil(count / limit),
        pageSize: limit,
      },
    };
  }

  // Tìm theo tên
  async findByName(name) {
    return await Position.findOne({ where: { name } });
  }

  // Tìm theo ID
  async findById(id) {
    return await Position.findByPk(id);
  }

  // Tạo mới
  async create(data) {
    return await Position.create(data);
  }

  // Xóa
  async delete(position) {
    return await position.destroy();
  }

  // Lưu cập nhật
  async save(position) {
    return await position.save();
  }
}

module.exports = new PositionRepository();
