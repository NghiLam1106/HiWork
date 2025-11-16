import React from "react";

const Header = () => {
  return (
    <header className="header">
      <h1>Dashboard</h1>
      <div className="header-actions">
        <input type="text" placeholder="Tìm kiếm..." />
      </div>
    </header>
  );
};

export default Header;
