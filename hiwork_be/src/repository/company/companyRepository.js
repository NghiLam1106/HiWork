const { company: Company } = require("../../models");

class CompanyRepository {
  // Lấy tất cả
  async getAllCompanies(req) {
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const offset = (page - 1) * limit;

    const { count, rows } = await Company.findAndCountAll({
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
    return await Company.findOne({ where: { name } });
  }

  // Tìm theo ID
  async findById(id) {
    return await Company.findByPk(id);
  }

  // Tạo mới
  async create(data) {
    return await Company.create(data);
  }

  // Xóa
  async delete(company) {
    return await company.destroy();
  }

  // Lưu cập nhật
  async save(company) {
    return await company.save();
  }
}

module.exports = new CompanyRepository();
