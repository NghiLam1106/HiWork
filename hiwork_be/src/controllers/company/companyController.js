const e = require("express");
const companyService = require("../../service/company/companyService");

const companyController = {
  async getAllCompanies(req, res) {
    try {
      const result = await companyService.getAllCompanies(req);
      res.status(200).json({ success: true, ...result });
    } catch (err) {
      res.status(500).json({ success: false, message: err.message });
    }
  },

  async getCompanyById(req, res) {
    try {
      const id = req.params.id;
      const company = await companyService.getCompanyById(id);
      if (!company)
        return res.status(404).json({ message: "Không tìm thấy công ty" });
      res.json(company);
    } catch (err) {
      console.error(err);
      res.status(500).json({ message: "Lỗi server" });
    }
  },

  async createCompany(req, res) {
    try {
      const newCompany = await companyService.createCompany(req.body);
      res.status(201).json({
        success: true,
        message: "Tạo công ty thành công!",
        data: newCompany,
      });
    } catch (err) {
      res.status(400).json({ success: false, message: err.message });
    }
  },

  async updateCompany(req, res) {
    try {
      const updated = await companyService.updateCompany(
        req.params.id,
        req.body.name
      );
      res
        .status(200)
        .json({
          success: true,
          message: "Cập nhật thành công.",
          data: updated,
        });
    } catch (err) {
      res.status(404).json({ success: false, message: err.message });
    }
  },

  async deleteCompany(req, res) {
    try {
      await companyService.deleteCompany(req.params.id);
      res
        .status(200)
        .json({ success: true, message: "Xóa công ty thành công." });
    } catch (err) {
      res.status(404).json({ success: false, message: err.message });
    }
  },
};

exports = module.exports = companyController;
