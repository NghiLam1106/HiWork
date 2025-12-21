import React, { useEffect, useMemo, useState } from "react";
import { FaSave } from "react-icons/fa";
import { toast } from "react-hot-toast";
import apiClient from "../../../api/clientAppi";
import { useNavigate, useParams } from "react-router-dom";

const formatDateTime = (v) => {
  if (!v) return "—";
  const d = new Date(v);
  if (Number.isNaN(d.getTime())) return "—";
  return d.toLocaleString("vi-VN", {
    hour12: false,
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
    hour: "2-digit",
    minute: "2-digit",
  });
};

const formatPercent = (v) => {
  if (v === null || v === undefined || v === "") return "—";
  const n = Number(v);
  if (Number.isNaN(n)) return "—";
  return `${Math.round(n * 100)}%`;
};

const statusLabel = (status) => {
  switch (Number(status)) {
    case 1:
      return <span className="badge bg-success">Đang làm việc</span>;
    case 2:
      return <span className="badge bg-warning text-dark">Nghỉ phép</span>;
    case 0:
      return <span className="badge bg-secondary">Đã nghỉ</span>;
    case 3:
      return <span className="badge bg-danger">Chưa duyệt</span>;
    default:
      return <span className="badge bg-light text-dark">Khác</span>;
  }
};

const UpdateAttendanceShift = () => {
  const [formData, setFormData] = useState({
    status: "",
    photoUrl: "", // url hiện tại từ server (nếu có)
  });

  const [record, setRecord] = useState(null);

  // ✅ thêm state cho upload ảnh
  const [photoFile, setPhotoFile] = useState(null); // File người dùng chọn
  const [photoPreview, setPhotoPreview] = useState(""); // preview local blob URL

  const [isLoading, setIsLoading] = useState(false);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  const navigate = useNavigate();
  const { id } = useParams();

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        setError("");

        const res = await apiClient.get(`/manager/cham-cong/${id}`);
        const data = res.data?.data || res.data;

        setRecord(data);

        setFormData({
          status: data?.status ?? "",
          photoUrl: data?.photoUrl ?? "", // ảnh đang lưu
        });

        // reset upload state
        setPhotoFile(null);
        setPhotoPreview("");
      } catch (err) {
        console.log(err);
        setError("Không thể tải dữ liệu chấm công.");
      } finally {
        setLoading(false);
      }
    };

    fetchData();

    // cleanup preview blob khi unmount
    return () => {
      if (photoPreview) URL.revokeObjectURL(photoPreview);
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [id]);

  const employeeInfo = useMemo(() => {
    const emp = record?.employeeSchedule?.employee || record?.employee || null;
    return {
      id: emp?.id ?? "—",
      name: emp?.full_name || emp?.fullName || emp?.name || "—",
      avatar: emp?.avatar_url || emp?.avatarUrl || "",
      email: emp?.email || "",
    };
  }, [record]);

  const shiftInfo = useMemo(() => {
    const sh = record?.employeeSchedule?.shift || record?.shift || null;
    return {
      id: sh?.id ?? "—",
      name: sh?.name || sh?.shift_name || sh?.shiftName || "—",
      start: sh?.startTime || sh?.start_time || "—",
      end: sh?.endTime || sh?.end_time || "—",
    };
  }, [record]);

  const scheduleInfo = useMemo(() => {
    const sc = record?.employeeSchedule || null;
    return {
      id: sc?.id ?? "—",
      workDate: sc?.work_date ? String(sc.work_date).slice(0, 10) : "—",
    };
  }, [record]);

  const handleChange = (e) => {
    setFormData((prev) => ({ ...prev, [e.target.name]: e.target.value }));
    if (error) setError("");
  };

  // ✅ chọn ảnh + preview
  const handlePickPhoto = (e) => {
    const file = e.target.files?.[0];
    if (!file) return;

    // validate basic
    if (!file.type.startsWith("image/")) {
      toast.error("Vui lòng chọn đúng file ảnh.");
      return;
    }
    const maxMB = 5;
    if (file.size > maxMB * 1024 * 1024) {
      toast.error(`Ảnh quá lớn. Vui lòng chọn ảnh ≤ ${maxMB}MB.`);
      return;
    }

    setPhotoFile(file);

    // revoke preview cũ nếu có
    if (photoPreview) URL.revokeObjectURL(photoPreview);

    const previewUrl = URL.createObjectURL(file);
    setPhotoPreview(previewUrl);
  };

  // ✅ upload ảnh lên server -> nhận url
  const uploadPhotoIfNeeded = async () => {
    if (!photoFile) return null;

    const fd = new FormData();
    fd.append("file", photoFile); // key "file" (đổi nếu backend bạn dùng key khác)

    // ⚠️ đổi endpoint upload cho đúng backend bạn
    const uploadRes = await apiClient.post(`/manager/uploads`, fd, {
      headers: { "Content-Type": "multipart/form-data" },
    });

    // ⚠️ đổi field trả về cho đúng backend bạn
    const url =
      uploadRes.data?.url ||
      uploadRes.data?.data?.url ||
      uploadRes.data?.data?.photoUrl ||
      uploadRes.data?.photoUrl;

    if (!url) throw new Error("Upload ảnh thất bại: không nhận được url.");

    return url;
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (formData.status === "" || formData.status === null)
      return toast.error("Vui lòng chọn trạng thái");

    setIsLoading(true);

    try {
      // 1) nếu user có chọn ảnh mới -> upload trước
      let uploadedUrl = null;
      if (photoFile) {
        uploadedUrl = await uploadPhotoIfNeeded();
      }

      // 2) update attendance
      const payload = {
        status: Number(formData.status),
        // nếu có upload ảnh mới => set url mới
        // nếu không upload => giữ nguyên photoUrl cũ (hoặc null tuỳ bạn)
        photoUrl: uploadedUrl ?? formData.photoUrl ?? null,
      };

      const res = await apiClient.put(`/manager/cham-cong/${id}`, payload);

      if (res.status === 200 || res.status === 201) {
        toast.success("Cập nhật chấm công thành công!");
        navigate(-1);
      }
    } catch (err) {
      console.error("Lỗi API:", err);

      // nếu lỗi uploadPhotoIfNeeded ném error string
      if (err?.message && String(err.message).includes("Upload ảnh")) {
        toast.error(err.message);
      } else if (err.response) {
        toast.error(err.response.data?.message || "Có lỗi từ server.");
      } else if (err.request) {
        toast.error(
          "Không thể kết nối đến Server. Vui lòng kiểm tra đường truyền."
        );
      } else {
        toast.error("Đã xảy ra lỗi không mong muốn.");
      }
    } finally {
      setIsLoading(false);
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
        />
      </div>
    );

  if (error) return <p className="text-danger text-center mt-4">{error}</p>;

  return (
    <>
    <header className="header mb-4">
      {/* <h1>Chấm công</h1> */}
    </header>

    <div className="container-fluid px-4" style={{ minHeight: "calc(100vh - 150px)" }}>
      <div className="row justify-content-center">
        <div className="col-12 col-xl-10">
          <div className="card shadow-lg border-0 rounded-4 overflow-hidden">
            {/* HEADER */}
            <div className="card-header bg-white border-0 p-4">
              <div className="d-flex align-items-start justify-content-between gap-3">
                <div>
                  <div className="fw-bold fs-5">Thông tin chấm công</div>
                </div>

                <span className="badge bg-secondary-subtle text-dark px-3 py-2 rounded-pill">
                  {statusLabel(record?.status)}
                </span>
              </div>
            </div>

            {/* BODY */}
            <div className="card-body p-4">
              <div className="row g-4">
                {/* LEFT BLOCK */}
                <div className="col-12 col-lg-7">
                  {/* Employee */}
                  <div className="p-3 border rounded-4 bg-opacity-10">
                    <div className="d-flex align-items-center gap-3">
                      <div
                        className="rounded-circle overflow-hidden border"
                        style={{ width: 56, height: 56, flex: "0 0 56px" }}
                      >
                        {employeeInfo.avatar ? (
                          <img
                            src={employeeInfo.avatar}
                            alt="avatar"
                            style={{ width: "100%", height: "100%", objectFit: "cover" }}
                          />
                        ) : (
                          <div className="w-100 h-100 d-flex align-items-center justify-content-center bg-secondary-subtle text-secondary">
                            NV
                          </div>
                        )}
                      </div>

                      <div className="flex-grow-1">
                        <div className="fw-bold text-dark">{employeeInfo.name}</div>
                        <div className="text-muted small">
                          {employeeInfo.email ? <> • {employeeInfo.email}</> : null}
                        </div>
                      </div>
                    </div>
                  </div>

                  {/* Shift */}
                  <div className="p-3 border rounded-4 mt-3">
                    <div className="text-muted small mb-1">Ca làm</div>
                    <div className="fw-semibold">{shiftInfo.name}</div>
                    <div className="text-muted small">
                      {shiftInfo.start} - {shiftInfo.end}
                    </div>
                  </div>

                  {/* Time */}
                  <div className="row g-3 mt-1">
                    <div className="col-12 col-md-6">
                      <div className="p-3 border rounded-4 h-100">
                        <div className="text-muted small mb-1">Giờ check-in</div>
                        <div className="fw-semibold">{formatDateTime(record?.checkIn)}</div>
                      </div>
                    </div>
                    <div className="col-12 col-md-6">
                      <div className="p-3 border rounded-4 h-100">
                        <div className="text-muted small mb-1">Giờ check-out</div>
                        <div className="fw-semibold">{formatDateTime(record?.checkOut)}</div>
                      </div>
                    </div>
                  </div>

                  {/* Confidence */}
                  <div className="p-3 border rounded-4 mt-3">
                    <div className="text-muted small mb-1">Tỉ lệ nhận diện (confidence)</div>

                    <div className="d-flex align-items-center gap-3">
                      <div className="fw-semibold" style={{ minWidth: 56 }}>
                        {formatPercent(record?.confidenceScore)}
                      </div>

                      <div className="flex-grow-1">
                        <div className="progress" style={{ height: 10, borderRadius: 999 }}>
                          <div
                            className="progress-bar"
                            role="progressbar"
                            style={{
                              width: `${Math.min(
                                100,
                                Math.max(
                                  0,
                                  Math.round(Number(record?.confidenceScore || 0) * 100)
                                )
                              )}%`,
                              borderRadius: 999,
                            }}
                          />
                        </div>
                      </div>
                    </div>

                    <div className="text-muted small mt-2">
                      (Giá trị lưu: {record?.confidenceScore ?? "—"})
                    </div>
                  </div>
                </div>

                {/* RIGHT BLOCK */}
                <div className="col-12 col-lg-5">
                  {/* Photo current */}
                  <div className="p-3 border rounded-4">
                    <div className="text-muted small mb-2">Ảnh chấm công hiện tại</div>

                    {formData.photoUrl ? (
                      <div
                        className="rounded-4 overflow-hidden border d-flex align-items-center justify-content-center"
                        style={{
                          width: "100%",
                          height: 320, // ✅ cao hơn chút cho đẹp (bạn đổi 260/300/340 tuỳ)
                          background: "#f8f9fa",
                        }}
                      >
                        <img
                          src={formData.photoUrl}
                          alt="attendance"
                          style={{
                            width: "100%",
                            height: "100%",
                            objectFit: "contain",
                            display: "block",
                          }}
                        />
                      </div>
                    ) : (
                      <div
                        className="d-flex align-items-center justify-content-center text-muted rounded-4"
                        style={{ height: 320, background: "#f8f9fa" }}
                      >
                        Chưa có ảnh
                      </div>
                    )}
                  </div>

                  {/* Update status (moved here) */}
                  <div className="p-3 border rounded-4 mt-3 bg-opacity-10">
                    <label className="form-label fw-bold text-dark mb-2 d-block text-start">
                      Cập nhật trạng thái <span className="text-danger">*</span>
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

                    {/* Actions */}
                    <div className="d-flex justify-content-center gap-3 mt-3">
                      <button
                        type="button"
                        className="btn btn-outline-secondary fw-medium py-2 px-4 rounded-3 shadow-sm"
                        onClick={() => navigate(-1)}
                        disabled={isLoading}
                      >
                        HỦY
                      </button>

                      <button
                        type="button"
                        onClick={handleSubmit}
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
                            <FaSave className="me-2" /> LƯU THAY ĐỔI
                          </>
                        )}
                      </button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            {/* END BODY */}
          </div>
        </div>
      </div>
    </div>
  </>
  );
};

export default UpdateAttendanceShift;
