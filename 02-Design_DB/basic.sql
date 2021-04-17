-- 1.	Thêm mới thông tin cho tất cả các bảng có trong CSDL để có thể thõa mãn các yêu cầu bên dưới.
    
-- 2.	Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 ký tự.


select * from nhanvien
where  length(HoTen) < 5 and left(HoTen,1) in ('T' , 'K' , 'H')  ;

-- 3.	Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 23 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.

select * from khachhang
where year(curdate())-year(NgaySinh) BETWEEN 23 AND 50 and DiaChi = 'Đà Nẵng' or DiaChi='Quảng Trị';

-- 4.	Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng. 
-- Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.

SELECT count(*) as SoLanDat,hd.KhachHang_idKhachHang ,lk.TenLoaiKhach
FROM hopdong as hd
INNER JOIN khachhang as kh
ON hd.KhachHang_idKhachHang=kh.idKhachHang
inner join loaikhach lk
on kh.LoaiKhach_idLoaiKhach = lk.idLoaiKhach
where lk.TenLoaiKhach='Diamond'
group by idKhachHang
order by count(*) asc;

-- 5.	Hiển thị IDKhachHang, HoTen, TenLoaiKhach, IDHopDong, TenDichVu, NgayLamHopDong, NgayKetThuc, TongTien (Với TongTien được tính theo công thức như sau: ChiPhiThue + SoLuong*Gia, với SoLuong và Giá là từ bảng DichVuDiKem) 
-- cho tất cả các Khách hàng đã từng đặt phỏng. (Những Khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).
with hd_cte as (
select kh.idKhachHang ,
kh.HoTen,
lk.TenLoaiKhach,
hd.idHopDong,
dv.TenDichVu,
hd.NgayLamHopDong,
hd.NgayKetThuc,
(dv.ChiPhiThue + dvdk.DonVi * dvdk.Gia) as TongTien
FROM hopdong as hd
INNER JOIN khachhang as kh
on hd.KhachHang_idKhachHang=kh.idKhachHang
inner join loaikhach as lk
on kh.LoaiKhach_idLoaiKhach=lk.idLoaiKhach
inner join dichvu as dv
on hd.DichVu_idDichVu=dv.idDichVu
inner join dichvudikem as dvdk
on dv.LoaiDichVu_idLoaiDichVu=dvdk.idDichVuDiKem 
group by kh.idKhachHang
)
select kh.idKhachHang,kh.HoTen,cte.TongTien
from hd_cte cte
right join khachhang kh
on cte.idKhachHang = kh.idKhachHang;

-- 6.	Hiển thị IDDichVu, TenDichVu, DienTich, ChiPhiThue, TenLoaiDichVu của tất cả các loại Dịch vụ chưa từng được Khách hàng thực hiện đặt từ 
-- quý 1 của năm 2019 (Quý 1 là tháng 1, 2, 3).


with dichvu_cte as(
select distinct ldv.idLoaiDichVu ,
dv.idDichVu,
dv.TenDichVu,
dv.DienTich,dv.ChiPhiThue
FROM dichvu as dv
INNER JOIN loaidichvu as ldv
on dv.LoaiDichVu_idLoaiDichVu=ldv.idLoaiDichVu
inner join hopdong as hd
on hd.DichVu_idDichVu=dv.idDichVu
where year(hd.NgayLamHopDong) between '1998-01-01' and '1998-03-31'
)
select ldv.idLoaiDichVu ,
ldv.TenLoaiDichVu,cte.idDichVu,
cte.TenDichVu,cte.DienTich,
cte.ChiPhiThue
from dichvu_cte cte
right join loaidichvu ldv
on ldv.idLoaiDichVu = cte.idLoaiDichVu
where cte.idLoaiDichVu is null or ldv.idLoaiDichVu is null;


-- 7.	Hiển thị thông tin IDDichVu, TenDichVu, DienTich, SoNguoiToiDa, ChiPhiThue, 
-- TenLoaiDichVu của tất cả các loại dịch vụ đã từng được Khách hàng đặt phòng trong năm 2018 nhưng chưa từng được Khách hàng đặt phòng  trong năm 2019.

with datphong_cte as (
select dv.idDichVu,
dv.TenDichVu,
dv.DienTich,
dv.SoNguoiToiDa,
dv.ChiPhiThue,
ldv.TenLoaiDichVu,
hd.NgayLamHopDong,
ldv.idLoaiDichVu
FROM dichvu as dv
INNER JOIN loaidichvu as ldv
on dv.LoaiDichVu_idLoaiDichVu = ldv.idLoaiDichVu
inner join hopdong as hd
on hd.DichVu_idDichVu = dv.idDichVu
where year(hd.NgayLamHopDong)=1998 and year(hd.NgayLamHopDong)<1999
)
select *
from datphong_cte cte
right join loaidichvu ldv
on cte.idLoaiDichVu = ldv.idLoaiDichVu 
where ldv.idLoaiDichVu is null or cte.idLoaiDichVu is null;

-- 8.	Hiển thị thông tin HoTenKhachHang có trong hệ thống, với yêu cầu HoThenKhachHang không trùng nhau.
-- Học viên sử dụng theo 3 cách khác nhau để thực hiện yêu cầu trên

-- C2: 
select HoTen from khachhang
group by HoTen
having count(*)<2;

-- 9.	Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng trong năm 2019 thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng.

select month(hd.NgayLamHopDong) as thang, 
sum(TongTien),
extract(year from hd.NgayLamHopDong) as NamTinhTong
from hopdong hd
where year(hd.NgayLamHopDong) = 1998
group by month(hd.NgayLamHopDong);

-- 10.	Hiển thị thông tin tương ứng với từng Hợp đồng thì đã sử dụng bao nhiêu Dịch vụ đi kèm. Kết quả hiển thị bao gồm IDHopDong, NgayLamHopDong, 
-- NgayKetthuc, TienDatCoc, SoLuongDichVuDiKem (được tính dựa trên việc count các IDHopDongChiTiet).

select  count(hd.idHopDong) as SoLuongDichVuDiKem,
hd.idHopDong,
group_concat(concat(dvdk.TenDichVuDiKem,' : ',dvdk.DonVi)separator ' , ') CacDichVuDiKem,
hd.NgayLamHopDong,
hd.NgayKetThuc,
hd.TienDatCoc
from dichvudikem dvdk
inner join hopdongchitiet hdct
on dvdk.idDichVuDiKem = hdct.DichVuDiKem_idDichVuDiKem
inner join hopdong hd
on hdct.HopDong_idHopDong = hd.idHopDong
group by hd.idHopDong
;
-- 11.	Hiển thị thông tin các Dịch vụ đi kèm đã được sử dụng bởi những Khách hàng có TenLoaiKhachHang là “Diamond” và 
-- có địa chỉ là “Vinh” hoặc “Quảng Ngãi”.

select kh.idKhachHang,
kh.HoTen,group_concat(dvdk.TenDichVuDiKem separator ' , ') DichVuDiKem,
sum(dvdk.Gia) as 'Giá :$',
dvdk.DonVi,lk.TenLoaiKhach
from dichvudikem dvdk
inner join hopdongchitiet hdct
	on dvdk.idDichVuDiKem = hdct.DichVuDiKem_idDichVuDiKem
inner join hopdong hd
	on hdct.HopDong_idHopDong = hd.idHopDong
inner join khachhang kh
	on hd.KhachHang_idKhachHang = kh.idKhachHang
inner join loaikhach lk
	on kh.LoaiKhach_idLoaiKhach = lk.idLoaiKhach
where lk.TenLoaiKhach='Diamond' and kh.DiaChi in ('Vinh' ,'Quãng Ngãi')
group by kh.idKhachHang;

-- 12.	Hiển thị thông tin IDHopDong, TenNhanVien, TenKhachHang, SoDienThoaiKhachHang, TenDichVu, SoLuongDichVuDikem (được tính dựa trên tổng Hợp đồng chi tiết),
 -- TienDatCoc của tất cả các dịch vụ đã từng được khách hàng đặt vào 3 tháng cuối năm 2019 nhưng chưa từng được khách hàng đặt vào 6 tháng đầu năm 2019.
with dv_cte as(
select * 
from hopdong hd
join khachhang kh
	on kh.idKhachHang = hd.KhachHang_idKhachHang
join dichvu dv
	on dv.idDichVu = hd.DichVu_idDichVu
join hopdongchitiet hdct
	on hdct.HopDong_idHopDong = hd.idHopDong
join dichvudikem dvdk
	on dvdk.idDichVuDiKem = hdct.DichVuDiKem_idDichVuDiKem
where hd.NgayLamHopDong between '1998-09-01' and '1998-12-31'
)
select hd.idHopDong,
kh.HoTen,dv.TenDichVu,
hd.NgayLamHopDong,
group_concat(concat(dvdk.TenDichVuDiKem ,' : ',dvdk.DonVi) separator ',') as 'DichVuDiKem : SoLuong'
from hopdong hd
join khachhang kh
	on kh.idKhachHang = hd.KhachHang_idKhachHang
join dichvu dv
	on dv.idDichVu = hd.DichVu_idDichVu
join hopdongchitiet hdct
	on hdct.HopDong_idHopDong = hd.idHopDong
join dichvudikem dvdk
	on dvdk.idDichVuDiKem = hdct.DichVuDiKem_idDichVuDiKem
left join dv_cte cte
	on cte.HopDong_idHopDong = hd.idHopDong
where dv.idDichVu is null or cte.idDichVu is null and hd.NgayLamHopDong between '1998-01-01' and '1998-5-31'
group by idHopDong;


-- 13.	Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng.
 -- (Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau).
 select dvdk.idDichVuDiKem,dvdk.TenDichVuDiKem,count(dvdk.idDichVuDiKem) as SoLanSuDung
 from hopdong hd
 join hopdongchitiet hdct
 on hd.idHopDong = hdct.HopDong_idHopDong
 join dichvudikem dvdk
 on dvdk.idDichVuDiKem = hdct.DichVuDiKem_idDichVuDiKem
 group by idDichVuDiKem;
 
 
 
 -- 14.	Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất. 
-- Thông tin hiển thị bao gồm IDHopDong, TenLoaiDichVu, TenDichVuDiKem, SoLanSuDung.

	select hd.idHopDong,
	dvdk.TenDichVuDiKem,
	ldv.TenLoaiDichVu,
	count(hdct.DichVuDiKem_idDichVuDiKem) as SoLanSuDung
	from hopdong hd
	join hopdongchitiet hdct
	on hd.idHopDong = hdct.HopDong_idHopDong
	join dichvudikem dvdk
	on dvdk.idDichVuDiKem = hdct.DichVuDiKem_idDichVuDiKem
	join dichvu dv
	on dv.idDichVu = hd.DichVu_idDichVu
	join loaidichvu ldv
	on ldv.idLoaiDichVu = dv.LoaiDichVu_idLoaiDichVu
	group by hdct.DichVuDiKem_idDichVuDiKem
	having count(*)<2;


-- 15.	Hiển thi thông tin của tất cả nhân viên bao gồm IDNhanVien, HoTen, TrinhDo, TenBoPhan, SoDienThoai, 
-- DiaChi mới chỉ lập được tối đa 3 hợp đồng từ năm 2018 đến 2019.
select nv.idNhanVien,
nv.HoTen,
td.TrinhDo,
bp.TenBoPhan,
nv.SDT,
nv.Email,
count(hd.NhanVien_idNhanVien) as SoHopDongDaLap 
from nhanvien nv
join hopdong hd
on hd.NhanVien_idNhanVien = nv.idNhanVien
join trinhdo td
on nv.TrinhDo_idTrinhDo = td.idTrinhDo
join bophan bp
on nv.BoPhan_idBoPhan = bp.idBoPhan
where year(hd.NgayLamHopDong) between 1998 and 2019
group by hd.NhanVien_idNhanVien
having count(*)=3
;

-- 16.	Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 1998 đến năm 1999.

SET SQL_SAFE_UPDATES = 0;

delete
from nhanvien 
where idNhanVien not in 
(
select id from 
(select idNhanVien id
from hopdong
join nhanvien
on idNhanVien = NhanVien_idNhanVien
where  year(NgayLamHopDong) between 1998 and 1999)  tb2
);

SET SQL_SAFE_UPDATES = 1;

-- 17.	Cập nhật thông tin những khách hàng có TenLoaiKhachHang từ  Platinium lên Diamond, chỉ cập nhật những khách hàng 
-- đã từng đặt phòng với tổng Tiền thanh toán trong năm 2019 là lớn hơn 10.000.000 VNĐ.


SET SQL_SAFE_UPDATES = 0;

update khachhang kh
join hopdong hd
on hd.KhachHang_idKhachHang = kh.idKhachHang
join loaikhach lk
on lk.idLoaiKhach = kh.LoaiKhach_idLoaiKhach
set kh.LoaiKhach_idLoaiKhach = 1
where lk.TenLoaiKhach = 'Platinium' 
and year(hd.NgayLamHopDong) = 2019 and hd.TongTien >7000;

SET SQL_SAFE_UPDATES = 1;


-- 18.	Xóa những khách hàng có hợp đồng trước năm 2016 (chú ý ràngbuộc giữa các bảng).


SET FOREIGN_KEY_CHECKS=0;

delete
from khachhang 
where idKhachHang in 
(
select id from 
(select idKhachHang id
from hopdong
join khachhang
on idKhachHang = KhachHang_idKhachHang
where  year(NgayLamHopDong) < 1999)  tb2
);

SET FOREIGN_KEY_CHECKS=1;

-- 19.	Cập nhật giá cho các Dịch vụ đi kèm được sử dụng trên 10 lần trong năm 2019 lên gấp đôi.


SET SQL_SAFE_UPDATES = 0;

update dichvudikem dvdk
join hopdongchitiet hdct
on  dvdk.idDichVuDiKem = hdct.DichVuDiKem_idDichVuDiKem
join hopdong hd
on hd.idHopDong = hdct.HopDong_idHopDong 
set dvdk.Gia = dvdk.Gia *10
where dvdk.idDichVuDiKem in (
	select id from

(

select dvdk.idDichVuDiKem id
from dichvudikem dvdk
join hopdongchitiet hdct
on  dvdk.idDichVuDiKem = hdct.DichVuDiKem_idDichVuDiKem
join hopdong hd
on hd.idHopDong = hdct.HopDong_idHopDong 
group by dvdk.idDichVuDiKem
having count(dvdk.idDichVuDiKem) >=2) dv
)

;
SET SQL_SAFE_UPDATES = 1;


-- 20.	Hiển thị thông tin của tất cả các Nhân viên và Khách hàng có trong hệ thống, 
-- thông tin hiển thị bao gồm ID (IDNhanVien, IDKhachHang), HoTen, Email, SoDienThoai, NgaySinh, DiaChi.
select idNhanVien,HoTen,Email,SDT,NgaySinh,DiaChi
from nhanvien








	




