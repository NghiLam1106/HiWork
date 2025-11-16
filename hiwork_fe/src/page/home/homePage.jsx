import React from "react";
import Sidebar from "../../layouts/Sidebar";
import Header from "../../layouts/Header";
import DashboardCard from "../../components/DashboardCard";
import EmployeeTable from "../../components/EmployeeTable";
import "../home/homePage.css";

const Home = () => {
  return (
    <div className="admin-container">
      <Sidebar />
      <div className="main-content">
        <Header />
        <div className="dashboard-cards">
          <DashboardCard title="Nhân viên" number={120} color="#4CAF50" />
          <DashboardCard title="Phòng ban" number={8} color="#2196F3" />
          <DashboardCard title="Chấm công hôm nay" number={95} color="#FF9800" />
          <DashboardCard title="Nghỉ phép" number={5} color="#F44336" />
        </div>
        <EmployeeTable />
      </div>
    </div>
  );
};

export default Home;
