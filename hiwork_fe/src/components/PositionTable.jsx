import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { FaTrashAlt, FaEye, FaPlus } from "react-icons/fa";
import { toast } from "react-hot-toast";
import apiClient from "../api/clientAppi";
import ConfirmPopup from "./ConfirmPopup";

const PositionTable = () => {
  const [positions, setPositions] = useState([]);
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const [showConfirm, setShowConfirm] = useState(false);
  const [deletePosition, setDeletePosition] = useState(null); // lưu object position

  const fetchPositions = async (pageNumber = 1) => {
    setLoading(true);
    try {
      const res = await apiClient.get(`/admin/positions?page=${pageNumber}&limit=5`);
      const data = res.data;

      setPositions(data.data || []);
      setPage(data.pagination?.currentPage || 1);
      setTotalPages(data.pagination?.totalPages || 1);
      setError(null);
    } catch (err) {
      console.error(err);
      setError("Không thể tải danh sách vị trí.");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchPositions(page);
  }, [page]);

  const handlePageChange = (newPage) => {
    if (newPage >= 1 && newPage <= totalPages && newPage !== page) {
      setPage(newPage);
    }
  };

  const handleDeleteClick = (position) => {
    setDeletePosition(position); // lưu toàn bộ object
    setShowConfirm(true);
  };

  const handleConfirmDelete = async () => {
    setShowConfirm(false);
    if (!deletePosition) return;

    try {
      const res = await apiClient.delete(`/admin/positions/${deletePosition.id}`);
      if (res.status === 200) {
        toast.success(`Xóa vị trí "${deletePosition.name}" thành công!`);
        fetchPositions(page);
      } else {
        toast.error("Xóa không thành công!");
      }
    } catch (err) {
      console.error(err);
      toast.error(
        err.response?.data?.message || "Đã xảy ra lỗi khi xóa vị trí."
      );
    } finally {
      setDeletePosition(null);
    }
  };

  const handleCancelDelete = () => {
    setShowConfirm(false);
    setDeletePosition(null);
  };

  return (
    <div className="container-fluid mt-4">
      <div className="card shadow-sm border-0 rounded-3">
        <div className="card-header bg-white py-3 d-flex justify-content-between align-items-center">
          <h5 className="mb-0 fw-bold text-primary">Danh sách vị trí</h5>
          <Link
            to="/vi-tri/them-moi"
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
                  <th className="ps-4 py-3" style={{ width: "200px" }}>
                    Mã ID
                  </th>
                  <th className="ps-4 py-3">Tên vị trí</th>
                  <th className="text-end pe-4 ps-4 py-3">Hành động</th>
                </tr>
              </thead>
              <tbody>
                {loading ? (
                  <tr>
                    <td colSpan="3" className="text-center py-3">
                      Đang tải dữ liệu...
                    </td>
                  </tr>
                ) : error ? (
                  <tr>
                    <td colSpan="3" className="text-center py-3 text-danger">
                      {error}
                    </td>
                  </tr>
                ) : positions.length === 0 ? (
                  <tr>
                    <td colSpan="3" className="text-center py-3 text-muted">
                      Không có dữ liệu
                    </td>
                  </tr>
                ) : (
                  positions.map((position) => (
                    <tr key={position.id}>
                      <td className="ps-4">
                        <span
                          className="badge text-dark"
                          style={{ fontSize: 16 }}
                        >
                          {position.id}
                        </span>
                      </td>
                      <td>
                        <div className="fw-bold text-dark">{position.name}</div>
                      </td>
                      <td className="text-end pe-4">
                        <div className="d-flex align-items-center justify-content-end gap-2">
                          <Link
                            to={`/admin/vi-tri/${position.id}`}
                            className="btn btn-primary btn-sm d-flex align-items-center justify-content-center"
                            style={{ width: "34px", height: "34px" }}
                            title="Xem chi tiết"
                          >
                            <FaEye />
                          </Link>
                          <button
                            className="btn btn-danger btn-sm d-flex align-items-center justify-content-center"
                            style={{ width: "34px", height: "34px" }}
                            title="Xóa"
                            onClick={() => handleDeleteClick(position)} // truyền cả object
                          >
                            <FaTrashAlt />
                          </button>
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

      {/* Popup Xác nhận */}
      <ConfirmPopup
        show={showConfirm}
        title="Xác nhận xóa"
        message={`Bạn có chắc chắn muốn xóa vị trí "${deletePosition?.name}" không?`}
        onConfirm={handleConfirmDelete}
        onCancel={handleCancelDelete}
      />
    </div>
  );
};

export default PositionTable;
