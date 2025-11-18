
import { Outlet } from 'react-router-dom'; // 1. Import Outlet
import Sidebar from '../layouts/Sidebar';

const MainLayout = () => {
  return (
    <div className="d-flex">
      <Sidebar />

      {/* Phần nội dung chính sẽ thay đổi */}
      <div className="flex-grow-1 p-4">
        <Outlet />
      </div>
    </div>
  );
};

export default MainLayout;
