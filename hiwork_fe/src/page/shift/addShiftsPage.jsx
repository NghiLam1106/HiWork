import React, { useState } from "react";
import { FaSave } from "react-icons/fa";
import { toast } from "react-hot-toast";
import apiClient from "../../api/clientAppi";

const AddShift = () => {
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
    // time FE nhận từ input type=time dạng HH:mm
    if (!time) return "";

    // Nếu đã có giây rồi thì giữ nguyên
    if (time.length === 8) return time;

    // Nếu dạng HH:mm → thêm giây
    return `${time}:00`;
  };

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

    console.log("Submitting form data:", formatTime(formData.startTime), formatTime(formData.endTime));

    // Tạo body chuẩn hóa
    const payload = {
      name: formData.name,
      startTime: formatTime(formData.startTime),
      endTime: formatTime(formData.endTime),
    };

    setIsLoading(true);

    try {
      const response = await apiClient.post("/shifts/them-moi", payload);

      if (response.status === 200 || response.status === 201) {
        toast.success("Đã thêm ca làm thành công!");

        setFormData({
          name: "",
          startTime: "",
          endTime: "",
        });
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
        <h1>Ca làm</h1>
      </header>

      <div
        className="container-fluid px-4"
        style={{ minHeight: "calc(100vh - 150px)" }}
      >
        <div className="row">
          <div className="col-12">
            <div className="card shadow-lg border-0 rounded-4 overflow-hidden">
              <div className="card-header bg-primary bg-gradient text-white p-3 border-0 text-start ps-4">
                <h5 className="mb-0 fw-bold">Thêm ca làm mới</h5>
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
                          step="60" // ÉP 24 GIỜ
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
                          step="60" // ÉP 24 GIỜ
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

export default AddShift;
