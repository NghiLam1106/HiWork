import { useEffect, useState } from "react";
import apiClient from "../../../api/clientAppi";
import { useNavigate } from "react-router-dom";
import { toast } from "react-hot-toast";
import "./profilePage.css";

const UpdateProfile = () => {
  const [formData, setFormData] = useState({
    name: "",
    phone: "",
    gender: "",
    address: "",
  });

  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const navigate = useNavigate();
  const userId = localStorage.getItem("userId");

  useEffect(() => {
    const fetchProfile = async () => {
      try {
        const response = await apiClient.get(`/manager/profile/${userId}`);
        const user = response.data.user;

        setFormData({
          name: user.name || "",
          phone: user.phone || "",
          gender: user.gender || "",
          address: user.address || "",
        });
      } catch (err) {
        setError("Không thể tải dữ liệu");
      } finally {
        setLoading(false);
      }
    };

    fetchProfile();
  }, []);

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
  };

  // LƯU THAY ĐỔI
  const handleSave = async () => {
    try {
      await apiClient.put(`/manager/profile/${userId}`, formData);

      toast.success("Cập nhật thành công!");
      navigate("/manager/profile/" + userId);
    } catch (err) {
      console.log(err);
      toast.error("Lỗi cập nhật thông tin!");
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

  if (error) return <p className="text-danger text-center mt-4">{error}</p>;

  return (
    <>
      <header className="header d-flex justify-content-between align-items-center mb-4">
        <h1 className="fw-bold">Chỉnh sửa thông tin cá nhân</h1>
      </header>

      <div className="container profile-container">
        <div className="card shadow-sm rounded-4 p-4 mb-4 border-0">
          {/* FORM INPUTS */}
          <div className="row">
            {/* NAME */}
            <div className="col-md-12 mb-3">
              <label className="fw-bold small">Họ và tên</label>
              <input
                type="text"
                className="form-control rounded-3"
                name="name"
                value={formData.name}
                onChange={handleChange}
                placeholder="Nhập họ và tên"
              />
            </div>

            {/* Phone */}
            <div className="col-md-6 mb-3">
              <label className="fw-bold small">Số điện thoại</label>
              <input
                type="text"
                className="form-control rounded-3"
                name="phone"
                value={formData.phone}
                onChange={handleChange}
                placeholder="Nhập số điện thoại"
              />
            </div>

            {/* Gender */}
            <div className="col-md-6 mb-3">
              <label className="fw-bold small pb-2">Giới tính</label>
              <select
                name="gender"
                className="form-select rounded-3"
                value={formData.gender}
                onChange={handleChange}
              >
                <option value="">Chọn giới tính</option>
                <option value="1">Nam</option>
                <option value="2">Nữ</option>
                <option value="3">Khác</option>
              </select>
            </div>

            {/* Address */}
            <div className="col-md-12 mb-3">
              <label className="fw-bold small">Địa chỉ</label>
              <input
                type="text"
                className="form-control rounded-3"
                name="address"
                value={formData.address}
                onChange={handleChange}
                placeholder="Nhập địa chỉ"
              />
            </div>
          </div>

          {/* BUTTONS */}
          <div className="mt-4 d-flex justify-content-between">
            <button
              className="btn btn-outline-secondary rounded-pill px-4"
              onClick={() => navigate(-1)}
            >
              Hủy
            </button>

            <button
              className="btn btn-primary rounded-pill px-4"
              onClick={handleSave}
            >
              Lưu thay đổi
            </button>
          </div>
        </div>
      </div>
    </>
  );
};

export default UpdateProfile;
