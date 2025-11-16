// src/components/Sidebar.js

import { useState } from 'react';
import { NavLink, Link, useNavigate } from 'react-router-dom';
import './css/Sidebar.css'; // Chúng ta sẽ tạo file CSS này ở bước 3

// Import icons
import {
  FaBars // Icon cho nút menu
  ,
  FaBuilding,
  FaChartBar,
  FaCog,
  FaRegCalendarCheck,
  FaSignOutAlt,
  FaTachometerAlt,
  FaUsers
} from 'react-icons/fa';

const Sidebar = () => {
  const [isClosed, setIsClosed] = useState(false); // Trạng thái đóng/mở
  const navigate = useNavigate();

  const toggleSidebar = () => {
    setIsClosed(!isClosed);
  };

  const handleLogout = () => {
    localStorage.removeItem("token");

    navigate('/auth', { replace: true });
  };

  return (
    // Thêm class 'closed' khi isClosed là true
    <div className={`sidebar ${isClosed ? 'closed' : ''}`}>
      <div className="sidebar-header">
        {/* Chỉ hiển thị 'HR Admin' khi sidebar mở */}
        {!isClosed && <h1 className="sidebar-logo">HR Admin</h1>}

        <button className="sidebar-toggle" onClick={toggleSidebar}>
          <FaBars />
        </button>
      </div>

      <nav className="sidebar-menu">
        <NavLink to="/home" className="sidebar-link">
          <FaTachometerAlt className="icon" />
          Dashboard
        </NavLink>
        <NavLink to="/nhan-vien" className="sidebar-link">
          <FaUsers className="icon" />
          Nhân viên
        </NavLink>
        <NavLink to="/phong-ban" className="sidebar-link">
          <FaBuilding className="icon" />
          Phòng ban
        </NavLink>
        <NavLink to="/cham-cong" className="sidebar-link">
          <FaRegCalendarCheck className="icon" />
          Chấm công
        </NavLink>
        <NavLink to="/bao-cao" className="sidebar-link">
          <FaChartBar className="icon" />
          Báo cáo
        </NavLink>
        <NavLink to="/cai-dat" className="sidebar-link">
          <FaCog className="icon" />
          Cài đặt
        </NavLink>
      </nav>

      {/* Đẩy mục Đăng xuất xuống dưới cùng */}
      <div className="sidebar-footer">
        {/* Thay thế <Link>... bằng <button>... */}
        <button onClick={handleLogout} className="sidebar-link logout-link">
          <FaSignOutAlt className="icon" />
          <span>Đăng xuất</span>
        </button>
      </div>
    </div>
  );
};

export default Sidebar;
