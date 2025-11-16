
const DashboardCard = ({ title, number, color }) => {
  return (
    <div className="dashboard-card" style={{ borderTop: `5px solid ${color}` }}>
      <h3>{title}</h3>
      <p>{number}</p>
    </div>
  );
};

export default DashboardCard;
