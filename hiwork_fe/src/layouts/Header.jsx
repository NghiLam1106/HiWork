import React from "react";

const Header = () => {
  return (<>
    <header className="header">
      <h1>Dashboard</h1>
      {/* <div className="header-actions">
        <input type="text" placeholder="Tìm kiếm..." />
      </div> */}
      <div className="d-flex align-items-center">
        <form className="w-100 me-3">
          <input type="search" className="form-control" placeholder="Search..." aria-label="Search" />
        </form>
      </div>
    </header>
    </>
  );
};

export default Header;
