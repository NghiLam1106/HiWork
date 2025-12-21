const {
  attendances: Attendances,
  employeeSchedule: EmployeeSchedule,
  employee: Employee,
  shift: Shift,
} = require("../../models");
const { Op } = require("sequelize");

class AttendanceRepository {
  async create(data, options = {}) {
    return Attendances.create(data, options);
  }

  async findById(id) {
    const pk = Number(id);
    return  Attendances.findByPk(pk, {
      include: [
        {
          model: EmployeeSchedule,
          as: "employeeSchedule",
          attributes: ["id", "id_employee", "id_shift", "work_date", "status"],
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
        },
      ],
    });
  }

  async findAll(req) {
    const page = parseInt(req.query.page, 10) || 1;
    const limit = parseInt(req.query.limit, 10) || 10;
    const offset = (page - 1) * limit;

    const { count, rows } = await Attendances.findAndCountAll({
      include: [
        {
          model: EmployeeSchedule,
          as: "employeeSchedule",
          attributes: ["id", "id_employee", "id_shift", "work_date", "status"],
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
        },
      ],
      order: [
        ["checkIn", "DESC"],
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
    const [affected] = await Attendances.update(data, {
      where: { id: Number(id) },
    });
    return affected;
  }

  async deleteById(id) {
    return Attendances.destroy({ where: { id: Number(id) } });
  }

  // --- helper checks ---
  async existsEmployeeSchedule(id_EmployeeShift) {
    const found = await EmployeeSchedule.findByPk(Number(id_EmployeeShift), {
      attributes: ["id"],
    });
    return !!found;
  }

  async existsByEmployeeSchedule(id_EmployeeShift, excludeId = null) {
    const where = { id_EmployeeShift: Number(id_EmployeeShift) };

    if (excludeId !== null && excludeId !== undefined) {
      where.id = { [Op.ne]: Number(excludeId) };
    }

    const found = await Attendances.findOne({ where, attributes: ["id"] });
    return !!found;
  }
}

module.exports = new AttendanceRepository();
