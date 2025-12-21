import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { FaEye, FaPlus } from "react-icons/fa";
import apiClient from "../api/clientAppi";
import "./css/Pagination.css";

const AttendanceTable = () => {
  const [schedules, setSchedules] = useState([]);
  const [page, setPage] = useState(1);
  const limit = 5;

  const [totalPages, setTotalPages] = useState(1);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const userRole = localStorage.getItem("role");

  const fetchSchedules = async (pageNumber = 1) => {
    setLoading(true);
    try {
      const res = await apiClient.get(
        `/manager/cham-cong?page=${pageNumber}&limit=${limit}`
      );

      const data = res.data;
      setSchedules(data.data || []);
      setPage(data.pagination?.currentPage || data.paging?.page || 1);
      setTotalPages(
        data.pagination?.totalPages ||
          Math.ceil((data.paging?.total || 0) / limit) ||
          1
      );

      setError(null);
    } catch (err) {
      console.error(err);
      setError("Không thể tải danh sách chấm công.");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchSchedules(page);
  }, [page]);

  const handlePageChange = (newPage) => {
    if (newPage >= 1 && newPage <= totalPages && newPage !== page) {
      setPage(newPage);
    }
  };

  const getStatusBadge = (status) => {
    switch (Number(status)) {
      case 1:
        return <span className="badge bg-success">Đang làm việc</span>;
      case 2:
        return <span className="badge bg-warning text-dark">Nghỉ phép</span>;
      case 0:
        return <span className="badge bg-secondary">Đã nghỉ</span>;
      case 3:
        return <span className="badge bg-danger">Chưa duyệt</span>;
      default:
        return <span className="badge bg-light text-dark">Khác</span>;
    }
  };

  const formatTime = (dateTime) => {
    if (!dateTime) return "—";
    const d = new Date(dateTime);
    // hiển thị HH:mm (giờ/phút)
    return d.toLocaleTimeString("vi-VN", { hour: "2-digit", minute: "2-digit" });
  };

  const formatConfidence = (value) => {
    if (value === null || value === undefined || value === "") return "—";
    const num = Number(value);
    if (Number.isNaN(num)) return "—";

    // Nếu backend trả 0..1 -> đổi ra %
    const percent = num <= 1 ? num * 100 : num; // nếu bạn trả sẵn 0..100 thì vẫn ok
    return `${percent.toFixed(2)}%`;
  };

  return (
    <div className="container-fluid mt-4">
      <div className="card shadow-sm border-0 rounded-3">
        {/* HEADER */}
        <div className="card-header bg-white py-3 d-flex justify-content-between align-items-center">
          <h5 className="mb-0 fw-bold text-primary">Danh sách chấm công</h5>

          {/* {userRole === "1" && (
            <Link
              to="/manager/lich-lam-viec/them-moi"
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
                  <th>Giờ check-in</th>
                  <th>Giờ check-out</th>
                  <th>Tỉ lệ (confidence)</th>
                  <th>Trạng thái</th>
                  <th className="text-center pe-4">Hành động</th>
                </tr>
              </thead>

              <tbody>
                {loading ? (
                  <tr>
                    <td colSpan="6" className="text-center py-3">
                      Đang tải dữ liệu...
                    </td>
                  </tr>
                ) : error ? (
                  <tr>
                    <td colSpan="6" className="text-center py-3 text-danger">
                      {error}
                    </td>
                  </tr>
                ) : schedules.length === 0 ? (
                  <tr>
                    <td colSpan="6" className="text-center py-3 text-muted">
                      Không có dữ liệu
                    </td>
                  </tr>
                ) : (
                  schedules.map((item) => {
                    const emp = item.employee || item.Employee || {};

                    // attendance có thể nằm trong item.attendance / item.Attendance
                    const att = item.attendance || item.Attendance || item || {};

                    return (
                      <tr key={item.id || item.id_employee_shift || item.idEmployeeShift}>
                        <td className="ps-4">
                          <div className="d-flex align-items-center">
                            <div className="me-3">
                              <img
                                src={
                                  emp.avatar_url
                                    ? emp.avatar_url
                                    : emp.gender === 1
                                    ? "https://i.pravatar.cc/300?img=12"
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
                              <div className="fw-bold">
                                {emp.name || emp.full_name || `${item.employeeSchedule.employee.name}`}
                              </div>
                            </div>
                          </div>
                        </td>

                        <td className="text-muted">{formatTime(att.check_in || att.checkIn)}</td>
                        <td className="text-muted">{formatTime(att.check_out || att.checkOut)}</td>
                        <td className="text-muted">
                          {formatConfidence(att.confidence_score ?? att.confidenceScore)}
                        </td>

                        <td>{getStatusBadge(item.status)}</td>

                        <td className="pe-4">
                          <div className="d-flex justify-content-center align-items-center gap-2">
                            <Link
                              to={`/manager/cham-cong/${item.id}`}
                              className="btn btn-primary btn-sm d-flex align-items-center justify-content-center"
                              style={{ width: 34, height: 34 }}
                              title="Xem"
                            >
                              <FaEye />
                            </Link>
                          </div>
                        </td>
                      </tr>
                    );
                  })
                )}
              </tbody>
            </table>
          </div>
        </div>

        {/* Pagination */}
        <div className="card-footer bg-white py-3">
          <nav aria-label="Page navigation">
            <ul className="pagination justify-content-end mb-0 pagination-sm custom-pagination">
              <li className={`page-item ${page === 1 ? "disabled" : ""}`}>
                <button
                  className="page-link"
                  onClick={() => page > 1 && handlePageChange(page - 1)}
                >
                  Trước
                </button>
              </li>

              {Array.from({ length: totalPages }, (_, i) => {
                const num = i + 1;
                return (
                  <li key={num} className={`page-item ${page === num ? "active" : ""}`}>
                    <button className="page-link" onClick={() => handlePageChange(num)}>
                      {num}
                    </button>
                  </li>
                );
              })}

              <li className={`page-item ${page === totalPages ? "disabled" : ""}`}>
                <button
                  className="page-link"
                  onClick={() => page < totalPages && handlePageChange(page + 1)}
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

export default AttendanceTable;
