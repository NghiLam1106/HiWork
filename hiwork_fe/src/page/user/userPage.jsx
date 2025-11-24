
import EmployeeTable from "../../components/EmployeeTable";
import SearchBar from "../../layouts/SearchBar";
import "../user/userPage.css";

const User = () => {
  return (
    <>
      <header className="header">
        <h1>User</h1>
        <SearchBar />
      </header>
      <EmployeeTable />
    </>
  );
};

export default User;
