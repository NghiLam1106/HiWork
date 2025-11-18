import { Link } from "react-router-dom";
import { FaEdit, FaTrashAlt, FaEye, FaPlus } from "react-icons/fa";

const EmployeeTable = () => {
  const employees = [
    {
      id: 1,
      name: "Nguyễn Văn A",
      email: "vana@company.com",
      department: "IT",
      role: "Developer",
      status: "Active",
    },
    {
      id: 2,
      name: "Trần Thị B",
      email: "thib@company.com",
      department: "HR",
      role: "Recruiter",
      status: "OnLeave",
    },
    {
      id: 3,
      name: "Lê Văn C",
      email: "vanc@company.com",
      department: "Sales",
      role: "Manager",
      status: "Inactive",
    },
    {
      id: 4,
      name: "Phạm Thu D",
      email: "thud@company.com",
      department: "Marketing",
      role: "Designer",
      status: "Active",
    },
  ];

  const getStatusBadge = (status) => {
    switch (status) {
      case "Active":
        return (
          <span className="badge rounded-pill bg-success">Đang làm việc</span>
        );
      case "OnLeave":
        return (
          <span className="badge rounded-pill bg-warning text-dark">
            Nghỉ phép
          </span>
        );
      case "Inactive":
        return <span className="badge rounded-pill bg-secondary">Đã nghỉ</span>;
      default:
        return (
          <span className="badge rounded-pill bg-light text-dark">Khác</span>
        );
    }
  };

  const getInitials = (name) => {
    return name.charAt(0).toUpperCase();
  };

  return (
    <div className="container-fluid mt-4">
      <div className="card shadow-sm border-0 rounded-3">
        <div className="card-header bg-white py-3 d-flex justify-content-between align-items-center">
          <h5 className="mb-0 fw-bold text-primary">Danh sách nhân sự</h5>
          <Link
            to="/nhan-vien/them-moi"
            className="btn btn-primary btn-sm d-flex align-items-center gap-2"
          >
            <FaPlus /> Thêm mới
          </Link>
        </div>

        <div className="card-body p-0">
          <div className="table-responsive">
            <table className="table table-hover align-middle mb-0">
              <thead className="table-light">
                <tr>
                  <th scope="col" className="ps-4 py-3">
                    Nhân viên
                  </th>
                  <th scope="col">Vị trí</th>
                  <th scope="col">Trạng thái</th>
                  <th scope="col">Ngày vào</th>
                  <th scope="col" className="text-end pe-4">
                    Hành động
                  </th>
                </tr>
              </thead>
              <tbody>
                {employees.map((emp) => (
                  <tr key={emp.id}>
                    <td className="ps-4">
                      <div className="d-flex align-items-center">
                        <div
                          className="rounded-circle bg-primary bg-opacity-10 text-primary d-flex align-items-center justify-content-center fw-bold me-3"
                          style={{
                            width: "40px",
                            height: "40px",
                            minWidth: "40px",
                          }}
                        >
                          {getInitials(emp.name)}
                        </div>
                        <div>
                          <div className="fw-bold text-dark">{emp.name}</div>
                          <small className="text-muted">{emp.email}</small>
                        </div>
                      </div>
                    </td>

                    <td>
                      <div className="fw-semibold">{emp.role}</div>
                      <small className="text-muted">{emp.department}</small>
                    </td>

                    <td>{getStatusBadge(emp.status)}</td>

                    <td className="text-muted">12/10/2023</td>

                    {/* CỘT HÀNH ĐỘNG */}
                    <td className="text-end pe-4">
                      {/* SỬA LỖI TẠI ĐÂY: Thêm align-items-center */}
                      <div className="d-flex align-items-center justify-content-end gap-2">
                        {/* Nút Xem */}
                        <Link
                          to={`/nhan-vien/${emp.id}`}
                          className="btn btn-primary btn-sm d-flex align-items-center justify-content-center"
                          style={{ width: "34px", height: "34px" }}
                          title="Xem"
                        >
                          <FaEye />
                        </Link>

                        {/* Nút Sửa */}
                        <Link
                          to={`/nhan-vien/edit/${emp.id}`}
                          className="btn btn-warning btn-sm text-white d-flex align-items-center justify-content-center"
                          style={{ width: "34px", height: "34px" }}
                          title="Sửa"
                        >
                          <FaEdit />
                        </Link>

                        {/* Nút Xóa */}
                        <button
                          className="btn btn-danger btn-sm d-flex align-items-center justify-content-center"
                          style={{ width: "34px", height: "34px" }}
                          title="Xóa"
                        >
                          <FaTrashAlt />
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>

        <div className="card-footer bg-white py-3">
          <nav aria-label="Page navigation">
            <ul className="pagination justify-content-end mb-0 pagination-sm">
              <li className="page-item disabled">
                <a className="page-link" href="#">
                  Trước
                </a>
              </li>
              <li className="page-item active">
                <a className="page-link" href="#">
                  1
                </a>
              </li>
              <li className="page-item">
                <a className="page-link" href="#">
                  2
                </a>
              </li>
              <li className="page-item">
                <a className="page-link" href="#">
                  Sau
                </a>
              </li>
            </ul>
          </nav>
        </div>
      </div>
    </div>
  );
};

export default EmployeeTable;
