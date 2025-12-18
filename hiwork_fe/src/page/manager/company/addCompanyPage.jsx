import React, { useState } from "react";
import { FaSave } from "react-icons/fa";
import { toast } from "react-hot-toast";
import apiClient from "../../../api/clientAppi";

const AddCompany = () => {
  const [formData, setFormData] = useState({
    name: "",
    companyType: "",
    address: "",
  });

  const [error, setError] = useState("");
  const [isLoading, setIsLoading] = useState(false);

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
      name: formData.name,
      companyType: formData.companyType,
      address: formData.address,
    };

    setIsLoading(true);

    try {
      const response = await apiClient.post("/manager/companies/them-moi", payload);

      if (response.status === 200 || response.status === 201) {
        toast.success("Đã thêm công ty thành công!");
        setFormData({ name: "", companyType: "", address: "" });
      }
    } catch (err) {
      console.error("Lỗi API:", err);

      if (err.response) {
        toast.error(err.response.data.message || "Có lỗi từ server.");
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
                <h5 className="mb-0 fw-bold">Thêm công ty mới</h5>
              </div>

              <div className="card-body p-4 bg-light bg-opacity-10">
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

export default AddCompany;
