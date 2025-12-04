import { useEffect, useState } from "react";
import { toast } from "react-hot-toast"; // Thêm thư viện toast
import { FaSave } from "react-icons/fa";
import { useParams } from "react-router-dom";
import apiClient from "../../../api/clientAppi";

const PositionDetail = () => {
  const { id } = useParams();
  const [title, setTitle] = useState("");
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [isSaving, setIsSaving] = useState(false);

  useEffect(() => {
    const fetchPosition = async () => {
      setLoading(true);
      try {
        const res = await apiClient.get(`manager/positions/${id}`);
        setTitle(res.data.name || "");
        setError("");
      } catch (err) {
        console.error(err);
        if (err.response && err.response.status === 404) {
          setError("Không tìm thấy vị trí.");
        } else {
          setError("Không thể tải dữ liệu vị trí.");
        }
      } finally {
        setLoading(false);
      }
    };

    fetchPosition();
  }, [id]);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError("");

    if (!title.trim()) {
      setError("Vui lòng nhập tên vị trí");
      return;
    }

    setIsSaving(true);
    try {
      const res = await apiClient.put(`/manager/positions/${id}`, { name: title });

      if (res.status === 200) {
        toast.success("Cập nhật vị trí thành công!"); // toast khi thành công
      }
    } catch (err) {
      console.error(err);
      if (err.response) {
        toast.error(err.response.data.message || "Có lỗi từ server."); // toast lỗi
      } else if (err.request) {
        toast.error("Không thể kết nối server.");
      } else {
        toast.error("Đã xảy ra lỗi.");
      }
    } finally {
      setIsSaving(false);
    }
  };

  return (
    <div className="container-fluid px-4" style={{ minHeight: "calc(100vh - 150px)" }}>

      <header className="header mb-4">
        <h1>Vị trí</h1>
      </header>

      <div className="row">
        <div className="col-12">
          <div className="card shadow-lg border-0 rounded-4 overflow-hidden">
            <div className="card-header bg-primary bg-gradient text-white p-3 border-0 text-start ps-4">
              <h5 className="mb-0 fw-bold">Thông tin vị trí</h5>
            </div>

            <div className="card-body p-4 bg-light bg-opacity-10">
              {loading && (
                <div className="text-center py-3">
                  <span className="spinner-border spinner-border-sm me-2"></span> Đang tải dữ liệu...
                </div>
              )}

              {error && !loading && (
                <div className="alert alert-danger border-0 shadow-sm rounded-3 mb-4">{error}</div>
              )}

              {!loading && !error && (
                <form onSubmit={handleSubmit} noValidate>
                  <div className="row w-100">
                    <div className="col-md-6 col-lg-5">
                      {/* Label nằm bên trên input, chữ nằm bên trái */}
                      <div className="mb-4">
                        <label className="form-label fw-bold mb-2 text-start d-block">
                          Tên vị trí <span className="text-danger">*</span>
                        </label>
                        <input
                          type="text"
                          className={`form-control shadow-none py-3 ${error.includes("tên vị trí") ? "is-invalid" : ""}`}
                          value={title}
                          onChange={(e) => setTitle(e.target.value)}
                          disabled={isSaving}
                        />
                        {error.includes("tên vị trí") && (
                          <div className="invalid-feedback">{error}</div>
                        )}
                      </div>

                      <div className="d-flex justify-content-start w-100">
                        <button
                          type="submit"
                          className="btn btn-primary bg-gradient fw-medium py-2 px-4 rounded-3 shadow-sm d-flex align-items-center"
                          disabled={isSaving}
                        >
                          {isSaving ? (
                            <>
                              <span className="spinner-border spinner-border-sm me-2"></span>
                              Đang lưu...
                            </>
                          ) : (
                            <>
                              <FaSave className="me-2" /> CẬP NHẬT
                            </>
                          )}
                        </button>
                      </div>
                    </div>
                  </div>
                </form>
              )}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default PositionDetail;
