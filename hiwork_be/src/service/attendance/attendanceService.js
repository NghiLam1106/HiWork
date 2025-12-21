const repo = require("../../repository/attendance/attendanceRepository");

const STATUS = {
  DA_NGHI: 0,
  DANG_LAM: 1,
  NGHI_PHEP: 2,
  CHUA_DUYET: 3,
};

function isValidDateTime(s) {
  if (!s) return false;
  const d = new Date(s);
  return !Number.isNaN(d.getTime());
}

function toDate(s) {
  return s ? new Date(s) : null;
}

function isValidStatus(s) {
  const n = Number(s);
  return Number.isInteger(n) && [0, 1, 2, 3].includes(n);
}

class AttendanceService {
  async create(dto) {
    const {
      id_EmployeeShift,
      checkIn,
      checkOut,
      photoUrl,
      confidenceScore,
      status,
    } = dto;

    // required
    if (!id_EmployeeShift || !checkIn || status === undefined || status === null)
      throw { status: 400, message: "Thiếu dữ liệu bắt buộc." };

    // validate status (int)
    if (!isValidStatus(status))
      throw { status: 400, message: "status không hợp lệ (0-3)." };

    const st = Number(status);

    // validate datetime
    if (!isValidDateTime(checkIn))
      throw { status: 400, message: "checkIn không đúng định dạng datetime." };

    if (checkOut && !isValidDateTime(checkOut))
      throw { status: 400, message: "checkOut không đúng định dạng datetime." };

    const checkInDate = toDate(checkIn);
    const checkOutDate = toDate(checkOut);

    if (checkOutDate && checkOutDate < checkInDate)
      throw { status: 400, message: "checkOut phải >= checkIn." };

    // confidenceScore (0..1)
    if (confidenceScore !== undefined && confidenceScore !== null) {
      const cs = Number(confidenceScore);
      if (Number.isNaN(cs))
        throw { status: 400, message: "confidenceScore phải là số." };
      if (cs < 0 || cs > 1)
        throw {
          status: 400,
          message: "confidenceScore phải nằm trong khoảng 0..1.",
        };
    }

    // Check FK: employeeSchedule tồn tại không?
    if (!(await repo.existsEmployeeSchedule(id_EmployeeShift)))
      throw {
        status: 404,
        message: "Lịch làm (EmployeeShift) không tồn tại.",
      };

    // Rule chống trùng: 1 lịch làm chỉ có 1 attendance
    if (await repo.existsByEmployeeSchedule(id_EmployeeShift))
      throw { status: 409, message: "Attendance đã tồn tại cho lịch làm này." };

    const created = await repo.create({
      id_EmployeeShift: Number(id_EmployeeShift),
      checkIn: checkInDate,
      checkOut: checkOutDate,
      photoUrl: photoUrl || null,
      confidenceScore:
        confidenceScore === undefined || confidenceScore === null
          ? null
          : Number(confidenceScore),
      status: st, // ✅ int
    });

    return created;
  }

  async getById(id) {
    const record = await repo.findById(id);
    if (!record) throw { status: 404, message: "Không tìm thấy attendance." };
    return record;
  }

  async list(req) {
    return await repo.findAll(req);
  }

  async update(id, dto) {
    const current = await repo.findById(id);
    if (!current) throw { status: 404, message: "Không tìm thấy attendance." };

    const next = {
      id_EmployeeShift: dto.id_EmployeeShift ?? current.id_EmployeeShift,
      checkIn: dto.checkIn ?? current.checkIn,
      checkOut: dto.checkOut ?? current.checkOut,
      photoUrl: dto.photoUrl ?? current.photoUrl,
      confidenceScore: dto.confidenceScore ?? current.confidenceScore,
      status: dto.status ?? current.status,
    };

    if (!next.id_EmployeeShift || !next.checkIn || next.status === undefined || next.status === null)
      throw { status: 400, message: "Thiếu dữ liệu bắt buộc." };

    if (!isValidStatus(next.status))
      throw { status: 400, message: "status không hợp lệ (0-3)." };

    const st = Number(next.status);

    if (!isValidDateTime(next.checkIn))
      throw { status: 400, message: "checkIn không đúng định dạng datetime." };

    if (next.checkOut && !isValidDateTime(next.checkOut))
      throw { status: 400, message: "checkOut không đúng định dạng datetime." };

    const checkInDate = toDate(next.checkIn);
    const checkOutDate = toDate(next.checkOut);

    if (checkOutDate && checkOutDate < checkInDate)
      throw { status: 400, message: "checkOut phải >= checkIn." };

    if (next.confidenceScore !== undefined && next.confidenceScore !== null) {
      const cs = Number(next.confidenceScore);
      if (Number.isNaN(cs))
        throw { status: 400, message: "confidenceScore phải là số." };
      if (cs < 0 || cs > 1)
        throw {
          status: 400,
          message: "confidenceScore phải nằm trong khoảng 0..1.",
        };
    }

    if (!(await repo.existsEmployeeSchedule(next.id_EmployeeShift)))
      throw {
        status: 404,
        message: "Lịch làm (EmployeeShift) không tồn tại.",
      };

    if (await repo.existsByEmployeeSchedule(next.id_EmployeeShift, id))
      throw { status: 409, message: "Attendance đã tồn tại cho lịch làm này." };

    const affected = await repo.updateById(id, {
      id_EmployeeShift: Number(next.id_EmployeeShift),
      checkIn: checkInDate,
      checkOut: checkOutDate,
      photoUrl: next.photoUrl || null,
      confidenceScore:
        next.confidenceScore === undefined || next.confidenceScore === null
          ? null
          : Number(next.confidenceScore),
      status: st, // ✅ int
    });

    if (!affected) throw { status: 400, message: "Cập nhật thất bại." };
    return this.getById(id);
  }

  async remove(id) {
    const current = await repo.findById(id);
    if (!current) throw { status: 404, message: "Không tìm thấy attendance." };

    const deleted = await repo.deleteById(id);
    return { deleted };
  }

  get STATUS() {
    return STATUS;
  }
}

module.exports = new AttendanceService();
