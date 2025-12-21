import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { FaEdit, FaTrashAlt, FaEye, FaPlus } from "react-icons/fa";
import apiClient from "../api/clientAppi";
import "./css/Pagination.css";

const EmployeeTable = () => {
  const [employees, setEmployees] = useState([]);
  const [page, setPage] = useState(1);
  const limit = 5;

  const [totalPages, setTotalPages] = useState(1);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const userRole = localStorage.getItem("role");
  
  const fetchEmployees = async (pageNumber = 1) => {
    setLoading(true);
    try {
      const res = await apiClient.get(
        `/admin/employees?page=${pageNumber}&limit=${limit}&role=${userRole}`
      );
      const data = res.data;

      setEmployees(data.data || []);
      setPage(data.pagination?.currentPage || 1);
      setTotalPages(data.pagination?.totalPages || 1);
      setError(null);
    } catch (err) {
      console.error(err);
      setError("Không thể tải danh sách nhân sự.");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchEmployees(page);
  }, [page]);

  // =========================
  // HANDLE PAGE CHANGE
  // =========================
  const handlePageChange = (newPage) => {
    if (newPage >= 1 && newPage <= totalPages && newPage !== page) {
      setPage(newPage);
    }
  };

  // =========================
  // UI UTILITIES
  // =========================
  const getStatusBadge = (status) => {
    switch (status) {
      case 1:
        return <span className="badge bg-success">Đang làm việc</span>;
      case 2:
        return <span className="badge bg-warning text-dark">Nghỉ phép</span>;
      case 0:
        return <span className="badge bg-secondary">Đã nghỉ</span>;
      default:
        return <span className="badge bg-light text-dark">Khác</span>;
    }
  };

  // Định dạng ngày tháng
  const formatDate = (isoString) => {
    if (!isoString) return "—";
    const date = new Date(isoString);
    return date.toLocaleDateString("vi-VN"); // => DD/MM/YYYY
  };

  const getInitials = (name) => name?.charAt(0).toUpperCase();

  return (
    <div className="container-fluid mt-4">
      <div className="card shadow-sm border-0 rounded-3">
        {/* HEADER */}
        <div className="card-header bg-white py-3 d-flex justify-content-between align-items-center">
          <h5 className="mb-0 fw-bold text-primary">Danh sách nhân sự</h5>

          {/* {(userRole === "admin" || userRole === "manager") && (
            <Link
              to="/nhan-vien/them-moi"
              className="btn btn-primary btn-sm d-flex align-items-center gap-2"
            >
              <FaPlus /> Thêm mới
            </Link>
          )} */}
        </div>

        {/* TABLE */}
        <div className="card-body p-0">
          <div className="table-responsive">
            <table className="table table-hover align-middle mb-0">
              <thead className="table-light">
                <tr>
                  <th className="ps-4">Nhân viên</th>
                  <th>Vị trí</th>
                  <th>Trạng thái</th>
                  <th>Ngày vào</th>
                  <th className="text-center pe-4">Hành động</th>
                </tr>
              </thead>

              <tbody>
                {/* LOADING */}
                {loading ? (
                  <tr>
                    <td colSpan="5" className="text-center py-3">
                      Đang tải dữ liệu...
                    </td>
                  </tr>
                ) : error ? (
                  <tr>
                    <td colSpan="5" className="text-center py-3 text-danger">
                      {error}
                    </td>
                  </tr>
                ) : employees.length === 0 ? (
                  <tr>
                    <td colSpan="5" className="text-center py-3 text-muted">
                      Không có dữ liệu
                    </td>
                  </tr>
                ) : (
                  employees.map((emp) => (
                    <tr key={emp.id}>
                      <td className="ps-4">
                        <div className="d-flex align-items-center">
                          <div className="me-3">
                            <img
                              src={
                                emp.avatar_url
                                  ? emp.avatar_url
                                  : emp.gender === 1
                                  ? "https://i.pravatar.cc/300?img=12" // nam
                                  : "https://i.pravatar.cc/300?img=47"
                              }
                              alt="avatar"
                              className="rounded-circle img-fluid shadow-sm"
                              style={{
                                width: 40,
                                height: 40,
                                objectFit: "cover",
                              }}
                            />
                          </div>
                          <div>
                            <div className="fw-bold">{emp.name}</div>
                          </div>
                        </div>
                      </td>

                      <td>{emp.position?.name}</td>
                      <td>{getStatusBadge(emp.status)}</td>
                      <td className="text-muted">
                        {formatDate(emp.createdAt)}
                      </td>

                      {/* ACTIONS */}
                      <td className="pe-4">
                        <div className="d-flex justify-content-center align-items-center gap-2">
                          {/* Ai cũng xem được */}
                          {parseInt(userRole) === 1 ? (
                            <Link
                              to={`/manager/nhan-vien/${emp.id}`}
                              className="btn btn-primary btn-sm d-flex align-items-center justify-content-center"
                              style={{ width: 34, height: 34 }}
                              title="Xem"
                            >
                              <FaEye />
                            </Link>
                          ) : parseInt(userRole) === 0 ? (
                            <Link
                              to={`/admin/nhan-vien/${emp.id}`}
                              className="btn btn-primary btn-sm d-flex align-items-center justify-content-center"
                              style={{ width: 34, height: 34 }}
                              title="Xem"
                            >
                              <FaEye />
                            </Link>
                          ) : (
                            ""
                          )}

                          {/* Chỉ admin + manager được xóa
                          {(userRole == 0 || userRole == 1) && (
                            <button
                              className="btn btn-danger btn-sm d-flex align-items-center justify-content-center"
                              style={{ width: 34, height: 34 }}
                              title="Xóa"
                              onClick={() => handleDeleteClick(emp)}
                            >
                              <FaTrashAlt />
                            </button>
                          )} */}
                        </div>
                      </td>
                    </tr>
                  ))
                )}
              </tbody>
            </table>
          </div>
        </div>

        {/* Pagination */}
        <div className="card-footer bg-white py-3">
          <nav aria-label="Page navigation">
            <ul className="pagination justify-content-end mb-0 pagination-sm custom-pagination">
              {/* Nút Previous */}
              <li className={`page-item ${page === 1 ? "disabled" : ""}`}>
                <button
                  className="page-link"
                  onClick={() => page > 1 && handlePageChange(page - 1)}
                >
                  Trước
                </button>
              </li>

              {/* Danh sách trang */}
              {Array.from({ length: totalPages }, (_, i) => {
                const num = i + 1;
                return (
                  <li
                    key={num}
                    className={`page-item ${page === num ? "active" : ""}`}
                  >
                    <button
                      className="page-link"
                      onClick={() => handlePageChange(num)}
                    >
                      {num}
                    </button>
                  </li>
                );
              })}

              {/* Nút Next */}
              <li
                className={`page-item ${page === totalPages ? "disabled" : ""}`}
              >
                <button
                  className="page-link"
                  onClick={() =>
                    page < totalPages && handlePageChange(page + 1)
                  }
                >
                  Sau
                </button>
              </li>
            </ul>
          </nav>
        </div>
      </div>
    </div>
  );
};

export default EmployeeTable;
