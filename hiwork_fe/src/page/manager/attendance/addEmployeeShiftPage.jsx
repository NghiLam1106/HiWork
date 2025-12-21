import React, { useEffect, useState } from "react";
import { FaSave } from "react-icons/fa";
import apiClient from "../../../api/clientAppi";
import { useNavigate } from "react-router-dom";
import { toast } from "react-hot-toast";

const AddEmployeeShift = () => {
  const [formData, setFormData] = useState({
    employeeId: "",
    shiftId: "",
    status: "",
    workDate: "", // yyyy-mm-dd
  });

  const [employees, setEmployees] = useState([]);
  const [shifts, setShifts] = useState([]);

  const [isLoading, setIsLoading] = useState(false); // loading submit
  const [loading, setLoading] = useState(true); // loading data page
  const [error, setError] = useState("");

  const navigate = useNavigate();
  const userRole = localStorage.getItem("role");

  useEffect(() => {
    const fetchLists = async () => {
      try {
        setLoading(true);
        setError("");

        const empRes = await apiClient.get(`/manager/employees?role=${userRole}`);
        const empData = empRes.data?.data || empRes.data || [];
        setEmployees(empData);

        const shiftRes = await apiClient.get(`/manager/shifts`);
        const shiftData = shiftRes.data?.data || shiftRes.data || [];
        setShifts(shiftData);
      } catch (err) {
        console.log(err);
        setError("Không thể tải dữ liệu");
      } finally {
        setLoading(false);
      }
    };

    fetchLists();
  }, [userRole]);

  const handleChange = (e) => {
    setFormData((prev) => ({
      ...prev,
      [e.target.name]: e.target.value,
    }));
    if (error) setError("");
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    // validate nhanh
    if (!formData.employeeId) return toast.error("Vui lòng chọn nhân viên");
    if (!formData.shiftId) return toast.error("Vui lòng chọn ca làm");
    if (formData.status === "" || formData.status === null) return toast.error("Vui lòng chọn trạng thái");
    if (!formData.workDate) return toast.error("Vui lòng chọn ngày làm");

    setIsLoading(true);

    try {
      const payload = {
        id_employee: Number(formData.employeeId),
        id_shift: Number(formData.shiftId),
        status: Number(formData.status),
        work_date: formData.workDate,
      };

      const res = await apiClient.post(`/manager/employee-shifts`, payload);

      if (res.status === 200 || res.status === 201) {
        toast.success("Tạo lịch làm thành công!");
        setFormData({ employeeId: "", shiftId: "", status: "", workDate: "" });
        navigate(-1);
      }
    } catch (err) {
      console.error("Lỗi API:", err);
      if (err.response) {
        toast.error(err.response.data?.message || "Có lỗi từ server.");
      } else if (err.request) {
        toast.error("Không thể kết nối đến Server. Vui lòng kiểm tra đường truyền.");
      } else {
        toast.error("Đã xảy ra lỗi không mong muốn.");
      }
    } finally {
      setIsLoading(false);
    }
  };

  if (loading)
    return (
      <div className="d-flex justify-content-center align-items-center" style={{ height: "50vh" }}>
        <div className="spinner-border text-primary" role="status" style={{ width: "3rem", height: "3rem" }}></div>
      </div>
    );

  if (error) return <p className="text-danger text-center mt-4">{error}</p>;

  return (
    <>
      <header className="header mb-4">
        <h1>Lịch làm</h1>
      </header>

      <div className="container-fluid px-4" style={{ minHeight: "calc(100vh - 150px)" }}>
        <div className="row">
          <div className="col-12">
            <div className="card shadow-lg border-0 rounded-4 overflow-hidden">
              <div className="card-header bg-primary bg-gradient text-white p-3 border-0 text-start ps-4">
                <h5 className="mb-0 fw-bold">Tạo lịch làm việc</h5>
              </div>

              <div className="card-body p-4 bg-light bg-opacity-10">
                <form onSubmit={handleSubmit} noValidate>
                  <div className="row">
                    {/* NHÂN VIÊN */}
                    <div className="col-md-6 mb-4">
                      <label className="form-label fw-bold text-dark mb-2 d-block text-start">
                        Nhân viên <span className="text-danger">*</span>
                      </label>
                      <select
                        name="employeeId"
                        className="form-select shadow-none py-3"
                        value={formData.employeeId}
                        onChange={handleChange}
                        disabled={isLoading}
                      >
                        <option value="">Chọn nhân viên</option>
                        {employees.map((e) => (
                          <option key={e.id} value={e.id}>
                            {e.full_name || e.name || `NV #${e.id}`}
                          </option>
                        ))}
                      </select>
                    </div>

                    {/* CA LÀM */}
                    <div className="col-md-6 mb-4">
                      <label className="form-label fw-bold text-dark mb-2 d-block text-start">
                        Ca làm <span className="text-danger">*</span>
                      </label>
                      <select
                        name="shiftId"
                        className="form-select shadow-none py-3"
                        value={formData.shiftId}
                        onChange={handleChange}
                        disabled={isLoading}
                      >
                        <option value="">Chọn ca làm</option>
                        {shifts.map((s) => (
                          <option key={s.id} value={s.id}>
                            {s.name || s.shift_name || `Ca #${s.id}`}
                          </option>
                        ))}
                      </select>
                    </div>

                    {/* TRẠNG THÁI */}
                    <div className="col-md-6 mb-4">
                      <label className="form-label fw-bold text-dark mb-2 d-block text-start">
                        Trạng thái <span className="text-danger">*</span>
                      </label>
                      <select
                        name="status"
                        className="form-select shadow-none py-3"
                        value={formData.status}
                        onChange={handleChange}
                        disabled={isLoading}
                      >
                        <option value="">Chọn trạng thái</option>
                        <option value="3">Chưa duyệt</option>
                        <option value="1">Đang làm việc</option>
                        <option value="2">Nghỉ phép</option>
                        <option value="0">Đã nghỉ</option>
                      </select>
                    </div>

                    {/* NGÀY LÀM */}
                    <div className="col-md-6 mb-4">
                      <label className="form-label fw-bold text-dark mb-2 d-block text-start">
                        Ngày làm <span className="text-danger">*</span>
                      </label>
                      <input
                        type="date"
                        name="workDate"
                        className="form-control shadow-none py-3"
                        value={formData.workDate}
                        onChange={handleChange}
                        disabled={isLoading}
                      />
                    </div>
                  </div>

                  <div className="d-flex justify-content-start gap-3">
                    <button
                      type="button"
                      className="btn btn-outline-secondary fw-medium py-2 px-4 rounded-3 shadow-sm"
                      onClick={() => navigate(-1)}
                      disabled={isLoading}
                    >
                      HỦY
                    </button>

                    <button
                      type="submit"
                      className="btn btn-primary bg-gradient fw-medium py-2 px-4 rounded-3 shadow-sm d-flex align-items-center"
                      disabled={isLoading}
                    >
                      {isLoading ? (
                        <>
                          <span className="spinner-border spinner-border-sm me-2" aria-hidden="true"></span>
                          Đang lưu...
                        </>
                      ) : (
                        <>
                          <FaSave className="me-2" /> TẠO LỊCH
                        </>
                      )}
                    </button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default AddEmployeeShift;
