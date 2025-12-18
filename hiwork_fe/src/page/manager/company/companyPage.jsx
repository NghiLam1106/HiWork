import CompanyTable from "../../../components/CompanyTable";
import SearchBar from "../../../layouts/SearchBar";
import "../user/userPage.css";

const Company = () => {
  return (
    <>
      <header className="header">
        <h1>Công ty</h1>
        <SearchBar />
      </header>
      <CompanyTable />
    </>
  );
};

export default Company;
