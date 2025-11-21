// src/components/Sidebar.js

import { useState } from "react";
import { NavLink, useNavigate, useLocation } from "react-router-dom";
import "./css/Sidebar.css";

// Import icons
import {
  FaBars,
  FaBuilding,
  FaChartBar,
  FaCog,
  FaRegCalendarCheck,
  FaSignOutAlt,
  FaTachometerAlt,
  FaUsers,
  FaShoppingBag,
  FaChevronDown, // Icon mũi tên xuống
  FaChevronRight, // Icon mũi tên phải
} from "react-icons/fa";

const Sidebar = () => {
  const [isClosed, setIsClosed] = useState(false);
  const [expandedMenu, setExpandedMenu] = useState({}); // State quản lý menu nào đang mở
  const navigate = useNavigate();
  const location = useLocation();

  // Cấu hình danh sách menu
  const menuItems = [
    {
      path: "/admin/home",
      name: "Dashboard",
      icon: <FaTachometerAlt />,
    },
    {
      name: "Nhân viên",
      icon: <FaUsers />,
      path: "/admin/nhan-vien",
    },
    {
      name: "Vị trí",
      icon: <FaBuilding />,
      path: "/admin/vi-tri",
    },
    {
      path: "/admin/ca-lam",
      name: "Ca làm",
      icon: <FaShoppingBag />,
    },
    {
      path: "/admin/cham-cong",
      name: "Chấm công",
      icon: <FaRegCalendarCheck />,
    },
    {
      path: "/admin/bao-cao",
      name: "Báo cáo",
      icon: <FaChartBar />,
    },
    {
      path: "/admin/cai-dat",
      name: "Cài đặt",
      icon: <FaCog />,
    },
  ];

  const toggleSidebar = () => {
    setIsClosed(!isClosed);
  };

  // Hàm xử lý khi click vào menu cha có sub-menu
  const toggleSubMenu = (index) => {
    // Nếu sidebar đang đóng mà click menu, thì mở sidebar ra trước
    if (isClosed) {
      setIsClosed(false);
    }

    setExpandedMenu((prevState) => ({
      ...prevState,
      [index]: !prevState[index], // Đảo ngược trạng thái true/false của menu đó
    }));
  };

  const handleLogout = () => {
    localStorage.removeItem("token");
    navigate("/auth", { replace: true });
  };

  return (
    <div className={`sidebar ${isClosed ? "closed" : ""}`}>
      <div className="sidebar-header">
        {!isClosed && <h1 className="sidebar-logo">HR Admin</h1>}
        <button className="sidebar-toggle" onClick={toggleSidebar}>
          <FaBars />
        </button>
      </div>

      <nav className="sidebar-menu">
        {menuItems.map((item, index) => {
          // Kiểm tra xem item này có subItems không
          if (item.subItems) {
            return (
              <div key={index} className="menu-item-container">
                {/* Menu Cha (Dùng div thay vì NavLink để tránh chuyển trang ngay) */}
                <div
                  className={`sidebar-link has-submenu ${
                    expandedMenu[index] ? "expanded" : ""
                  }`}
                  onClick={() => toggleSubMenu(index)}
                >
                  <div className="link-content">
                    <span className="icon">{item.icon}</span>
                    <span className="text">{item.name}</span>
                  </div>
                  {/* Mũi tên xoay */}
                  {!isClosed && (
                    <span className="arrow-icon">
                      {expandedMenu[index] ? (
                        <FaChevronDown />
                      ) : (
                        <FaChevronRight />
                      )}
                    </span>
                  )}
                </div>

                {/* Menu Con (Hiển thị khi expandedMenu[index] là true và sidebar đang mở) */}
                {!isClosed && expandedMenu[index] && (
                  <div className="submenu">
                    {item.subItems.map((sub, subIndex) => (
                      <NavLink
                        key={subIndex}
                        to={sub.path}
                        className="sidebar-link submenu-link"
                      >
                        <span className="submenu-dot"></span>
                        <span>{sub.name}</span>
                      </NavLink>
                    ))}
                  </div>
                )}
              </div>
            );
          } else {
            // Menu thường (không có con)
            return (
              <NavLink key={index} to={item.path} className="sidebar-link">
                <div className="link-content">
                  <span className="icon">{item.icon}</span>
                  <span className="text">{item.name}</span>
                </div>
              </NavLink>
            );
          }
        })}
      </nav>

      <div className="sidebar-footer">
        <button onClick={handleLogout} className="sidebar-link logout-link">
          <div className="link-content">
            <FaSignOutAlt className="icon" />
            <span className="text">Đăng xuất</span>
          </div>
        </button>
      </div>
    </div>
  );
};

export default Sidebar;
