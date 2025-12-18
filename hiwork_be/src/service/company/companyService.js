const companyRepository = require("../../repository/company/companyRepository");

class CompanyService {
  // Lấy tất cả công ty
  async getAllCompanies(req) {
    return await companyRepository.getAllCompanies(req);
  }

  // Tạo mới công ty
  async createCompany(data) {
    if (!data.name || data.name.trim() === "") {
      throw new Error("Tên chức vụ không được để trống.");
    }

    const exist = await companyRepository.findByName(data.name);
    if (exist) {
      throw new Error("Chức vụ này đã tồn tại.");
    }

    return await companyRepository.create(data);
  }

  // Cập nhật công ty
  async updateCompany(id, name) {
    const company = await companyRepository.findById(id);
    if (!company) {
      throw new Error("Không tìm thấy công ty.");
    }

    company.name = name;
    return await companyRepository.save(company);
  }

  // Xóa công ty
  async deleteCompany(id) {
    const company = await companyRepository.findById(id);
    if (!company) {
      throw new Error("Không tìm thấy công ty.");
    }

    await companyRepository.delete(company);
    return company;
  }

  // Lấy công ty theo ID
  async getCompanyById(id) {
    return await companyRepository.findById(id);
  }
}

module.exports = new CompanyService();
