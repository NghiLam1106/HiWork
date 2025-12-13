const employeeRepository = require("../../repository/employees/employeeRepository");

class EmployeeService {
  // Lấy danh sách nhân viên (có phân trang)
  async getAllEmployees(req) {
    return await employeeRepository.getAllEmployees(req);
  }

  // Lấy nhân viên theo ID
  async getEmployeeById(id) {
    const employee = await employeeRepository.findById(id);
    if (!employee) {
      throw new Error("Không tìm thấy nhân viên.");
    }
    return employee;
  }

  // Cập nhật thông tin nhân viên
  async updateEmployee(id, updateData) {
    const employee = await employeeRepository.findById(id);

    if (!employee) {
      throw new Error("Không tìm thấy nhân viên.");
    }

    const updatedEmployee = await employeeRepository.updateById(id, updateData);
    return updatedEmployee;
  }

  // Xóa nhân viên
  async deleteEmployee(id) {
    const employee = await employeeRepository.findById(id);

    if (!employee) {
      throw new Error("Không tìm thấy nhân viên.");
    }

    await employeeRepository.delete(employee);
    return employee;
  }
}

module.exports = new EmployeeService();
