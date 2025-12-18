import { useEffect, useState } from "react";
import { toast } from "react-hot-toast";
import { FaSave } from "react-icons/fa";
import { useParams } from "react-router-dom";
import apiClient from "../../../api/clientAppi";

const CompanyDetail = () => {
  const { id } = useParams();

  const [formData, setFormData] = useState({
    name: "",
    companyType: "",
    address: "",
  });

  const [loading, setLoading] = useState(true); // load dữ liệu lần đầu
  const [error, setError] = useState("");
  const [isLoading, setIsLoading] = useState(false); // submit

  useEffect(() => {
    const fetchCompany = async () => {
      setLoading(true);
      setError("");

      try {
        const res = await apiClient.get(`/manager/companies/${id}`);

        // Nếu backend trả trực tiếp res.data.{...}
        setFormData({
          name: res.data?.name || "",
          companyType: res.data?.companyType || "",
          address: res.data?.address || "",
        });
      } catch (err) {
        console.error(err);
        if (err.response?.status === 404) {
          setError("Không tìm thấy công ty.");
        } else {
          setError("Không thể tải dữ liệu công ty.");
        }
      } finally {
        setLoading(false);
      }
    };

    if (id) fetchCompany();
  }, [id]);

  const handleChangeName = (e) => {
    setFormData((prev) => ({ ...prev, name: e.target.value }));
    if (error) setError("");
  };

  const handleChangeCompanyType = (e) => {
    setFormData((prev) => ({ ...prev, companyType: e.target.value }));
    if (error) setError("");
  };

  const handleChangeAddress = (e) => {
    setFormData((prev) => ({ ...prev, address: e.target.value }));
    if (error) setError("");
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError("");

    if (!formData.name.trim()) {
      toast.error("Vui lòng nhập tên công ty");
      return;
    }
    if (!formData.companyType.trim()) {
      toast.error("Vui lòng chọn/nhập loại công ty");
      return;
    }
    if (!formData.address.trim()) {
      toast.error("Vui lòng nhập địa chỉ");
      return;
    }

    const payload = {
      name: formData.name.trim(),
      companyType: formData.companyType.trim(),
      address: formData.address.trim(),
    };

    setIsLoading(true);
    try {
      const res = await apiClient.put(`/manager/companies/${id}`, payload);

      if (res.status === 200) {
        toast.success("Cập nhật công ty thành công!");
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

  return (
    <>
      <header className="header mb-4">
        <h1>Công ty</h1>
      </header>

      <div className="container-fluid px-4" style={{ minHeight: "calc(100vh - 150px)" }}>
        <div className="row">
          <div className="col-12">
            <div className="card shadow-lg border-0 rounded-4 overflow-hidden">
              <div className="card-header bg-primary bg-gradient text-white p-3 border-0 text-start ps-4">
                <h5 className="mb-0 fw-bold">Thông tin công ty</h5>
              </div>

              <div className="card-body p-4 bg-light bg-opacity-10">
                {loading && (
                  <div className="text-center py-3">
                    <span className="spinner-border spinner-border-sm me-2" aria-hidden="true"></span>
                    Đang tải dữ liệu...
                  </div>
                )}

                {error && !loading && (
                  <div className="alert alert-danger border-0 shadow-sm rounded-3 mb-4">{error}</div>
                )}

                {!loading && !error && (
                  <form onSubmit={handleSubmit} noValidate>
                    <div className="row w-100 g-3">
                      {/* Tên công ty */}
                      <div className="col-md-6 col-lg-5">
                        <label className="form-label fw-bold text-dark mb-2 d-block text-start">
                          Tên công ty <span className="text-danger">*</span>
                        </label>
                        <input
                          type="text"
                          className="form-control shadow-none py-3"
                          placeholder="Ví dụ: MegaMart..."
                          value={formData.name}
                          onChange={handleChangeName}
                          autoFocus
                          disabled={isLoading}
                        />
                      </div>

                      {/* Loại công ty */}
                      <div className="col-md-6 col-lg-5">
                        <label className="form-label fw-bold text-dark mb-2 d-block text-start">
                          Loại công ty <span className="text-danger">*</span>
                        </label>
                        <select
                          className="form-select shadow-none py-3"
                          value={formData.companyType}
                          onChange={handleChangeCompanyType}
                          disabled={isLoading}
                        >
                          <option value="">-- Chọn loại công ty --</option>
                          <option value="Startup">Startup</option>
                          <option value="SME">SME</option>
                          <option value="Enterprise">Enterprise</option>
                          <option value="Outsource">Outsource</option>
                          <option value="Business">Business</option>
                          <option value="Khác">Khác</option>
                        </select>
                      </div>

                      {/* Địa chỉ */}
                      <div className="col-12 col-lg-10">
                        <label className="form-label fw-bold text-dark mb-2 d-block text-start">
                          Địa chỉ <span className="text-danger">*</span>
                        </label>
                        <input
                          type="text"
                          className="form-control shadow-none py-3"
                          placeholder="Ví dụ: 470 Trần Đại Nghĩa, Hoà Hải, Ngũ Hành Sơn, Đà Nẵng..."
                          value={formData.address}
                          onChange={handleChangeAddress}
                          disabled={isLoading}
                        />
                      </div>
                    </div>

                    <div className="d-flex justify-content-start w-100 mt-4">
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
                            <FaSave className="me-2" /> CẬP NHẬT
                          </>
                        )}
                      </button>
                    </div>
                  </form>
                )}
              </div>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default CompanyDetail;
