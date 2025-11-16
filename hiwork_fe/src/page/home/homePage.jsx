import DashboardCard from "../../components/DashboardCard";
import EmployeeTable from "../../components/EmployeeTable";
import "../home/homePage.css";

const Home = () => {
  return (
    <>
      <header className="header">
        <h1>Dashboard</h1>
        <div className="header-actions">
          <input type="text" placeholder="Tìm kiếm..." />
        </div>
      </header>
      <div className="dashboard-cards">
        <DashboardCard title="Nhân viên" number={120} color="#4CAF50" />
        <DashboardCard title="Phòng ban" number={8} color="#2196F3" />
        <DashboardCard title="Chấm công hôm nay" number={95} color="#FF9800" />
        <DashboardCard title="Nghỉ phép" number={5} color="#F44336" />
      </div>
      <EmployeeTable />
    </>
  );
};

export default Home;
