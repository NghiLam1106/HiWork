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
  FaUser,
  FaBriefcase,
  FaChevronDown, // Icon mũi tên xuống
  FaChevronRight, // Icon mũi tên phải
  FaUserTie
} from "react-icons/fa";

const Sidebar = () => {
  const [isClosed, setIsClosed] = useState(false);
  const [expandedMenu, setExpandedMenu] = useState({}); // State quản lý menu nào đang mở
  const userRole = localStorage.getItem("role");
  const userId = localStorage.getItem("userId");
  const navigate = useNavigate();
  const location = useLocation();

  // Cấu hình danh sách menu
  const menuItems = [
    {
      path: "manager/home",
      name: "Dashboard",
      icon: <FaTachometerAlt />,
      role: [1], // Chỉ hiển thị cho manager và admin
    },
    {
      path: "admin/home",
      name: "Dashboard",
      icon: <FaTachometerAlt />,
      role: [0], // Chỉ hiển thị cho manager và admin
    },
    {
      path: `/manager/profile/${userId}`,
      name: "Thông tin cá nhân",
      icon: <FaUser />,
      role: [1], // Chỉ hiển thị cho manager
    },
    {
      path: `/admin/profile/${userId}`,
      name: "Thông tin cá nhân",
      icon: <FaUser />,
      role: [0], // Chỉ hiển thị cho admin
    },
    {
      name: "Nhân viên",
      icon: <FaUsers />,
      path: "/manager/nhan-vien",
      role: [1], // Chỉ hiển thị cho manager
    },
    {
      name: "Vị trí",
      icon: <FaUserTie />,
      path: "/manager/vi-tri",
      role: [1], // Chỉ hiển thị cho manager
    },
    {
      path: "/manager/ca-lam",
      name: "Ca làm",
      icon: <FaBriefcase />,
      role: [1], // Chỉ hiển thị cho manager
    },
    {
      name: "Công ty",
      icon: <FaBuilding />,
      path: "/manager/cong-ty",
      role: [1], // Chỉ hiển thị cho manager
    },
    {
      path: "/manager/cham-cong",
      name: "Chấm công",
      icon: <FaRegCalendarCheck />,
      role: [1], // Chỉ hiển thị cho manager
    },
    {
      path: "/manager/bao-cao",
      name: "Báo cáo",
      icon: <FaChartBar />,
      role: [1], // Chỉ hiển thị cho manager
    },
    {
      path: "/manager/cai-dat",
      name: "Cài đặt",
      icon: <FaCog />,
      role: [1], // Chỉ hiển thị cho manager
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
    localStorage.removeItem("role");
    localStorage.removeItem("userId");
    navigate("/auth", { replace: true });
  };

  return (
    <div className={`sidebar ${isClosed ? "closed" : ""}`}>
      <div className="sidebar-header">
        {!isClosed && <h1 className="sidebar-logo">{parseInt(userRole) === 1 ? "Manager" : parseInt(userRole) === 0 ? "Admin" : ""}</h1>}
        <button className="sidebar-toggle" onClick={toggleSidebar}>
          <FaBars />
        </button>
      </div>

      <nav className="sidebar-menu">
        {menuItems.map((item, index) => {
          if (!item.role.includes(parseInt(userRole))) {
            return null;
          }
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
