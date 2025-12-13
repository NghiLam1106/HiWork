const {
  employee: Employee,
  user: User,
  position: Position,
} = require("../../models");

class EmployeeRepository {
  // Lấy danh sách nhân viên có phân trang
  async getAllEmployees(req) {
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const offset = (page - 1) * limit;

    const rawRole = req.query.role;
    const roleQuery = rawRole !== undefined ? parseInt(rawRole) : null;

    const roleMap = { 0: 1, 1: 2 };
    const roleFilter =
      roleQuery !== null ? roleMap[roleQuery] ?? roleQuery : null;

    const userInclude = {
      model: User,
      as: "user",
      attributes: ["email"],
      ...(roleFilter !== null ? { where: { role: roleFilter } } : {}),
    };

    const { count, rows } = await Employee.findAndCountAll({
      limit,
      offset,
      order: [["createdAt", "ASC"]],
      include: [
        userInclude,
        {
          model: Position,
          as: "position",
          attributes: ["name"], // lấy tên vị trí
        },
      ],
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

  // ✏️ Cập nhật thông tin người dùng theo ID
  async updateById(userId, updateData) {
    return await Employee.update(updateData, {
      where: { id: userId },
    });
  }

  // Tìm nhân viên theo ID
  async findById(id) {
    // return await Employee.findByPk(id);
    return await Employee.findOne({
      where: { id: id },
      include: [
        { model: User, as: "user", attributes: ["email", "role"] },
        { model: Position, as: "position", attributes: ["name"] },
      ],
    });
  }

  // Cập nhật nhân viên
  async save(employee) {
    return await employee.save();
  }

  // Xóa nhân viên
  async delete(employee) {
    return await employee.destroy();
  }
}

module.exports = new EmployeeRepository();
