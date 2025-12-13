import { useEffect, useState } from "react";
import apiClient from "../../../api/clientAppi";
import { useNavigate, useParams } from "react-router-dom";
import toast from "react-hot-toast";
import "./employeePage.css";

const UpdateEmployee = () => {
  const [formData, setFormData] = useState({
    status: "",
    positionId: "",
  });

  const [positions, setPositions] = useState([]);

  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const navigate = useNavigate();
  const userId = localStorage.getItem("userId");
  const { id } = useParams();

  useEffect(() => {
    const fetchData = async () => {
      try {
        // 1) Lấy profile
        const profileRes = await apiClient.get(`/manager/employees/${id}`);
        const user = profileRes.data;

        // 2) Lấy danh sách vị trí
        // ⚠️ đổi endpoint này nếu backend bạn khác
        const posRes = await apiClient.get(`/manager/positions`);
        const posData = posRes.data?.data || posRes.data || [];

        setPositions(posData);

        setFormData({
          status: user.employee.status ?? "",
          // tùy backend bạn trả về field gì
          positionId:
            user.employee.position_id ?? "",
        });

        setError(null);
      } catch (err) {
        console.log(err);
        setError("Không thể tải dữ liệu");
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [userId]);

  const handleChange = (e) => {
    setFormData((prev) => ({
      ...prev,
      [e.target.name]: e.target.value,
    }));
  };

  // LƯU THAY ĐỔI
  const handleSave = async () => {
    try {
      const payload = {
        status: Number(formData.status),
        position_id: Number(formData.positionId),
      };

      await apiClient.put(`/admin/employees/${id}`, payload);

      toast.success("Cập nhật thành công!");
      navigate("/manager/nhan-vien/" + id);
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
        <h1 className="fw-bold">Cập nhật trạng thái & vị trí</h1>
      </header>

      <div className="container profile-container">
        <div className="card shadow-sm rounded-4 p-4 mb-4 border-0">
          {/* FORM INPUTS */}
          <div className="row">
            {/* STATUS */}
            <div className="col-md-6 mb-3">
              <label className="fw-bold small">Trạng thái</label>
              <select
                name="status"
                className="form-select rounded-3"
                value={formData.status}
                onChange={handleChange}
              >
                <option value="">Chọn trạng thái</option>
                <option value="1">Đang làm việc</option>
                <option value="2">Nghỉ phép</option>
                <option value="0">Đã nghỉ</option>
              </select>
            </div>

            {/* POSITION */}
            <div className="col-md-6 mb-3">
              <label className="fw-bold small">Vị trí</label>
              <select
                name="positionId"
                className="form-select rounded-3"
                value={formData.positionId}
                onChange={handleChange}
              >
                <option value="">Chọn vị trí</option>
                {positions.map((p) => (
                  <option key={p.id} value={p.id}>
                    {p.name}
                  </option>
                ))}
              </select>
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
              // disabled={!formData.status || !formData.positionId}
            >
              Lưu thay đổi
            </button>
          </div>
        </div>
      </div>
    </>
  );
};

export default UpdateEmployee;
