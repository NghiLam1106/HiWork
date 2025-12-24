const service = require("../../service/employeeShift/employeeShiftService");

function handleError(res, err) {
  const status = err?.status || 500;
  const message = err?.message || "Lỗi hệ thống.";
  return res.status(status).json({ message });
}

class EmployeeShiftController {
  async create(req, res) {
    try {
      const created = await service.create(req.body);
      return res
        .status(201)
        .json({ message: "Tạo lịch làm thành công.", data: created });
    } catch (err) {
      return handleError(res, err);
    }
  }

  async list(req, res) {
    try {
      const result = await service.list(req);
      return res.status(200).json({ ...result });
    } catch (err) {
      return handleError(res, err);
    }
  }

  async detail(req, res) {
    try {
      const data = await service.getById(req.params.id);
      return res.status(200).json({ message: "OK", data });
    } catch (err) {
      return handleError(res, err);
    }
  }

  async update(req, res) {
    try {
      const data = await service.update(req.params.id, req.body);
      return res.status(200).json({ message: "Cập nhật thành công.", data });
    } catch (err) {
      return handleError(res, err);
    }
  }

  async remove(req, res) {
    try {
      const data = await service.remove(req.params.id);
      return res.status(200).json({ message: "Xóa thành công.", data });
    } catch (err) {
      return handleError(res, err);
    }
  }

  async listByEmployee(req, res) {
    try {
      const result = await service.listByEmployee(req);
      return res.status(200).json(result);
    } catch (err) {
      return handleError(res, err);
    }
  }
}

module.exports = new EmployeeShiftController();
