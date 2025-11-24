const positionService = require("../../service/position/positionService");

exports.getAllPositions = async (req, res) => {
  try {
    const result = await positionService.getAllPositions(req);
    res.status(200).json({ success: true, ...result });
  } catch (err) {
    res.status(500).json({ success: false, message: err.message });
  }
};

exports.getPositionById = async (req, res) => {
  try {
    const id = req.params.id;
    const position = await positionService.getPositionById(id);
    if (!position) return res.status(404).json({ message: 'Không tìm thấy vị trí' });
    res.json(position);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Lỗi server' });
  }
};

exports.createPosition = async (req, res) => {
  try {
    const newPosition = await positionService.createPosition(req.body.name);
    res.status(201).json({
      success: true,
      message: "Tạo chức vụ thành công!",
      data: newPosition
    });
  } catch (err) {
    res.status(400).json({ success: false, message: err.message });
  }
};

exports.updatePosition = async (req, res) => {
  try {
    console.log("Updating position with ID:", req.params.id, "and name:", req.body.name);
    const updated = await positionService.updatePosition(req.params.id, req.body.name);
    res.status(200).json({ success: true, message: "Cập nhật thành công.", data: updated });
  } catch (err) {
    res.status(404).json({ success: false, message: err.message });
  }
};

exports.deletePosition = async (req, res) => {
  try {
    await positionService.deletePosition(req.params.id);
    res.status(200).json({ success: true, message: "Xóa chức vụ thành công." });
  } catch (err) {
    res.status(404).json({ success: false, message: err.message });
  }
};
