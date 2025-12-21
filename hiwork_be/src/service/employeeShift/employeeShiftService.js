const repo = require("../../repository/employeeShift/employeeShiftRepository");

const STATUS = {
  DA_NGHI: 0,
  DANG_LAM: 1,
  NGHI_PHEP: 2,
  CHUA_DUYET: 3,
};

function isValidDateOnly(s) {
  // YYYY-MM-DD
  return typeof s === "string" && /^\d{4}-\d{2}-\d{2}$/.test(s);
}

class EmployeeShiftService {
  async create(dto) {
    const { id_employee, id_shift, work_date, status } = dto;

    if (!id_employee || !id_shift || !work_date || status === undefined || status === null)
      throw { status: 400, message: "Thiếu dữ liệu bắt buộc." };

    if (!isValidDateOnly(work_date))
      throw { status: 400, message: "work_date phải có dạng YYYY-MM-DD." };

    const st = Number(status);
    if (![0, 1, 2, 3].includes(st)) throw { status: 400, message: "status không hợp lệ." };

    // Check tồn tại FK
    if (!(await repo.existsEmployee(id_employee))) throw { status: 404, message: "Nhân viên không tồn tại." };
    if (!(await repo.existsShift(id_shift))) throw { status: 404, message: "Ca làm không tồn tại." };

    // Rule chống trùng (employee + date + shift)
    if (await repo.existsSameEmployeeDateShift({ id_employee, work_date, id_shift }))
      throw { status: 409, message: "Lịch làm đã tồn tại cho nhân viên, ngày và ca này." };

    const created = await repo.create({
      id_employee: Number(id_employee),
      id_shift: Number(id_shift),
      work_date,
      status: st,
    });

    return created;
  }

  async getById(id) {
    const record = await repo.findById(id);
    if (!record) throw { status: 404, message: "Không tìm thấy lịch làm." };
    return record;
  }

  async list(req) {
    return await repo.findAll(req);
  }

  async update(id, dto) {
    // phải tồn tại trước
    const current = await repo.findById(id);
    if (!current) throw { status: 404, message: "Không tìm thấy lịch làm." };

    const next = {
      id_employee: dto.id_employee ?? current.id_employee,
      id_shift: dto.id_shift ?? current.id_shift,
      work_date: dto.work_date ?? current.work_date,
      status: dto.status ?? current.status,
    };

    if (!isValidDateOnly(next.work_date))
      throw { status: 400, message: "work_date phải có dạng YYYY-MM-DD." };

    const st = Number(next.status);
    if (![0, 1, 2, 3].includes(st)) throw { status: 400, message: "status không hợp lệ." };

    if (!(await repo.existsEmployee(next.id_employee))) throw { status: 404, message: "Nhân viên không tồn tại." };
    if (!(await repo.existsShift(next.id_shift))) throw { status: 404, message: "Ca làm không tồn tại." };

    // chống trùng khi update
    if (await repo.existsSameEmployeeDateShift(next, id))
      throw { status: 409, message: "Lịch làm đã tồn tại cho nhân viên, ngày và ca này." };

    const affected = await repo.updateById(id, {
      id_employee: Number(next.id_employee),
      id_shift: Number(next.id_shift),
      work_date: next.work_date,
      status: st,
    });

    if (!affected) throw { status: 400, message: "Cập nhật thất bại." };
    return this.getById(id);
  }

  async remove(id) {
    const current = await repo.findById(id);
    if (!current) throw { status: 404, message: "Không tìm thấy lịch làm." };

    const deleted = await repo.deleteById(id);
    return { deleted };
  }

  get STATUS() {
    return STATUS;
  }
}

module.exports = new EmployeeShiftService();
