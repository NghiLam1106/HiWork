
import EmployeeTable from "../../components/EmployeeTable";
import "../user/userPage.css";

const User = () => {
  return (
    <>
      <header className="header">
        <h1>User</h1>
        <div className="d-flex align-items-center">
        <form className="p-0" style={{ width: 500 }}>
          <input type="search" className="form-control m-0" placeholder="Search..." aria-label="Search" />
        </form>
      </div>
      </header>
      <EmployeeTable />
    </>
  );
};

export default User;
