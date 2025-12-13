const employeeService = require("../../service/employees/employeeService");

const employeeController = {
  // Lấy danh sách nhân viên có phân trang
  async getAllEmployees(req, res) {
    try {
      const result = await employeeService.getAllEmployees(req);

      return res.status(200).json(result);
    } catch (error) {
      console.error(error);
      return res.status(500).json({
        message: "Lỗi server khi lấy danh sách nhân viên",
      });
    }
  },
  
  // Lấy chi tiết 1 nhân viên
  async getEmployeeById(req, res) {
    try {
      const id = req.params.id;
      const employee = await employeeService.getEmployeeById(id);

      return res.json({ employee });
    } catch (error) {
      console.error(error);

      if (error.message === "NOT_FOUND") {
        return res.status(404).json({
          message: "Không tìm thấy nhân viên",
        });
      }

      return res.status(500).json({
        message: "Lỗi server khi lấy thông tin nhân viên",
      });
    }
  },

  // Cập nhật thông tin nhân viên
  async updateEmployee(req, res) {
    try {
      const id = Number(req.params.id);
      const data = req.body;

      const updatedEmployee = await employeeService.updateEmployee(id, data);

      return res.json({
        message: "Cập nhật nhân viên thành công",
        employee: updatedEmployee,
      });
    } catch (error) {
      console.error(error);

      if (error.message === "NOT_FOUND") {
        return res.status(404).json({
          message: "Không tìm thấy nhân viên",
        });
      }

      return res.status(500).json({
        message: "Lỗi server khi cập nhật nhân viên",
      });
    }
  },

  // Xóa nhân viên
  async deleteEmployee(req, res) {
    try {
      const id = req.params.id;

      await employeeService.deleteEmployee(id);

      return res.json({
        message: "Xóa nhân viên thành công",
      });
    } catch (error) {
      console.error(error);

      if (error.message === "NOT_FOUND") {
        return res.status(404).json({
          message: "Không tìm thấy nhân viên",
        });
      }

      return res.status(500).json({
        message: "Lỗi server khi xóa nhân viên",
      });
    }
  },
};

module.exports = employeeController;
