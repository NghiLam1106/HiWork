import { useEffect, useState } from "react";
import apiClient from "../../../api/clientAppi";
import { useNavigate, useParams } from "react-router-dom";

import "./employeePage"; // nếu đây là css thì nên đổi thành "./employeePage.css"

const Employee = () => {
  const [userData, setUserData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const userId = localStorage.getItem("userId");
  const navigate = useNavigate();
  const { id } = useParams();

  useEffect(() => {
    fetchProfile();
  }, []);

  const fetchProfile = async () => {
    try {
      const response = await apiClient.get(`/manager/employees/${id}`);
      setUserData(response.data.employee);
    } catch (err) {
      setError(
        err.response?.data?.message || "Không thể lấy dữ liệu người dùng"
      );
    } finally {
      setLoading(false);
    }
  };

  const getStatusBadge = (status) => {
    switch (status) {
      case 1:
        return <span className="badge bg-success">Đang làm việc</span>;
      case 2:
        return <span className="badge bg-warning text-dark">Nghỉ phép</span>;
      case 0:
        return <span className="badge bg-secondary">Đã nghỉ</span>;
      default:
        return <span className="badge bg-light text-dark">Chưa cập nhật</span>;
    }
  };

  if (loading)
    return (
      <div
        className="d-flex justify-content-center align-items-center"
        style={{ height: "50vh" }}
      >
        <div
          className="spinner-border text-primary"
          role="status"
          style={{ width: "3rem", height: "3rem" }}
        ></div>
      </div>
    );

  if (error) {
    return <div className="text-danger text-center mt-5">{error}</div>;
  }

  return (
    <>
      {/* HEADER */}
      <header className="header d-flex justify-content-between align-items-center mb-4">
        <h1 className="fw-bold">Thông tin cá nhân</h1>
      </header>

      {/* MAIN CONTENT */}
      <div className="container profile-container">
        {/* Profile Card */}
        <div className="card shadow-sm rounded-4 p-4 mb-4 border-0">
          <div className="row align-items-center">
            {/* ✅ AVATAR (chỉ hiển thị ảnh, KHÔNG có nút đổi ảnh) */}
            <div className="col-md-3 text-center mb-3 mb-md-0">
              <img
                src={
                  userData.avatar_url
                    ? userData.avatar_url
                    : userData.gender === 1
                    ? "https://i.pravatar.cc/300?img=12" // nam
                    : "https://i.pravatar.cc/300?img=47"
                }
                alt="avatar"
                className="rounded-circle img-fluid shadow-sm"
                style={{
                  width: 140,
                  height: 140,
                  objectFit: "cover",
                }}
              />
            </div>

            {/* Basic Info */}
            <div className="col-md-9">
              <h4 className="fw-bold">{userData.name || "Chưa cập nhật"}</h4>
              <p className="text-muted">
                {userData.position?.name || "Nhân viên"}
              </p>

              <div className="row mt-4">
                <div className="col-md-6 mb-3">
                  <label className="text-muted small fw-bold">Email</label>
                  <p className="fw-semibold">{userData?.user?.email || "Chưa cập nhật"}</p>
                </div>

                <div className="col-md-6 mb-3">
                  <label className="text-muted small fw-bold">
                    Số điện thoại
                  </label>
                  <p className="fw-semibold">{userData.phone || "Chưa cập nhật"}</p>
                </div>

                <div className="col-md-6 mb-3">
                  <label className="text-muted small fw-bold">
                    Ngày gia nhập
                  </label>
                  <p className="fw-semibold">
                    {userData.createdAt
                      ? new Date(userData.createdAt).toLocaleDateString("vi-VN")
                      : "—"}
                  </p>
                </div>

                <div className="col-md-6 mb-3">
                  <label className="text-muted small fw-bold">Vai trò</label>
                  <p className="fw-semibold">
                    {userData.user?.role === 0
                      ? "Quản trị"
                      : userData.user?.role === 1
                      ? "Quản lí"
                      : "Chưa cập nhật"}
                  </p>
                </div>

                {/* ✅ TRẠNG THÁI */}
                <div className="col-md-6 mb-3">
                  <label className="text-muted small fw-bold">Trạng thái</label>
                  <div className="mt-1">{getStatusBadge(userData.status)}</div>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Additional Info */}
        <div className="card shadow-sm rounded-4 p-4 border-0">
          <h5 className="fw-bold mb-3">Thông tin chi tiết</h5>

          <div className="row">
            <div className="col-md-6 mb-3">
              <label className="text-muted small fw-bold">Giới tính</label>
              <p className="fw-semibold">
                {userData.gender === 1
                  ? "Nam"
                  : userData.gender === 2
                  ? "Nữ"
                  : userData.gender === 3
                  ? "Khác"
                  : "Chưa cập nhật"}
              </p>
            </div>

            <div className="col-md-6 mb-3">
              <label className="text-muted small fw-bold">Địa chỉ</label>
              <p className="fw-semibold">
                {userData.address || "Chưa cập nhật"}
              </p>
            </div>
          </div>

          <button
            className="btn btn-outline-primary mt-3 px-4 rounded-pill"
            onClick={() => navigate(`/manager/nhan-vien/${id}/edit`)}
          >
            Chỉnh sửa thông tin
          </button>
        </div>
      </div>
    </>
  );
};

export default Employee;
