import { useEffect, useState } from "react";
import apiClient from "../../../api/clientAppi";
import { useNavigate } from "react-router-dom";

import "./profilePage.css";
import toast from "react-hot-toast";

const Profile = () => {
  const [userData, setUserData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [uploading, setUploading] = useState(false);

  const userId = localStorage.getItem("userId");
  const navigate = useNavigate();

  // Load profile
  useEffect(() => {
    fetchProfile();
  }, []);

  const fetchProfile = async () => {
    try {
      const response = await apiClient.get(`/manager/profile/${userId}`);
      setUserData(response.data.user);
    } catch (err) {
      setError(
        err.response?.data?.message || "Không thể lấy dữ liệu người dùng"
      );
    } finally {
      setLoading(false);
    }
  };

  // Handle change avatar
  const handleAvatarChange = async (e) => {
    const file = e.target.files[0];
    if (!file) return;

    setUploading(true);

    try {
      const formData = new FormData();
      formData.append("avatar", file);

      await apiClient.put(`/manager/profile/${userId}/avatar`, formData);

      toast.success("Đổi ảnh thành công!");

      // Reload dữ liệu sau khi cập nhật avatar
      fetchProfile();
    } catch (err) {
      console.error(err);
      alert("Lỗi khi tải ảnh lên!");
    } finally {
      setUploading(false);
    }
  };

  // LOADING
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

  // ERROR
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
            {/* Avatar */}
            <div className="col-md-3 text-center">
              <img
                src={userData.avatar_url || "https://i.pravatar.cc/300?img=12"}
                alt="avatar"
                className="rounded-circle img-fluid shadow-sm"
                style={{ width: 140, height: 140, objectFit: "cover" }}
              />

              <label className="btn btn-primary btn-sm mt-3 px-4 rounded-pill">
                {uploading ? "Đang tải..." : "Đổi ảnh"}
                <input
                  type="file"
                  accept="image/*"
                  hidden
                  onChange={handleAvatarChange}
                />
              </label>
            </div>

            {/* Basic Info */}
            <div className="col-md-9">
              <h4 className="fw-bold">{userData.name}</h4>
              <p className="text-muted">
                {userData.positionName || "Nhân viên"}
              </p>

              <div className="row mt-4">
                <div className="col-md-6 mb-3">
                  <label className="text-muted small fw-bold">Email</label>
                  <p className="fw-semibold">{userData.user.email}</p>
                </div>

                <div className="col-md-6 mb-3">
                  <label className="text-muted small fw-bold">
                    Số điện thoại
                  </label>
                  <p className="fw-semibold">{userData.phone}</p>
                </div>

                <div className="col-md-6 mb-3">
                  <label className="text-muted small fw-bold">
                    Ngày gia nhập
                  </label>
                  <p className="fw-semibold">
                    {new Date(userData.createdAt).toLocaleDateString("vi-VN")}
                  </p>
                </div>

                <div className="col-md-6 mb-3">
                  <label className="text-muted small fw-bold">Vai trò</label>
                  <p className="fw-semibold">
                    {userData.role === 0 ? "Quản trị" : "Nhân viên"}
                  </p>
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
            onClick={() => navigate(`/manager/profile/${userId}/edit`)}
          >
            Chỉnh sửa thông tin
          </button>
        </div>
      </div>
    </>
  );
};

export default Profile;
