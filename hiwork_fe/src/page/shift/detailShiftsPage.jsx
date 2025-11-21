import React, { useState, useEffect } from "react";
import { FaSave } from "react-icons/fa";
import { toast } from "react-hot-toast";
import { useParams } from "react-router-dom"; // để lấy id từ URL
import apiClient from "../../api/clientAppi";

const DetailShift = () => {
  const { id } = useParams(); // lấy id từ URL
  const [formData, setFormData] = useState({
    name: "",
    startTime: "",
    endTime: "",
  });

  const [isLoading, setIsLoading] = useState(false);

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const formatTime = (time) => {
    if (!time) return "";
    if (time.length === 8) return time; // HH:mm:ss
    return `${time}:00`; // HH:mm → HH:mm:ss
  };

  // --- LẤY DỮ LIỆU CA LÀM THEO ID ---
  const fetchShiftDetail = async () => {
    if (!id) return; // nếu không có id thì không gọi
    setIsLoading(true);
    try {
      const response = await apiClient.get(`/shifts/${id}`);
      if (response.status === 200) {
        const { name, startTime, endTime } = response.data;
        setFormData({
          name: name || "",
          startTime: startTime ? startTime.slice(0, 5) : "", // Lấy HH:mm
          endTime: endTime ? endTime.slice(0, 5) : "",
        });
      }
    } catch (err) {
      console.error("Lỗi khi lấy chi tiết ca làm:", err);
      toast.error("Không lấy được chi tiết ca làm.");
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    fetchShiftDetail();
  }, [id]);

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (!formData.name.trim()) {
      toast.error("Vui lòng nhập tên ca làm");
      return;
    }
    if (!formData.startTime) {
      toast.error("Vui lòng chọn giờ bắt đầu");
      return;
    }
    if (!formData.endTime) {
      toast.error("Vui lòng chọn giờ kết thúc");
      return;
    }

    const payload = {
      name: formData.name,
      startTime: formatTime(formData.startTime),
      endTime: formatTime(formData.endTime),
    };

    setIsLoading(true);
    try {
      let response;
      if (id) {
        // Update ca làm
        response = await apiClient.put(`/shifts/${id}`, payload);
      } else {
        // Thêm mới ca làm
        response = await apiClient.post("/shifts/them-moi", payload);
      }

      if (response.status === 200 || response.status === 201) {
        toast.success(
          id ? "Cập nhật ca làm thành công!" : "Thêm ca làm thành công!"
        );
      }
    } catch (err) {
      console.error("Lỗi API:", err);
      if (err.response) {
        toast.error(err.response.data.message || "Có lỗi từ server.");
      } else if (err.request) {
        toast.error("Không thể kết nối đến Server.");
      } else {
        toast.error("Đã xảy ra lỗi không mong muốn.");
      }
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <>
      <header className="header mb-4">
        <h1>{id ? "Chi tiết ca làm" : "Thêm ca làm"}</h1>
      </header>

      <div
        className="container-fluid px-4"
        style={{ minHeight: "calc(100vh - 150px)" }}
      >
        <div className="row">
          <div className="col-12">
            <div className="card shadow-lg border-0 rounded-4 overflow-hidden">
              <div className="card-header bg-primary bg-gradient text-white p-3 border-0 text-start ps-4">
                <h5 className="mb-0 fw-bold">
                  {id ? "Cập nhật ca làm" : "Thêm ca làm mới"}
                </h5>
              </div>

              <div className="card-body p-4 bg-light bg-opacity-10">
                <form onSubmit={handleSubmit} noValidate>
                  <div className="row w-100">
                    {/* Tên ca làm */}
                    <div className="col-md-6 col-lg-5 p-0">
                      <div className="mb-4">
                        <label className="form-label fw-bold text-dark mb-2 d-block text-start">
                          Tên ca làm <span className="text-danger">*</span>
                        </label>
                        <input
                          type="text"
                          className="form-control shadow-none py-3"
                          name="name"
                          placeholder="Ví dụ: Ca sáng..."
                          value={formData.name}
                          onChange={handleChange}
                          disabled={isLoading}
                          autoFocus
                        />
                      </div>
                    </div>

                    {/* Giờ bắt đầu */}
                    <div className="col-md-6 col-lg-3">
                      <div className="mb-4 ps-md-4">
                        <label className="form-label fw-bold text-dark mb-2">
                          Giờ bắt đầu <span className="text-danger">*</span>
                        </label>
                        <input
                          type="time"
                          step="60"
                          lang="en"
                          className="form-control shadow-none py-3"
                          name="startTime"
                          value={formData.startTime}
                          onChange={handleChange}
                          disabled={isLoading}
                        />
                      </div>
                    </div>

                    {/* Giờ kết thúc */}
                    <div className="col-md-6 col-lg-3">
                      <div className="mb-4 ps-md-4">
                        <label className="form-label fw-bold text-dark mb-2">
                          Giờ kết thúc <span className="text-danger">*</span>
                        </label>
                        <input
                          type="time"
                          step="60"
                          lang="en"
                          className="form-control shadow-none py-3"
                          name="endTime"
                          value={formData.endTime}
                          onChange={handleChange}
                          disabled={isLoading}
                        />
                      </div>
                    </div>
                  </div>

                  <div className="d-flex justify-content-start w-100 mt-3">
                    <button
                      type="submit"
                      className="btn btn-primary bg-gradient fw-medium py-2 px-4 rounded-3 shadow-sm d-flex align-items-center"
                      disabled={isLoading}
                    >
                      {isLoading ? (
                        <>
                          <span className="spinner-border spinner-border-sm me-2"></span>
                          Đang lưu...
                        </>
                      ) : (
                        <>
                          <FaSave className="me-2" /> LƯU LẠI
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

export default DetailShift;
