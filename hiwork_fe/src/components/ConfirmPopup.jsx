import React from "react";

const ConfirmPopup = ({
  show,             // true/false để hiển thị modal
  title = "Xác nhận",
  message = "Bạn có chắc chắn?",
  onConfirm,        // callback khi nhấn Xác nhận
  onCancel          // callback khi nhấn Hủy
}) => {
  if (!show) return null;

  return (
    <div className="modal d-block" tabIndex="-1" style={{ backgroundColor: "rgba(0,0,0,0.5)" }}>
      <div className="modal-dialog">
        <div className="modal-content shadow-lg">
          <div className="modal-header">
            <h5 className="modal-title">{title}</h5>
            <button type="button" className="btn-close" onClick={onCancel}></button>
          </div>
          <div className="modal-body">
            <p>{message}</p>
          </div>
          <div className="modal-footer">
            <button className="btn btn-secondary" onClick={onCancel}>
              Hủy
            </button>
            <button className="btn btn-danger" onClick={onConfirm}>
              Xác nhận
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ConfirmPopup;
