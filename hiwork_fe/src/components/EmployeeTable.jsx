import React from "react";

const EmployeeTable = () => {
  const employees = [
    { id: 1, name: "Nguyễn Văn A", department: "IT", status: "Đang làm" },
    { id: 2, name: "Trần Thị B", department: "HR", status: "Nghỉ phép" },
    { id: 3, name: "Lê Văn C", department: "Sales", status: "Đang làm" },
  ];

  return (
    <div className="employee-table">
      <h2>Danh sách nhân viên</h2>
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Tên</th>
            <th>Phòng ban</th>
            <th>Trạng thái</th>
          </tr>
        </thead>
        <tbody>
          {employees.map(emp => (
            <tr key={emp.id}>
              <td>{emp.id}</td>
              <td>{emp.name}</td>
              <td>{emp.department}</td>
              <td>{emp.status}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default EmployeeTable;
