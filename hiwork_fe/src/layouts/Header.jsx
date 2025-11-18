import React from "react";
import { FaSearch, FaBell, FaUserCircle } from "react-icons/fa"; // Import thêm icon thông báo và user để Header đỡ trống

const Header = () => {
  return (
    <header className="navbar navbar-expand bg-white border-bottom px-4 py-3 shadow-sm sticky-top">
      {/* 1. Tiêu đề Dashboard */}
      <div className="d-flex align-items-center">
        <h2 className="fs-4 fw-bold mb-0 text-primary">Dashboard</h2>
      </div>

      {/* 2. Khu vực bên phải: Search + Actions */}
      <div className="d-flex align-items-center gap-4 ms-auto">

        {/* --- THANH TÌM KIẾM HIỆN ĐẠI --- */}
        <form className="position-relative d-none d-md-block">
          <div className="input-group">
            {/* Icon Search: Nền xám nhạt, bo tròn đầu trái */}
            <span
              className="input-group-text bg-light border-0 rounded-start-pill ps-3 text-muted"
              style={{ cursor: "pointer" }}
            >
              <FaSearch />
            </span>

            {/* Input: Nền xám nhạt, bo tròn đầu phải, bỏ viền */}
            <input
              type="search"
              className="form-control bg-light border-0 rounded-end-pill shadow-none"
              placeholder="Tìm kiếm..."
              aria-label="Search"
              style={{ width: "250px" }} // Độ rộng vừa phải
            />
          </div>
        </form>
        {/* ------------------------------- */}

        {/* Các icon phụ (Thông báo, Avatar) để Header trông chuyên nghiệp hơn */}
        <div className="d-flex align-items-center gap-3 text-secondary">
          <button className="btn btn-light rounded-circle p-2 d-flex align-items-center justify-content-center position-relative">
             <FaBell size={18} />
             {/* Chấm đỏ thông báo */}
             <span className="position-absolute top-0 start-100 translate-middle p-1 bg-danger border border-light rounded-circle">
                <span className="visually-hidden">New alerts</span>
             </span>
          </button>

          <div className="d-flex align-items-center gap-2" style={{cursor: 'pointer'}}>
             <FaUserCircle size={28} className="text-primary"/>
             <div className="d-none d-lg-block">
                <small className="d-block fw-bold text-dark" style={{fontSize: '0.85rem'}}>Admin User</small>
             </div>
          </div>
        </div>

      </div>
    </header>
  );
};

export default Header;
