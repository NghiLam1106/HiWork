import { Link } from "react-router-dom";

const EmployeeTable = () => {
  const employees = [
    { id: 1, name: "Nguyễn Văn A", department: "IT", status: "Đang làm" },
    { id: 2, name: "Trần Thị B", department: "HR", status: "Nghỉ phép" },
    { id: 3, name: "Lê Văn C", department: "Sales", status: "Đang làm" },
  ];

  return (
    <div className="employee-table">
      <h2>Danh sách nhân viên</h2>
      <table className="table table-hover text-center align-middle">
        <thead>
          <tr>
            <th scope="col">STT</th>
            <th scope="col">Tên</th>
            <th scope="col">Vị trí</th>
            <th scope="col">Trạng thái</th>
            <th scope="col"></th>
          </tr>
        </thead>
        <tbody>
          {employees.map((emp) => (
            <tr key={emp.id}>
              <th>{emp.id}</th>
              <td>{emp.name}</td>
              <td>{emp.department}</td>
              <td>{emp.status}</td>
              {/* Cột button cần xử lý riêng vì đang dùng d-flex */}
              <td>
                <div className="d-flex justify-content-center gap-2">
                  <Link
                    to={`/nhan-vien/${emp.id}`} // Đường dẫn kèm ID nhân viên
                    className="btn btn-primary btn-sm"
                  >
                    Xem chi tiết
                  </Link>
                  <Link
                    to={`/nhan-vien/${emp.id}`} // Đường dẫn kèm ID nhân viên
                    className="btn btn-danger btn-sm"
                  >
                    Xóa
                  </Link>
                </div>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default EmployeeTable;
