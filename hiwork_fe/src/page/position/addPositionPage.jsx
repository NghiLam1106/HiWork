import React, { useState } from "react";
import { FaSave } from "react-icons/fa";
import { toast } from "react-hot-toast"; // Thêm toast
import apiClient from "../../api/clientAppi";

const AddPosition = () => {
  const [title, setTitle] = useState("");
  const [error, setError] = useState("");
  const [isLoading, setIsLoading] = useState(false);

  const handleChange = (e) => {
    setTitle(e.target.value);
    if (error) setError("");
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError(""); // Reset lỗi cũ

    if (!title.trim()) {
      toast.error("Vui lòng nhập tên vị trí"); // toast khi validate lỗi
      return;
    }

    setIsLoading(true);

    try {
      const response = await apiClient.post("/positions/them-moi", {
        name: title,
      });

      if (response.status === 200 || response.status === 201) {
        toast.success("Đã thêm vị trí thành công!"); // toast success
        setTitle(""); // Reset form
      }
    } catch (err) {
      console.error("Lỗi API:", err);

      if (err.response) {
        toast.error(err.response.data.message || "Có lỗi từ server."); // toast lỗi từ BE
      } else if (err.request) {
        toast.error("Không thể kết nối đến Server. Vui lòng kiểm tra đường truyền.");
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
        <h1>Vị trí</h1>
      </header>

      <div className="container-fluid px-4" style={{ minHeight: "calc(100vh - 150px)" }}>
        <div className="row">
          <div className="col-12">
            <div className="card shadow-lg border-0 rounded-4 overflow-hidden">
              <div className="card-header bg-primary bg-gradient text-white p-3 border-0 text-start ps-4">
                <h5 className="mb-0 fw-bold">Thêm vị trí mới</h5>
              </div>

              <div className="card-body p-4 bg-light bg-opacity-10">
                <form onSubmit={handleSubmit} noValidate>
                  <div className="row w-100">
                    <div className="col-md-6 col-lg-5 p-0">
                      <div className="mb-4">
                        <label
                          htmlFor="title"
                          className="form-label fw-bold text-dark mb-2 d-block text-start"
                        >
                          Tên vị trí <span className="text-danger">*</span>
                        </label>

                        <input
                          type="text"
                          className="form-control shadow-none py-3"
                          id="title"
                          placeholder="Ví dụ: Senior Developer..."
                          value={title}
                          onChange={handleChange}
                          autoFocus
                          disabled={isLoading}
                        />
                      </div>
                    </div>
                  </div>

                  <div className="d-flex justify-content-start w-100">
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

export default AddPosition;
