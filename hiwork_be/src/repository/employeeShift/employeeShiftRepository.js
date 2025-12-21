const {
  employeeSchedule: EmployeeSchedule,
  employee: Employee,
  shift: Shift,
} = require("../../models");
const { Op } = require("sequelize");


class EmployeeScheduleRepository {
  async create(data, options = {}) {
    return EmployeeSchedule.create(data, options);
  }

  async findById(id) {
    const pk = Number(id);
    return EmployeeSchedule.findByPk(pk, {
      include: [
        {
          model: Employee,
          as: "employee",
          attributes: ["id", "name", "avatar_url"],
        },
        {
          model: Shift,
          as: "shift",
          attributes: ["id", "name", "startTime", "endTime"],
        },
      ],
    });
  }

  async findAll(req) {
    const page = parseInt(req.query.page, 10) || 1;
    const limit = parseInt(req.query.limit, 10) || 10;
    const offset = (page - 1) * limit;

    const { count, rows } = await EmployeeSchedule.findAndCountAll({
      include: [
        {
          model: Employee,
          as: "employee",
          attributes: ["id", "name", "avatar_url"],
        },
        {
          model: Shift,
          as: "shift",
          attributes: ["id", "name", "startTime", "endTime"],
        },
      ],
      order: [
        ["work_date", "DESC"],
        ["id", "DESC"],
      ],
      limit,
      offset,
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

  async updateById(id, data) {
    const [affected] = await EmployeeSchedule.update(data, {
      where: { id: Number(id) },
    });
    return affected; // số dòng update
  }

  async deleteById(id) {
    return EmployeeSchedule.destroy({ where: { id: Number(id) } });
  }

  // Chặn trùng lịch (tuỳ rule của bạn)
  async existsSameEmployeeDateShift(
    { id_employee, work_date, id_shift },
    excludeId = null
  ) {
    const where = {
      id_employee: Number(id_employee),
      work_date, // 'YYYY-MM-DD'
      id_shift: Number(id_shift),
    };

    // Khi update: loại trừ chính bản ghi đang sửa
    if (excludeId !== null && excludeId !== undefined) {
      where.id = { [Op.ne]: Number(excludeId) };
    }

    const found = await EmployeeSchedule.findOne({
      where,
      attributes: ["id"],
    });

    return !!found; // true = đã có đúng ca đó trong ngày đó -> không cho thêm
  }

  async existsEmployee(id_employee) {
    const emp = await Employee.findByPk(Number(id_employee), {
      attributes: ["id"],
    });
    return !!emp;
  }

  async existsShift(id_shift) {
    const sh = await Shift.findByPk(Number(id_shift), { attributes: ["id"] });
    return !!sh;
  }
}

module.exports = new EmployeeScheduleRepository();
