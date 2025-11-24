
import EmployeeTable from "../../components/EmployeeTable";
import "../user/userPage.css";

const Profile = () => {
  return (
    <>
      <header className="header">
        <h1>Profile</h1>
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

export default Profile;
