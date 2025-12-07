import PositionTable from "../../../components/PositionTable";
import SearchBar from "../../../layouts/SearchBar";
import "../user/userPage.css";

const Position = () => {
  return (
    <>
      <header className="header">
        <h1>Vị trí</h1>
        <SearchBar />
      </header>
      <PositionTable />
    </>
  );
};

export default Position;
