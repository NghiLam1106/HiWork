const { shift } = require("../../models");

class ShiftRepository {
  async getAll(req) {
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const offset = (page - 1) * limit;

    const { count, rows } = await shift.findAndCountAll({
      limit,
      offset,
      order: [["createdAt", "DESC"]], // sắp xếp theo createdAt giảm dần
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

  async getById(id) {
    return shift.findByPk(id);
  }

  async create(data) {
    return shift.create(data);
  }

  async update(id, data) {
    return shift.update(data, { where: { id } });
  }

  async delete(id) {
    return shift.destroy({ where: { id } });
  }
}

module.exports = new ShiftRepository();
