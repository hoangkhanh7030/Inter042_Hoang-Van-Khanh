-- 21.	Tạo khung nhìn có tên là V_NHANVIEN để lấy được thông tin của tất cả các nhân viên có địa chỉ là “Hải Châu” và
 -- đã từng lập hợp đồng cho 1 hoặc nhiều Khách hàng bất kỳ  với ngày lập hợp đồng là “12/12/2019”
 create view V_NHANVIEN as
 select *
 from nhanvien nv
 where nv.idNhanVien = (select hd.NhanVien_idNhanVien
	from hopdong hd
    where nv.DiaChi = 'Hải Châu'
    and year(hd.NgayLamHopDong) = '1999'
 );
 
 select * from V_NHANVIEN;
 

 
-- 22.	Thông qua khung nhìn V_NHANVIEN thực hiện cập nhật địa chỉ thành “Liên Chiểu” đối với tất cả các Nhân viên được nhìn thấy bởi khung nhìn này.
SET SQL_SAFE_UPDATES = 0;

update  V_NHANVIEN
set DiaChi = 'Liên Chiểu'
where DiaChi = 'Hải Châu';

-- 23.	Tạo Clustered Index có tên là IX_KHACHHANG trên bảng Khách hàng.
-- Giải thích lý do và thực hiện kiểm tra tính hiệu quả của việc sử dụng INDEX

create index IX_KhachHang on khachhang (idKhachHang ,HoTen,NgaySinh,SoCMND,SDT,Email,DiaChi  asc) visible;

-- lý do : tìm nhanh hơn


-- 24.	Tạo Non-Clustered Index có tên là IX_SoDT_DiaChi trên các cột SODIENTHOAI và DIACHI trên bảng KHACH HANG và kiểm tra
--  tính hiệu quả tìm kiếm sau khi tạo Index.


-- 25.	Tạo Store procedure Sp_1 Dùng để xóa thông tin của một Khách hàng nào đó với Id Khách hàng được truyền vào như là 1 tham số của Sp_1
DELIMITER //
create procedure Sp_1(
in id int, 
out mes varchar(55)
)
if id in (select id  from khachhang) then
begin
	delete from khachhang
    where idKhachHang = id;
	set mes = 'Đã Xóa Khách Hàng';
end ;
else 
begin
 set mes = 'Khách Hàng Không Tồn Tại'   ;
end ;
end if;

// DELIMITER ;
SET FOREIGN_KEY_CHECKS=0;

call Sp_1(10,@mes);
select @mes;
-- 26.	Tạo Store procedure Sp_2 Dùng để thêm mới vào bảng HopDong với yêu cầu Sp_2 phải thực hiện kiểm tra tính hợp lệ của dữ liệu bổ sung,
-- với nguyên tắc không được trùng khóa chính và đảm bảo toàn vẹn tham chiếu đến các bảng liên quan.

DELIMITER $$
create procedure Sp_2( in ngaylamhopdong date,
in ngayketthuc date,
in tiendatcoc int,
in tongtien int,
in idnv int,
in idkh int,
in iddv int,
out mess text)
if idnv not in (select nv.idNhanVien from nhanvien nv) then
begin
set mess = 'IdNhanVien không tồn tại';
end;
elseif idkh not in(select kh.idKhachHang from khachhang kh) then
begin
set mess = 'IdKhachHang không tồn tại';
end;
elseif iddv not in(select dv.idDichVu from dichvu dv) then
begin
set mess = 'IdDichVu không tồn tại';
end;
else
begin
	insert into hopdong
    value (null,ngaylamhopdong,ngayketthuc,tiendatcoc,tongtien,idnhanvien,idkhachhang,iddichvu);
    set mess='Đã thêm thành công';
end ;
end if;





$$ DELIMITER ;

call Sp_2('2020-06-17','2020-07-17',6000,10000,3,2,2,@mess);
select @mess;

-- 27.	Tạo triggers có tên Tr_1 Xóa bản ghi trong bảng HopDong thì hiển thị tổng số lượng bản ghi còn lại có trong bảng HopDong ra 
-- giao diện console của database


-- 28.	Tạo triggers có tên Tr_2 Khi cập nhật Ngày kết thúc hợp đồng, cần kiểm tra xem thời gian cập nhật có phù hợp hay không, 
-- với quy tắc sau: Ngày kết thúc hợp đồng phải lớn hơn ngày làm hợp đồng ít nhất là 2 ngày. 
-- Nếu dữ liệu hợp lệ thì cho phép cập nhật, nếu dữ liệu không hợp lệ thì in ra thông báo “Ngày kết thúc hợp đồng phải lớn hơn ngày làm hợp đồng ít nhất là 2 ngày” trên console của database
-- 29.	Tạo user function thực hiện yêu cầu sau:
-- a.	Tạo user function func_1: Đếm các dịch vụ đã được sử dụng với Tổng tiền là > 2.000.000 VNĐ.
-- b.	Tạo user function Func_2: Tính khoảng thời gian dài nhất tính từ lúc bắt đầu làm hợp đồng đến lúc kết thúc hợp đồng mà 
-- Khách hàng đã thực hiện thuê dịch vụ (lưu ý chỉ xét các khoảng thời gian dựa vào từng lần làm hợp đồng thuê dịch vụ, không xét trên toàn bộ các lần làm hợp đồng). Mã của Khách hàng được truyền vào như là 1 tham số của function này.
-- 30.	Tạo Stored procedure Sp_3 để tìm các dịch vụ được thuê bởi khách hàng với loại dịch vụ là “Room” từ đầu 
-- năm 2015 đến hết năm 2019 để xóa thông tin của các dịch vụ đó (tức là xóa các bảng ghi trong bảng DichVu) và xóa những HopDong sử 
-- dụng dịch vụ liên quan (tức là phải xóa những bản gi trong bảng HopDong) và những bản liên quan khác.
