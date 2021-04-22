
DROP SCHEMA IF EXISTS `mydb` ;

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

DROP TABLE IF EXISTS `mydb`.`ViTri` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ViTri` (
  `idViTri` INT NOT NULL PRIMARY KEY  AUTO_INCREMENT,
  `TenViTri` VARCHAR(45) NOT NULL)
  
ENGINE = InnoDB;

DROP TABLE IF EXISTS `mydb`.`TrinhDo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`TrinhDo` (
  `idTrinhDo` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `TrinhDo` VARCHAR(45) NOT NULL
   )
ENGINE = InnoDB;

DROP TABLE IF EXISTS `mydb`.`BoPhan` ;

CREATE TABLE IF NOT EXISTS `mydb`.`BoPhan` (
  `idBoPhan` INT NOT NULL  PRIMARY KEY AUTO_INCREMENT,
  `TenBoPhan` VARCHAR(45) NOT NULL
  )
ENGINE = InnoDB;

DROP TABLE IF EXISTS `mydb`.`NhanVien` ;

CREATE TABLE IF NOT EXISTS `mydb`.`NhanVien` (
  `idNhanVien` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `HoTen` VARCHAR(255) NOT NULL,
  `NgaySinh` DATE NOT NULL,
  `SoCMND` VARCHAR(45) NOT NULL,
  `Luong` VARCHAR(45) NOT NULL,
  `SDT` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `DiaChi` VARCHAR(45) NOT NULL,
  `ViTri_idViTri` INT NOT NULL,
  `TrinhDo_idTrinhDo` INT NOT NULL,
  `BoPhan_idBoPhan` INT NOT NULL,
  constraint PK_NhanVien_ViTri foreign key(`ViTri_idViTri`) references ViTri(`idViTri`),
  constraint PK_NhanVien_TrinhDo foreign key(`TrinhDo_idTrinhDo`) references ViTri(`idTrinhDo`),
  constraint PK_NhanVien_BoPhan foreign key(`BoPhan_idBoPhan`) references ViTri(`idBoPhan`)
   )
ENGINE = InnoDB;

CREATE INDEX `fk_NhanVien_ViTri_idx` ON `mydb`.`NhanVien` (`ViTri_idViTri` ASC) VISIBLE;

CREATE INDEX `fk_NhanVien_TrinhDo1_idx` ON `mydb`.`NhanVien` (`TrinhDo_idTrinhDo` ASC) VISIBLE;

CREATE INDEX `fk_NhanVien_BoPhan1_idx` ON `mydb`.`NhanVien` (`BoPhan_idBoPhan` ASC) VISIBLE;

DROP TABLE IF EXISTS `mydb`.`LoaiKhach` ;

CREATE TABLE IF NOT EXISTS `mydb`.`LoaiKhach` (
  `idLoaiKhach` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `TenLoaiKhach` VARCHAR(45) NOT NULL
  )
ENGINE = InnoDB;

DROP TABLE IF EXISTS `mydb`.`KhachHang` ;

CREATE TABLE IF NOT EXISTS `mydb`.`KhachHang` (
  `idKhachHang` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `HoTen` VARCHAR(45) NOT NULL,
  `NgaySinh` DATE NOT NULL,
  `SoCMND` VARCHAR(45) NOT NULL,
  `SDT` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `DiaChi` VARCHAR(45) NOT NULL,
  `LoaiKhach_idLoaiKhach` INT NOT NULL,
  constraint PK_KhachHang_LoaiKhachHang foreign key(`LoaiKhach_idLoaiKhach`) references ViTri(`idLoaiKhach`)
  )
ENGINE = InnoDB;

CREATE INDEX `fk_KhachHang_LoaiKhach1_idx` ON `mydb`.`KhachHang` (`LoaiKhach_idLoaiKhach` ASC) VISIBLE;

DROP TABLE IF EXISTS `mydb`.`LoaiDichVu` ;

CREATE TABLE IF NOT EXISTS `mydb`.`LoaiDichVu` (
  `idLoaiDichVu` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `TenLoaiDichVu` VARCHAR(45) NOT NULL
  )
ENGINE = InnoDB;

DROP TABLE IF EXISTS `mydb`.`KieuThue` ;

CREATE TABLE IF NOT EXISTS `mydb`.`KieuThue` (
  `idKieuThue` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `TenKieuThue` VARCHAR(45) NOT NULL,
  `Gia` INT NOT NULL
  )
ENGINE = InnoDB;

DROP TABLE IF EXISTS `mydb`.`DichVu` ;

CREATE TABLE IF NOT EXISTS `mydb`.`DichVu` (
  `idDichVu` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `TenDichVu` VARCHAR(45) NOT NULL,
  `DienTich` INT NOT NULL,
  `SoTang` INT NOT NULL,
  `SoNguoiToiDa` INT NOT NULL,
  `ChiPhiThue` VARCHAR(45) NOT NULL,
  `TrangThai` VARCHAR(45) NOT NULL,
  `LoaiDichVu_idLoaiDichVu` INT NOT NULL,
  `KieuThue_idKieuThue` INT NOT NULL,
  constraint PK_DichVu_LoaiDichVu foreign key(`LoaiDichVu_idLoaiDichVu`) references ViTri(`idLoaiDichVu`),
  constraint PK_DichVu_KieuThue foreign key(`KieuThue_idKieuThue`) references ViTri(`idKieuThue`)
  )
ENGINE = InnoDB;

CREATE INDEX `fk_DichVu_LoaiDichVu1_idx` ON `mydb`.`DichVu` (`LoaiDichVu_idLoaiDichVu` ASC) VISIBLE;

CREATE INDEX `fk_DichVu_KieuThue1_idx` ON `mydb`.`DichVu` (`KieuThue_idKieuThue` ASC) VISIBLE;

DROP TABLE IF EXISTS `mydb`.`DichVuDiKem` ;

CREATE TABLE IF NOT EXISTS `mydb`.`DichVuDiKem` (
  `idDichVuDiKem` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `TenDichVuDiKem` VARCHAR(45) NOT NULL,
  `Gia` INT NOT NULL,
  `DonVi` VARCHAR(45) NOT NULL,
  `TrangThaiKhaDung` VARCHAR(45) NOT NULL
  )
ENGINE = InnoDB;

DROP TABLE IF EXISTS `mydb`.`HopDong` ;

CREATE TABLE IF NOT EXISTS `mydb`.`HopDong` (
  `idHopDong` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `NgayLamHopDong` DATE NOT NULL,
  `NgayKetThuc` DATE NOT NULL,
  `TienDatCoc` INT NOT NULL,
  `TongTien` INT NULL,
  `NhanVien_idNhanVien` INT NOT NULL,
  `KhachHang_idKhachHang` INT NOT NULL,
  `DichVu_idDichVu` INT NOT NULL,
  constraint PK_HopDong_NhanVien foreign key(`NhanVien_idNhanVien`) references ViTri(`idNhanVien`),
  constraint PK_HopDong_KhachHang foreign key(`KhachHang_idKhachHang`) references ViTri(`idKhachHang`),
  constraint PK_HopDong_DichVu foreign key(`DichVu_idDichVu`) references ViTri(`idDichVu`)
  
  )
ENGINE = InnoDB;

CREATE INDEX `fk_HopDong_NhanVien1_idx` ON `mydb`.`HopDong` (`NhanVien_idNhanVien` ASC) VISIBLE;

CREATE INDEX `fk_HopDong_KhachHang1_idx` ON `mydb`.`HopDong` (`KhachHang_idKhachHang` ASC) VISIBLE;

CREATE INDEX `fk_HopDong_DichVu1_idx` ON `mydb`.`HopDong` (`DichVu_idDichVu` ASC) VISIBLE;

DROP TABLE IF EXISTS `mydb`.`HopDongChiTiet` ;

CREATE TABLE IF NOT EXISTS `mydb`.`HopDongChiTiet` (
  `idHopDongChiTiet` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `SoLuong` INT NOT NULL,
  `DichVuDiKem_idDichVuDiKem` INT NOT NULL,
  `HopDong_idHopDong` INT NOT NULL,
  constraint PK_HopDongChiTiet_DichVuDiKem foreign key(`DichVuDiKem_idDichVuDiKem`) references ViTri(`idDichVuDiKem`),
  constraint PK_HopDongChiTiet_HopDong foreign key(`HopDong_idHopDong`) references ViTri(`idHopDong`)
  )
ENGINE = InnoDB;

CREATE INDEX `fk_HopDongChiTiet_DichVuDiKem1_idx` ON `mydb`.`HopDongChiTiet` (`DichVuDiKem_idDichVuDiKem` ASC) VISIBLE;

CREATE INDEX `fk_HopDongChiTiet_HopDong1_idx` ON `mydb`.`HopDongChiTiet` (`HopDong_idHopDong` ASC) VISIBLE;
