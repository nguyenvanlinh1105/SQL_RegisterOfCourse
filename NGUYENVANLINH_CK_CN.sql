CREATE DATABASE BTCANHANNVL
GO
USE BTCANHANNVL

CREATE TABLE Khoa (
    maKhoa CHAR(10) PRIMARY KEY,
    tenKhoa NVARCHAR(50)
);

CREATE TABLE LopSH (
    maLSH CHAR(10) PRIMARY KEY,
    maKhoa CHAR(10),
    tenLSH NVARCHAR(50),
    namBD INT,
    FOREIGN KEY (maKhoa) REFERENCES Khoa (maKhoa)
);

CREATE TABLE SinhVien (
    maSV CHAR(15) PRIMARY KEY,
    maLSH CHAR(10),
    tenSV NVARCHAR(100),
    gioiTinh NVARCHAR(3),
    ngaySinh DATETIME,
    diaChi NVARCHAR(255),
    email VARCHAR(100) UNIQUE,
    SDT CHAR(10),
    matkhau VARCHAR(255),
    FOREIGN KEY (maLSH) REFERENCES LopSH(maLSH)
);

CREATE TABLE GiaoVien (
    maGV CHAR(15) PRIMARY KEY,
    tenGV NVARCHAR(255),
    gioiTinh NVARCHAR(3),
    SDT CHAR(10),
    email VARCHAR(255) UNIQUE,
    matkhau VARCHAR(255)
);

CREATE TABLE ThoiGian (
    maThoiGian CHAR(10) PRIMARY KEY,
    Thu NVARCHAR(5),
    tietBD INT,
    tietKT INT
);

CREATE TABLE Phong (
    maPhong CHAR(10) PRIMARY KEY,
    tenPhong NVARCHAR(20)
);

CREATE TABLE ThoiGian_PhongHoc(
    maTG_PH CHAR(15) PRIMARY KEY,
    maPhong CHAR(10),
    maThoiGian CHAR(10),
    FOREIGN KEY (maThoiGian) REFERENCES ThoiGian (maThoiGian),
    FOREIGN KEY (maPhong) REFERENCES Phong(maPhong)
);

CREATE TABLE HocPhan (
    maHP CHAR(20) PRIMARY KEY,
    tenHP NVARCHAR(255),
    soTC INT
);

CREATE TABLE ChuongTrinhDaoTao (
    maChuongTrinhDaoTao CHAR(20) PRIMARY KEY,
    tenChuongTrinhDaoTao NVARCHAR(255)
);

CREATE TABLE ChuongTrinhDaoTao_HocPhan (
    maChuongTrinhDaoTao CHAR(20),
    maHP CHAR(20),
    PRIMARY KEY (maChuongTrinhDaoTao, maHP),
    FOREIGN KEY (maChuongTrinhDaoTao) REFERENCES ChuongTrinhDaoTao (maChuongTrinhDaoTao),
    FOREIGN KEY (maHP) REFERENCES HocPhan (maHP)
);

CREATE TABLE LopHocPhan (
    maLHP CHAR(15) PRIMARY KEY,
    maHP CHAR(20),
    maGV CHAR(15),
    soLuongDK INT,
    soLuongDDK INT,
    maTG_PH CHAR(15),
	maHocKi CHAR(5),
    ghiChu NVARCHAR(255),
    FOREIGN KEY (maHP) REFERENCES HocPhan (maHP),
    FOREIGN KEY (maGV) REFERENCES GiaoVien (maGV),
    FOREIGN KEY (maTG_PH) REFERENCES ThoiGian_PhongHoc(maTG_PH)
);

CREATE TABLE DangKiTinChi (
    maDK CHAR(15) PRIMARY KEY,
    maSV CHAR(15),
    thoiGianDK TIME,
    FOREIGN KEY (maSV) REFERENCES SinhVien (maSV)
);

CREATE TABLE DangKiChiTiet (
    maDKCT CHAR(10) PRIMARY KEY,
    maLHP CHAR(15),
    maDK CHAR(15),
    FOREIGN KEY (maLHP) REFERENCES LopHocPhan (maLHP),
    FOREIGN KEY (maDK) REFERENCES DangKiTinChi (maDK)
);
-- ALTER TABLE
ALTER TABLE SinhVien
	ADD CONSTRAINT CK_SinhVien_ngaySinh
	    CHECK(DATEDIFF(year, '0:0', getDate()- ngaySinh)>=18);

ALTER TABLE SinhVien 
	ALTER COLUMN gioiTinh char(1);

ALTER TABLE GiaoVien 
    ALTER column gioiTinh char(1);

ALTER TABLE SinhVien 
ADD CONSTRAINT CK_SinhVien_GT 
            CHECK(gioiTinh Like 'F' OR gioiTinh like 'M'),
	CONSTRAINT DF_SinhVien_GT Default 'F' for gioiTinh;

ALTER TABLE GiaoVien 
ADD CONSTRAINT CK_GiaoVien_GT
            CHECK(gioiTinh Like 'F' OR gioiTinh like 'M'),
	CONSTRAINT DF_GiaoVien_GT Default 'F' for gioiTinh;

ALTER TABLE SinhVien ADD CONSTRAINT CK_SinhVien_SDT
    CHECK(SDT Like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]');

ALTER TABLE SinhVien ADD CONSTRAINT CK_SinhVien_SDT
   CHECK(SDT Like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]');

ALTER TABLE GiaoVien ADD CONSTRAINT CK_GiaoVien_SDT 
	CHECK(SDT Like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]');

ALTER TABLE SinhVien 
	    ADD CONSTRAINT CK_SinhVien_email
            CHECK(email Like '[a-z]%@gmail.com');

ALTER TABLE GiaoVien 
    ADD CONSTRAINT CK_GiaoVien_email
        CHECK(email Like '[a-z]%@gmail.com');

ALTER TABLE GiaoVien 
	 ALTER column matKhau varchar(255) NOT NULL;

ALTER TABLE SinhVien 
    ALTER column matKhau varchar(255) NOT NULL;

ALTER TABLE HocPhan 
	ADD CONSTRAINT CK_HocPhan_SoTC
		CHECK(SoTC>0);

ALTER TABLE LopHocPhan 
	ADD CONSTRAINT CK_LopHocPhan_SoLDK
		CHECK(soLuongDK>0);

ALTER TABLE LopHocPhan 
	ADD CONSTRAINT CK_LopHocPhan_SoLDDK
		CHECK(soLuongDDK>0);

ALTER TABLE LopHocPhan 
	ADD CONSTRAINT CK_LopHocPhan_SoLDDK_soLDK
		CHECK(soLuongDDK<soLuongDK);

ALTER TABLE ThoiGian 
	ADD CONSTRAINT CK_TGLHP_tietBD
		CHECK(tietBD>0 and tietBD<15);

ALTER TABLE ThoiGian 
	ADD CONSTRAINT CK_TGLHP_tietKT
		CHECK(tietKT>0 and tietBD<15);

ALTER TABLE ThoiGian 
    ADD CONSTRAINT CK_TGLHP_tietKT_tietBD
		    CHECK(tietKT>=tietBD);

ALTER TABLE LopSH
    ADD CONSTRAINT CK_LopSH_namBD
		    CHECK(namBD<getDate());

-- INSERT DỮ LIỆU 

-- Insert data into Khoa
INSERT INTO Khoa (maKhoa, tenKhoa)
VALUES
    ('KHOA001', N'Khoa Học Máy Tính'),
    ('KHOA002', N'Khoa Kinh Tế'),
    ('KHOA003', N'Khoa Sư Phạm'),
    ('KHOA004', N'Khoa Y Học'),
    ('KHOA005', N'Khoa Khoa Học Xã Hội');

-- Insert data into LopSH
INSERT INTO LopSH (maLSH, maKhoa, tenLSH, namBD)
VALUES
    ('LSH001', 'KHOA001', N'Lớp SH1', 2023),
    ('LSH002', 'KHOA001', N'Lớp SH2', 2023),
    ('LSH003', 'KHOA002', N'Lớp SH1', 2023),
    ('LSH004', 'KHOA002', N'Lớp SH2', 2023),
    ('LSH005', 'KHOA003', N'Lớp SH1', 2023);

-- Insert data into SinhVien
INSERT INTO SinhVien (maSV, maLSH, tenSV, gioiTinh, ngaySinh, diaChi, email, SDT, matkhau)
VALUES
    ('SV001', 'LSH001', N'Nguyễn Thị X', 'M', '2000-01-01', N'123 Đường ABC', 'nguyen.thi.x@gmail.com', '0123456789', 'matkhau1'),
    ('SV002', 'LSH002', N'Trần Văn Y', 'F', '2001-02-02', N'456 Đường XYZ', 'tran.van.y@gmail.com', '0987654321', 'matkhau2'),
    ('SV003', 'LSH003', N'Hồ Thị Z', 'F', '2002-03-03', N'789 Đường DEF', 'ho.thi.z@gmail.com', '0369258741', 'matkhau3'),
    ('SV004', 'LSH004', N'Lê Văn W', 'M', '2003-04-04', N'987 Đường LMN', 'le.van.w@gmail.com', '0897456321', 'matkhau4'),
    ('SV005', 'LSH005', N'Phạm Thị U', 'M', '2004-05-05', N'741 Đường UVW', 'pham.thi.u@gmail.com', '0321456987', 'matkhau5');

-- Insert data into GiaoVien
INSERT INTO GiaoVien (maGV, tenGV, gioiTinh, SDT, email, matkhau)
VALUES
    ('GV001', N'Nguyễn Văn A', 'F', '0123456789', 'nguyen.va@gmail.com', 'matkhau1'),
    ('GV002', N'Trần Thị B', 'F', '0987654321', 'tran.thi.b@gmail.com', 'matkhau2'),
    ('GV003', N'Hồ Minh C', 'M', '0369258741', 'ho.minh.c@gmail.com', 'matkhau3'),
    ('GV004', N'Lê Thị D', 'M', '0897456321', 'le.thi.d@gmail.com', 'matkhau4'),
    ('GV005', N'Phạm Văn E', 'F', '0321456987', 'pham.van.e@gmail.com', 'matkhau5'),
	('GV006', N'Nguyễn Văn Hải', 'M', '0123416759', 'nguyenr.va@gmail.com', 'matkhau6'),
    ('GV007', N'Nguyễn Thủy Tiên', 'F', '0122416759', 'levan.va@gmail.com', 'matkhau7');

-- Insert data into ThoiGian
INSERT INTO ThoiGian (maThoiGian, Thu, tietBD, tietKT)
VALUES
    ('TG001', N'Thứ 2', 1, 3),
	('TG0011', N'Thứ 2', 3, 5),
    ('TG002', N'Thứ 3', 2, 4),
	('TG008', N'Thứ 3', 4, 6),
    ('TG003', N'Thứ 4', 3, 5),
    ('TG004', N'Thứ 5', 4, 6),
    ('TG005', N'Thứ 6', 5, 7),
	('TG0051', N'Thứ 6', 9, 11);

-- Insert data into Phong
INSERT INTO Phong (maPhong, tenPhong)
VALUES
    ('PH001', N'Phòng 1'),
    ('PH002', N'Phòng 2'),
    ('PH003', N'Phòng 3'),
    ('PH004', N'Phòng 4'),
    ('PH005', N'Phòng 5');

-- Insert data into ThoiGian_PhongHoc
INSERT INTO ThoiGian_PhongHoc (maTG_PH, maPhong, maThoiGian)
VALUES
    ('TG_PH001', 'PH001', 'TG001'),
	('TG_PH0011', 'PH001', 'TG0011'),
	('TG_PH0012', 'PH001', 'TG003'),
	('TG_PH0013', 'PH001', 'TG005'),
    ('TG_PH0021', 'PH002', 'TG002'),
	('TG_PH002', 'PH002', 'TG004'),
    ('TG_PH003', 'PH003', 'TG003'),
    ('TG_PH004', 'PH004', 'TG004'),
    ('TG_PH005', 'PH005', 'TG005');

-- Insert data into HocPhan
INSERT INTO HocPhan (maHP, tenHP, soTC)
VALUES
    ('HP001', N'Học Phần 1', 3),
    ('HP002', N'Học Phần 2', 4),
    ('HP003', N'Học Phần 3', 3),
    ('HP004', N'Học Phần 4', 4),
    ('HP005', N'Học Phần 5', 2),
	('HP00CNTT', N'Học Phần Tin Học Cơ bản', 2),
    ('HP008', N'Học Phần Toán rời rạc', 3),
	('HP00GT', N'Học Phần Giải tích', 3);	
	
-- Insert data into ChuongTrinhDaoTao
INSERT INTO ChuongTrinhDaoTao (maChuongTrinhDaoTao, tenChuongTrinhDaoTao)
VALUES
    ('CTDT001', N'Chương Trình Đào Tạo 1'),
    ('CTDT002', N'Chương Trình Đào Tạo 2'),
    ('CTDT003', N'Chương Trình Đào Tạo 3'),
    ('CTDT004', N'Chương Trình Đào Tạo 4'),
    ('CTDT005', N'Chương Trình Đào Tạo 5');
	
-- Insert data into ChuongTrinhDaoTao_HocPhan
INSERT INTO ChuongTrinhDaoTao_HocPhan (maChuongTrinhDaoTao, maHP)
VALUES
    ('CTDT001', 'HP001'),
    ('CTDT001', 'HP002'),
    ('CTDT002', 'HP003'),
    ('CTDT002', 'HP004'),
    ('CTDT003', 'HP005'),
	('CTDT001', 'HP00CNTT'),
    ('CTDT001', 'HP008');

-- Insert data into LopHocPhan
INSERT INTO LopHocPhan (maLHP, maHP, maGV, soLuongDK, soLuongDDK, maTG_PH, maHocKi)
VALUES
    ('LHP001', 'HP001', 'GV001', 50, 45, 'TG_PH001', 'HK001'),
    ('LHP002', 'HP002', 'GV002', 60, 55, 'TG_PH002', 'HK001'),
    ('LHP003', 'HP003', 'GV003', 40, 35, 'TG_PH003', 'HK001'),
    ('LHP004', 'HP004', 'GV004', 70, 65, 'TG_PH004', 'HK001'),
    ('LHP005', 'HP005', 'GV005', 30, 25, 'TG_PH005', 'HK001');

-- Insert data into DangKiTinChi
INSERT INTO DangKiTinChi (maDK, maSV, thoiGianDK)
VALUES
    ('DK001', 'SV001', '08:00:00'),
    ('DK002', 'SV002', '09:15:00'),
    ('DK003', 'SV003', '10:30:00'),
    ('DK004', 'SV004', '11:45:00'),
    ('DK005', 'SV005', '13:00:00');

-- Insert data into DangKiChiTiet
INSERT INTO DangKiChiTiet (maDKCT, maLHP, maDK)
VALUES
    ('DKCT001', 'LHP001', 'DK001'),
    ('DKCT002', 'LHP002', 'DK002'),
    ('DKCT003', 'LHP003', 'DK003'),
    ('DKCT004', 'LHP004', 'DK004'),
    ('DKCT005', 'LHP005', 'DK005');


-- UPDATE
--Cập nhật tên khoa có mã’KHOA001’ thành tên ‘Khoa Công Nghệ Thông Tin’
 	UPDATE Khoa
    SET tenKhoa = N'Khoa Công Nghệ Thông Tin'
   WHERE maKhoa = 'KHOA001';
--	Cập nhật tên lớp học có mã ‘LSH001’ thành tên ‘Lớp SH 22T2’
UPDATE LopSH
SET tenLSH = N'Lớp SH 22T2'
WHERE maLSH = 'LSH001';
--	Cập nhật số lượng đăng kí mới cho lớp học phần có mã ‘LHP001’
UPDATE LopHocPhan
SET soLuongDDK = 48
WHERE maLHP = 'LHP001';
--Cập nhật thời gian đăng kí của sinh viên có mã ‘SV004’ thành thời gian’14:15:00’
  UPDATE DangKiTinChi
SET thoiGianDK = '14:15:00'
WHERE maSV = 'SV004';


--	Cập nhật số lượng đăng kí mới soLuongDDK=soLuongDDK-10 cho tất cả lớp học phần (LopHocPhan’) 
UPDATE LopHocPhan
SET soLuongDDK = soLuongDK - 10
WHERE maHP IN (SELECT maHP FROM HocPhan );
    
--	 Cập nhật học phần có số tín chỉ =4  thành số tín chỉ = 3 nếu lớp đó có mã HP là  ‘HP001’
UPDATE HocPhan
       SET soTC = 1 WHERE maHP ='HP001'
--	Cập nhật giới tính của giáo Viên có giới tính là ‘M’ đổi thành ‘F’ và ngược lại.
UPDATE GiaoVien
SET gioiTinh = CASE
    WHEN gioiTinh = 'M' THEN 'F'
    ELSE 'M'
END;
--i.	Cập nhật lại tên lớp sinh hoạt của những lớp có mã lớp sinh hoạt ‘LSH003’, ‘LSH004’, ‘LSH005’ lần lượt đổi lại thành ‘Lớp SH3’,’Lớp SH4’,’Lớp SH5’
--	Cập nhật lại tên của lớp có mã ‘LSH003’ 
UPDATE LopSH
SET tenLSH=N'Lớp SH3'
WHERE maLSH='LSH003';
--	Cập nhật lại tên của lớp có mã ‘LSH04’ 
 UPDATE LopSH
SET tenLSH=N'Lớp SH4'
WHERE maLSH='LSH004';
--	Cập nhật lại tên của lớp có mã ‘LSH05’ 
 UPDATE LopSH
SET tenLSH=N'Lớp SH5'
WHERE maLSH='LSH005';
-- Cập nhật lại mã học kì của LopHocPhan ='123' cho tất cả các lớp 
UPDATE LopHocPhan
SET maHocki ='123'
-- Cập nhật lại mã học kì của LopHocPhan ='223 cho những lớp có maHP ='HP005'
UPDATE LopHocPhan
SET maHocki ='223'
WHERE maHP='HP005'
select * from LopHocPhan
-- DELETE 
--a.	Xóa những SinhVien đã bắt đầu học từ 8 năm về trước 
DELETE FROM SinhVien
WHERE maLSH IN (SELECT maLSH FROM LopSH WHERE namBD + 8 < YEAR(GETDATE()));

--b.	Xóa những lớp học phần có số lượng sinh Viên đăng kí <= 0.5 sô lượng đăng kí tối đa và soLuongDDK = 0;
DELETE LopHocPhan
WHERE  soLuongDDK<=0.5*soLuongDK and soLuongDDK=0;
--c.	Xóa những lớp học phần không có maHP thuộc mã học phần quy đinh.
DELETE FROM LopHocPhan
WHERE maHP NOT IN (SELECT maHP FROM HocPhan);
--d.	Xóa tất cả lớp học phần từ bảng LopHocPhan mà không có phòng học tương ứng.
DELETE FROM LopHocPhan
WHERE maTG_PH IS NULL
--e.	Xóa tất cả sinh viên từ bảng sinhVien mà chưa đăng kí lớp học phần nào.
DELETE FROM SinhVien
WHERE maSV NOT IN (SELECT maSV FROM DangKiTinChi);
--f.	Xóa tất cả khoa từ bảng Khoa mà không có sinh viên nào thuộc khoa đó.
DELETE FROM Khoa
WHERE maKhoa NOT IN (SELECT maKhoa FROM LopSH);
--g.	Xóa tất cả những bản ghi của bảng DangKiChiTiet mà có thời gian DK >’16:00:00’
DELETE DangKiChiTiet
WHERE maDK IN(SELECT maDK FROM DangKiTinChi WHERE thoiGianDK>'16:00:00');
--h.	Xóa tất cả lớp học phần từ bảng LopHocPhan mà chưa có sinh viên nào đăng kí.
DELETE FROM LopHocPhan
WHERE maLHP NOT IN (SELECT maLHP FROM DangKiChiTiet);
--i.	Xóa tất cả phòng từ bảng LopHP_Phong mà tên phòng không có tí tự ‘Phòng’
DELETE FROM Phong
WHERE tenPhong NOT LIKE '%Phòng%';

-- SELECT 
--a.	Hiển thị các lớp thuộc khoa ‘Công nghệ thông tin’
SELECT tenLSH, maLSH
   FROM dbo.LopSH AS l, dbo.Khoa AS k
   WHERE l.maKhoa = k.maKhoa AND k.tenKhoa = N'Khoa Công nghệ thông tin';

--b.	Hiển thị mã sinh viên, họ và tên, ngày sinh, năm bắt đầu học  của các sinh viên
  SELECT maSV, TenSV,ngaySinh,namBD
    FROM SinhVien as s, LopSH as l
WHERE s.maLSH= l.maLSH;

--c.	Hiển thị thông tin của sinh viên có mã sinh viên ‘SV001’
   SELECT * FROM dbo.SinhVien
WHERE maSV='SV001' 

--d.	Hiển thị mã sinh viên, tên sinh viên, maDKCT, Tổng số tín chỉ của sinh viên có tổng số tín chỉ đăng kí nhỏ hơn 10
SELECT
    SV.maSV,
    SV.tenSV,
    SUM(HP.soTC) AS TongSoTinChi
FROM SinhVien SV
JOIN DangKiTinChi DK ON SV.maSV = DK.maSV
JOIN DangKiChiTiet DKCT ON DK.maDK = DKCT.maDK
JOIN LopHocPhan LHP ON DKCT.maLHP = LHP.maLHP
JOIN HocPhan HP ON LHP.maHP = HP.maHP
GROUP BY SV.maSV, SV.tenSV
HAVING SUM(HP.soTC) < 10;
--e.	Hiển thị thông tin của những sinh viên, không tham gia đăng kí tín chỉ trong học kì 123
SELECT
SV.maSV,SV.tenSV,SV.maLSH,SV.ngaySinh,SV.SDT,SV.email,
SV.gioiTinh,SV.diaChi
FROM SinhVien SV
WHERE
    SV.maSV NOT IN (
        SELECT DISTINCT SV.maSV
        FROM SinhVien SV
        JOIN DangKiTinChi DK ON SV.maSV = DK.maSV
        JOIN DangKiChiTiet DKCT ON DK.maDK = DKCT.maDK
        JOIN LopHocPhan LHP ON DKCT.maLHP = LHP.maLHP
        JOIN HocPhan HP ON LHP.maHP = HP.maHP
		WHERE LHP.maHocKi='123'
    );

--f.	Hiển thị thông tin thông tin đăng kí học phần gồm mã sinh viên, tên sinh viên, maHP đăng kí, maLHP đăng kí, tenHP đăng kí của sinh viên có mã sinh viên ‘SV001’
SELECT
    SV.maSV,SV.tenSV,HP.maHP,LHP.maLHP,HP.tenHP,HP.soTC
FROM
    SinhVien SV
JOIN DangKiTinChi DK ON SV.maSV = DK.maSV
JOIN DangKiChiTiet DKCT ON DK.maDK = DKCT.maDK
JOIN LopHocPhan LHP ON DKCT.maLHP = LHP.maLHP
JOIN HocPhan HP ON LHP.maHP = HP.maHP
WHERE SV.maSV = 'SV001'; 

--g.	Hiển thị các Học phần của các chương trình đào tạo tương ứng, bao gồm,maHP,tenHP,soTC,maChuongTrinhDaoTao,tenChuongTrinhDaoTao
SELECT H.maHP, tenHP,soTC,C.maChuongTrinhDaoTao,tenChuongTrinhDaoTao
FROM dbo.HocPhan H 
INNER JOIN dbo.ChuongTrinhDaoTao_HocPhan CH ON CH.maHP=H.maHP
INNER JOIN dbo.ChuongTrinhDaoTao C ON C.maChuongTrinhDaoTao=CH.maChuongTrinhDaoTao;

--h.	Cho biết chương trình đào tạo 1 có những học phần nào.
SELECT maHP,tenHP
FROM dbo.HocPhan
WHERE maHP in (SELECT CH.maHP FROM dbo.ChuongTrinhDaoTao_HocPhan as CH , dbo.ChuongTrinhDaoTao as C
WHERE CH.maChuongTrinhDaoTao= C.maChuongTrinhDaoTao and    C.tenChuongTrinhDaoTao=N'Chương Trình Đào Tạo 1');

--i.	Hiển thị mã sinh viên , tên sinh viên, ngày sinh và địa chỉ cửa những sinh viên thuộc lớp ‘LopSH1’
SELECT maSV,tenSV,diaChi
FROM SinhVien 
WHERE maLSH = (SELECT maLSH FROM dbo.LopSH WHERE tenLSH like N'Lớp SH2');

--j.	Hiển thị những sinh viên đã đăng kí lớp học phần có mã lớp học phần ‘LHP02’
SELECT SV.*
FROM SinhVien SV
JOIN DangKiTinChi DK ON SV.maSV = DK.maSV
JOIN DangKiChiTiet DKCT ON DK.maDK = DKCT.maDK
JOIN LopHocPhan LHP ON DKCT.maLHP = LHP.maLHP
WHERE LHP.maLHP = 'LHP002';

--k.	Hiển thị số lượng sinh viên đã đăng kí lớp học phần của tất cả các lớp học phần, bao gồm maLHP,  maHP, tenHP, soLuongDDK, soLuongĐK, maHocKi
SELECT maLHP,H.maHP,tenHP,soLuongDDK,soLuongDK,maHocKi
FROM dbo.LopHocPhan as L
	INNER JOIN HocPhan as H ON H.maHP=L.maHP
WHERE maHocKi ='123'
select * from LopHocPhan
--l.	Hiển thị thời gian đăng kí của sinh viên có mã sinh viên là ‘SV001’, thông tin hiển thị bao gồm, mã sinh viên, tên sinh viên, email sinh viên, maLHP đăng kí, thời gian đăng kí.
SELECT SV.maSV,SV.tenSV,SV.email,LHP.maLHP,DKTC.thoiGianDK
FROM dbo.SinhVien as SV
INNER JOIN dbo.DangKiTinChi as DKTC ON SV.maSV=DKTC.maSV
INNER JOIN dbo.DangKiChiTiet as DKCT ON DKCT.maDK=DKTC.maDK
INNER JOIN dbo.LopHocPhan as LHP ON DKCT.maLHP=LHP.maLHP
WHERE SV.maSV='SV001'

--m.	Hãy cho biết những giáo viên nào không dạy lớp nào trong học kì 123.
SELECT * 
 FROM GiaoVien
      WHERE maGV NOT IN(SELECT maGV FROM dbo.LopHocPhan WHERE maHocKi='123');

--n.	Hãy hiển thời gian giảng dạy của lớp học phần có mã ‘LHP001’ gồm, maLHP, maThoiGian,Thu,tietBD, tietKT
 SELECT LopHocPhan.maLHP, ThoiGian.maThoiGian, ThoiGian.Thu, ThoiGian.tietBD, ThoiGian.tietKT
FROM LopHocPhan
JOIN ThoiGian_PhongHoc ON LopHocPhan.maTG_PH = ThoiGian_PhongHoc.maTG_PH
JOIN ThoiGian ON ThoiGian_PhongHoc.maThoiGian = ThoiGian.maThoiGian
WHERE LopHocPhan.maLHP = 'LHP001';

--o.	Hãy hiển thị thông tin của phòng học đã có lớp giảng dạy vào thứ 2 tiết 1 – tiết 3, gồm maLHP, maPhong, tenPhong.
SELECT LopHocPhan.maLHP, ThoiGian_PhongHoc.maPhong, Phong.tenPhong
FROM LopHocPhan
JOIN ThoiGian_PhongHoc ON LopHocPhan.maTG_PH = ThoiGian_PhongHoc.maTG_PH
JOIN Phong ON ThoiGian_PhongHoc.maPhong = Phong.maPhong
JOIN ThoiGian ON ThoiGian_PhongHoc.maThoiGian = ThoiGian.maThoiGian
WHERE ThoiGian.Thu = N'Thứ 2' AND ThoiGian.tietBD = 1 AND ThoiGian.tietKT = 3;

--p.-	Hãy hiển thị tổng số tín chỉ đã đăng kí của từng sinh viên gồm maSV, tenSV, lopSH, tongSoTC_DK.
SELECT SV.maSV, SV.tenSV,LSH.tenLSH, SUM(HP.soTC) AS TongSoTC
FROM LopSH as LSH 
JOIN SinhVien SV ON SV.maLSH= LSH.maLSH
JOIN DangKiTinChi DK ON SV.maSV = DK.maSV
JOIN DangKiChiTiet DKCT ON DK.maDK = DKCT.maDK
JOIN LopHocPhan LHP ON DKCT.maLHP = LHP.maLHP
JOIN HocPhan HP ON LHP.maHP = HP.maHP
GROUP BY SV.maSV, SV.tenSV,tenLSH;

--q.	Hãy hiển thị số phòng còn rảnh ở Thứ 3 tiết 1 đến tiết 2
-- Lấy danh sách phòng còn rảnh
SELECT maPhong, tenPhong
FROM Phong
WHERE maPhong NOT IN (
    SELECT DISTINCT ThoiGian_PhongHoc.maPhong
    FROM ThoiGian
    JOIN ThoiGian_PhongHoc ON ThoiGian.maThoiGian = ThoiGian_PhongHoc.maThoiGian
    WHERE ThoiGian.Thu = N'Thứ 3' AND ThoiGian.tietBD BETWEEN 1 AND 2
);

-- Lấy danh sách học phần không có trong chương trình đào tạo
SELECT maHP, tenHP
FROM HocPhan
WHERE maHP NOT IN (
    SELECT maHP
    FROM ChuongTrinhDaoTao_HocPhan
);
-- Lấy danh sách giáo viên đảm nhiệm dạy ít nhất 2 lớp học phần
SELECT GV.maGV, GV.tenGV,GV.email, GV.SDT, COUNT(DISTINCT maLHP) AS SoLuongLopHocPhan
FROM GiaoVien GV
JOIN LopHocPhan LHP ON GV.maGV = LHP.maGV
GROUP BY GV.maGV, GV.tenGV,GV.email, GV.SDT
HAVING COUNT(DISTINCT maLHP) >= 2;
select * from GiaoVien
--Hiển thị thông  clinh của lớp học phần nào học vào thứ 2 tiết 1 đến tiết 3
SELECT LHP.maLHP, LHP.maHP, LHP.maGV, LHP.soLuongDK, LHP.soLuongDDK, LHP.maTG_PH, LHP.maHocKi
FROM LopHocPhan LHP
JOIN ThoiGian_PhongHoc TG_PH ON LHP.maTG_PH = TG_PH.maTG_PH
JOIN ThoiGian TG ON TG_PH.maThoiGian = TG.maThoiGian
WHERE TG.Thu = N'Thứ 2' AND TG.tietBD = 1AND TG.tietKT = 3;
--v.	Hãy in ra thông tin sinh viên gồm mã sinh viên , tên sinh viên, và tổng số môn học mà sinh viên đó đã đăng kí trong học kì 123
SELECT DangKiTinChi.maDK, SinhVien.tenSV, HocPhan.tenHP, LopHocPhan.maLHP, LopHocPhan.maHocKi
FROM DangKiTinChi
JOIN SinhVien ON DangKiTinChi.maSV = SinhVien.maSV
JOIN DangKiChiTiet ON DangKiTinChi.maDK = DangKiChiTiet.maDK
JOIN LopHocPhan ON DangKiChiTiet.maLHP = LopHocPhan.maLHP
JOIN HocPhan ON LopHocPhan.maHP = HocPhan.maHP;
--w.	Hãy hiển thị các lớp sinh hoạt và tổng số sinh viên trong lớp sinh hoạt đó
SELECT l.maLSH, l.tenLSH, COUNT(s.maSV) as soLuongSinhVien
FROM dbo.LopSH as l
INNER JOIN dbo.SinhVien as s ON s.maLSH= l.maLSH
GROUP BY l.maLSH, l.tenLSH;
--x.	Hãy hiện thị các lớp sinh hoạt có tổng số sinh viên là 5 trở lên 
SELECT l.maLSH, l.tenLSH, COUNT(s.maSV) as soLuongSinhVien
FROM dbo.LopSH as l
INNER JOIN dbo.SinhVien as s ON s.maLSH= l.maLSH
GROUP BY l.maLSH, l.tenLSH
HAVING COUNT(s.maSV) >5;
-- Hiển thị các sinh viên nữ thuộc khoa công nghệ thông tin
SELECT SinhVien.maSV, SinhVien.tenSV, SinhVien.gioiTinh, SinhVien.ngaySinh, SinhVien.diaChi, SinhVien.email, SinhVien.SDT
FROM SinhVien
JOIN LopSH ON SinhVien.maLSH = LopSH.maLSH
JOIN Khoa ON LopSH.maKhoa = Khoa.maKhoa
WHERE SinhVien.gioiTinh = 'F' AND Khoa.tenKhoa = N'Khoa Công Nghệ Thông Tin';
-- Hãy cho biết số lượng sinh viên của mỗi khoa
SELECT Khoa.maKhoa, Khoa.tenKhoa, COUNT(SinhVien.maSV) AS SoLuongSinhVien
FROM Khoa
JOIN LopSH ON Khoa.maKhoa = LopSH.maKhoa
JOIN SinhVien ON LopSH.maLSH = SinhVien.maLSH
GROUP BY Khoa.maKhoa, Khoa.tenKhoa;


-- CREATE VIEW 
--1. tạo view chứa sinh viên năm nhất(namBD=2023) 
CREATE VIEW v_sinhVienK23
AS
SELECT s.*, namBD
FROM dbo.SinhVien AS s
JOIN dbo.LopSH AS l ON s.maLSH = l.maLSH
WHERE l.namBD =2023

--2 Tạo view chưa các sinh viên khong tham gia đăng kí học phần kì 123
CREATE VIEW v_sinhVien_K_ĐKHP
AS
SELECT
SV.maSV,SV.tenSV,SV.maLSH,SV.ngaySinh,SV.SDT,SV.email,
SV.gioiTinh,SV.diaChi
FROM SinhVien SV
WHERE
    SV.maSV NOT IN (
        SELECT DISTINCT SV.maSV
        FROM SinhVien SV
        JOIN DangKiTinChi DK ON SV.maSV = DK.maSV
        JOIN DangKiChiTiet DKCT ON DK.maDK = DKCT.maDK
        JOIN LopHocPhan LHP ON DKCT.maLHP = LHP.maLHP
        JOIN HocPhan HP ON LHP.maHP = HP.maHP
		WHERE LHP.maHocKi='123'
    );

-- 3 Tạo view chứa những hoc phần không nằm trong chương trình đào tạo nào.
CREATE VIEW v_HP_KhongCoTrongChuongTrinhDaoTao
AS
SELECT maHP, tenHP
FROM HocPhan
WHERE maHP NOT IN (
    SELECT maHP
    FROM ChuongTrinhDaoTao_HocPhan
);

-- 4: Tạo view Danh sách các lớp học phần mào vào thứ 2 tiết 3-4:
CREATE VIEW LopHocPhan_T2_Tiet34 AS
SELECT *
FROM LopHocPhan
WHERE maTG_PH IN (SELECT maThoiGian FROM ThoiGian WHERE Thu = N'Thứ 2' AND (tietBD = 3 OR tietBD = 4));


-- 5 Tạo View chứa tất cả các sinh viên nữ của khoa công nghệ thông tin  có maKhoa='KHOA001'
CREATE VIEW SinhVien_Nu_KhoaCNTT AS
SELECT *
FROM SinhVien
WHERE gioiTinh = 'F' AND maLSH IN (SELECT maLSH FROM LopSH WHERE maKhoa = 'KHOA001');

-- 6 tạo view chứa danh sách và số lượng sinh viên của các khoa


CREATE VIEW SoLuongSinhVien_Khoa AS
SELECT Khoa.maKhoa, tenKhoa,COUNT(*) AS SoLuongSV
FROM Khoa
JOIN LopSH ON Khoa.maKhoa = LopSH.maKhoa
JOIN SinhVien ON LopSH.maLSH = SinhVien.maLSH
GROUP BY Khoa.maKhoa, tenKhoa;

-- 7 Tạo view chưa danh sách lớp và số lượng sinh viên của mỗi lớp
-- INSERT thêm sinh viên
INSERT INTO SinhVien (maSV, maLSH, tenSV, gioiTinh, ngaySinh, diaChi, email, SDT, matkhau)
VALUES
    ('SV006', 'LSH001', N'Nguyễn Văn Lih', 'M', '2000-01-01', N'123 Đường ABC', 'nguyn.thi.x@gmail.com', '0183456789', 'matkhau1'),
    ('SV007', 'LSH001', N'Trần Văn Nhật', 'F', '2001-02-02', N'456 Đường XYZ', 'trn.van.y@gmail.com', '0987684321', 'matkhau2'),
    ('SV008', 'LSH003', N'Hồ Thị Hương', 'F', '2002-03-03', N'789 Đường DEF', 'ho.ti.z@gmail.com', '0369258791', 'matkhau3'),
    ('SV009', 'LSH003', N'Lê Văn Viên', 'M', '2003-04-04', N'987 Đường LMN', 'le.va.w@gmail.com', '0897456320', 'matkhau4'),
    ('SV010', 'LSH003', N'Phạm Thị Trà My', 'M', '2004-05-05', N'741 Đường UVW', 'phm.thi.u@gmail.com', '0327456987', 'matkhau5');

CREATE VIEW v_SoLuongSV_Lop_Khoa
AS
SELECT l.maLSH, tenLSH,k.maKhoa,tenKhoa, COUNT(s.maLSH) as SoLuongSV
FROM dbo.SinhVien s 
JOIN dbo.LopSH l on s.maLSH = l.maLSH
JOIN dbo.Khoa k on l.maKhoa = k.maKhoa
GROUP BY l.maLSH, tenLSH,k.maKhoa,tenKhoa

-- 8 Danh sách sinh viên có đăng kí học phần 1 của chương trình đào tạo một
CREATE VIEW SinhVien_HocHP1_CTD1 AS
SELECT SV.*,HP.tenHP,CTD.tenChuongTrinhDaoTao
FROM SinhVien SV
JOIN DangKiTinChi DK ON SV.maSV = DK.maSV
JOIN DangKiChiTiet DKCT ON DK.maDK = DKCT.maDK
JOIN LopHocPhan LHP ON DKCT.maLHP = LHP.maLHP
JOIN HocPhan HP ON LHP.maHP = HP.maHP
JOIN ChuongTrinhDaoTao_HocPhan CTD_HP ON HP.maHP = CTD_HP.maHP
JOIN ChuongTrinhDaoTao CTD ON CTD_HP.maChuongTrinhDaoTao = CTD.maChuongTrinhDaoTao
WHERE CTD.tenChuongTrinhDaoTao = N'Chương Trình Đào Tạo 1' AND HP.tenHP = N'Học Phần 1';

--Kiểm tra xem có sinh viên nào có giới tính nam hay 
--không nếu có thì  in ra ‘Co sinh vien nam trong danh sách’ ngược lại in ra ‘Khong co sinh vien nam trong danh sach’.

IF EXISTS (SELECT * FROM SinhVien WHERE gioiTinh = 'M')
    PRINT 'Có sinh viên nam trong danh sách.';
ELSE
    PRINT 'Không có sinh viên nam trong danh sách.';

-- Kiểm tra xem Giáo viên có maGV Gv001 có tồn tại hay không 
DECLARE @maGV CHAR(15);
SET @maGV = 'GV001';

IF EXISTS (SELECT 1 FROM GiaoVien WHERE maGV = @maGV)
    PRINT N'Giáo viên có mã ' + @maGV + N' tồn tại.';
ELSE
    PRINT N'Không có giáo viên nào có mã ' + @maGV + '.';

--c.	Kiểm tra sinh viên có mã sinh viên SV001 có đăng kí môn học nào đó hay không
--nếu sinh viên có đăng kí môn học nào đó thì in ra’Sinh viên có mã’ + maSV+ ‘đã đăng kí môn học.’, 
--ngược lại thì in ra ‘Sinh viên có mã’ +maSV + ‘ chưa đăng kí môn học 
DECLARE @maSV CHAR(15);
SET @maSV = 'SV001';

IF EXISTS (SELECT 1 FROM DangKiTinChi WHERE maSV = @maSV)
    PRINT 'Sinh viên có mã ' + @maSV + ' đã đăng ký môn học.';
ELSE
    PRINT 'Sinh viên có mã ' + @maSV + ' chưa đăng ký môn học.';



DECLARE @maLHP CHAR(15) = 'LHP001'; 
IF EXISTS (
    SELECT *
    FROM LopHocPhan
    WHERE maLHP = @maLHP
        AND soLuongDDK >= 0.5 * soLuongDK
)
    PRINT N'Lớp học phần ' + @maLHP + N' đã đạt đến 50% số lượng đăng ký.';
ELSE
    PRINT N'Lớp học phần ' + @maLHP + N' chưa đạt đến 50% số lượng đăng ký.';

 -- Sử dụng câu lệnh SELECT  để  kiểm tra tất ca các lớp học phần xem đã đủ số lượng DDK hay chưa

SELECT
    maLHP,
    soLuongDDK,
    soLuongDK,
    CASE
        WHEN soLuongDDK >= 0.5 * soLuongDK THEN N'Đạt 50% trở lên'
        ELSE N'Chưa đạt 50%'
    END AS TrangThai
FROM LopHocPhan

--Câu truy vấn cập nhật giới tính của sinh viên có mã 'SV001', 'SV002', 'SV003' thành 'M' nếu giới tính là 'F' và ngược lại:
UPDATE SinhVien
SET gioiTinh = CASE
    WHEN gioiTinh = 'F' THEN 'M'
    ELSE 'F'
END
WHERE maSV IN ('SV001', 'SV002', 'SV003');

--Câu truy vấn cập nhật tên lớp học phần có mã 'LHP001' thành 'Lớp Tin Học Cơ Sở' nếu số lượng đăng ký lớn hơn , 50 ngược lại giữ nguyên:
UPDATE dbo.LopHocPhan
SET tenLHP = CASE
    WHEN soLuongDK > 40 THEN 'Lớp Tin Học Cơ Sở'
    ELSE tenLHP
END
WHERE maLHP = 'LHP001';
select * from dbo.LopHocPhan

--Câu truy vấn cập nhật tên giáo viên có mã 'GV003' thành 'Nguyễn Minh Cường' nếu tên giáo viên là 'Hồ Minh C', ngược lại giữ nguyên:

UPDATE GiaoVien
SET tenGV = CASE
    WHEN tenGV = N'Hồ Minh C' THEN N'Nguyễn Minh Cường'
    ELSE tenGV
END
WHERE maGV = 'GV003';

-- Câu truy vấn lấy thông tin về sinh viên và hiển thị giới tính dưới dạng chuỗi 'Nam' hoặc 'Nữ'

SELECT maSV, tenSV, 
    CASE
        WHEN gioiTinh = 'M' THEN N'Nam'
        WHEN gioiTinh = 'F' THEN N'Nữ'
        ELSE N'Khác'
    END AS GioiTinh
FROM SinhVien;



--Câu truy vấn lấy thông tin về lớp sinh hoạt và hiển thị tên mới của các lớp có mã 'LSH003', 'LSH004', 'LSH005':
SELECT maLSH, tenLSH,
    CASE
        WHEN maLSH = 'LSH003' THEN N'Lớp SH3'
        WHEN maLSH = 'LSH004' THEN N'Lớp SH4'
        WHEN maLSH = 'LSH005' THEN N'Lớp SH5'
        ELSE tenLSH
    END AS TenMoi
FROM LopSH
WHERE maLSH IN ('LSH003', 'LSH004', 'LSH005');
-- Câu truy vấn kiểm tra và hiển thị thông tin về sinh viên có tuổi từ 19 trở lên:
SELECT maSV, tenSV, ngaySinh,
    CASE
        WHEN DATEDIFF(YEAR, ngaySinh, GETDATE()) >= 19 THEN N'Tuổi đủ 19+'
        ELSE N'Chưa đủ 19 tuổi'
    END AS TinhTrangTuoi
FROM SinhVien;



--Câu truy vấn lấy thông tin về lớp học phần và hiển thị 'Đã đủ đăng ký'nếu số lượng đăng ký bằng số lượng đăng ký đủ, ngược lại 'Chưa đủ đăng ký':
SELECT maLHP, soLuongDK, soLuongDDK,
    CASE
        WHEN soLuongDDK = soLuongDK THEN N'Đã đủ đăng ký'
        ELSE N'Chưa đủ đăng ký'
    END AS TinhTrangDangKy
FROM LopHocPhan;
--Câu truy vấn lấy thông tin về thời gian và hiển thị 'Buổi sáng' nếu thời gian nằm trong khoảng buổi sáng, ngược lại 'Buổi chiều'


SELECT maThoiGian, Thu, tietBD, tietKT,
    CASE
        WHEN tietBD >= 1 AND tietKT <= 5 THEN N'Buổi sáng'
        ELSE N'Buổi chiều'
    END AS BuoiHoc
FROM ThoiGian;

--Câu truy vấn lấy thông tin về sinh viên và hiển thị 'Email hợp lệ' nếu email có định dạng đúng, ngược lại 'Email không hợp lệ'
SELECT maSV, tenSV, email,
    CASE
        WHEN email LIKE '%@gmail.com' THEN N'Email hợp lệ'
        ELSE N'Email không hợp lệ'
    END AS TinhTrangEmail
FROM SinhVien;


-- SỬ DUNG UNIION 

-- UNION Câu truy vấn kiểm tra và hiển thị giới tính của sinh viên và giáo viên:
SELECT maSV, tenSV, gioiTinh AS GioiTinhSinhVien
FROM SinhVien
UNION
SELECT maGV, tenGV, gioiTinh AS GioiTinhGiaoVien
FROM GiaoVien;



-- Chọn sinh viên có tổng soLuongDDK từ 4 đến 10
-- Chọn sinh viên có tổng soLuongDDK từ 4 đến 10
-- Chọn sinh viên có tổng soLuongDDK từ 4 đến 10
select * from dbo.DangKiChiTiet
select * from dbo.DangKiTinChi

SELECT s.maSV, tenSV, SUM(soLuongDDK) AS TongSoLuongDDK
FROM SinhVien AS s
JOIN DangKiTinChi dktc ON s.maSV = dktc.maSV
JOIN DangKiChiTiet AS dkct ON dktc.maDK = dkct.maDK
JOIN LopHocPhan AS lhp ON dkct.maLHP = lhp.maHP
GROUP BY s.maSV, tenSV
HAVING SUM(soLuongDDK) BETWEEN 1 AND 10

UNION

-- Chọn sinh viên có Lớp học phần có maHP là 'HP001'
SELECT maSV, tenSV, SUM(soLuongDDK) AS TongSoLuongDDK
FROM SinhVien
JOIN DangKiTinChi ON SinhVien.maSV = DangKiTinChi.maSV
JOIN LopHocPhan ON DangKiTinChi.maLHP = LopHocPhan.maLHP
WHERE LopHocPhan.maHP = 'HP001'
GROUP BY maSV, tenSV;


-- Chọn những sinh viên có tổng số tín chỉ đăng ký từ 2 đến 10
SELECT SV.* 
FROM SinhVien SV
JOIN DangKiTinChi DKT ON SV.maSV = DKT.maSV
JOIN DangKiChiTiet DKCT ON DKT.maDK = DKCT.maDK
JOIN LopHocPhan LHP ON DKCT.maLHP = LHP.maLHP
JOIN HocPhan HP ON LHP.maHP = HP.maHP
WHERE SV.maSV IN (
    SELECT maSV
    FROM DangKiTinChi DKT
    JOIN DangKiChiTiet DKCT ON DKT.maDK = DKCT.maDK
    JOIN LopHocPhan LHP ON DKCT.maLHP = LHP.maLHP
    JOIN HocPhan HP ON LHP.maHP = HP.maHP
    GROUP BY maSV
    HAVING SUM(HP.soTC) BETWEEN 2 AND 10
)

-- Câu truy vấn 3: Chọn những sinh viên có địa chỉ email kết thúc bằng '@gmail.com'
-- Câu truy vấn 4: Chọn những sinh viên có số điện thoại bắt đầu bằng '09'
SELECT *
FROM SinhVien
WHERE email LIKE '%@gmail.com%'
UNION
SELECT *
FROM SinhVien
WHERE SDT LIKE '09%';



SELECT *
FROM SinhVien
WHERE gioiTinh = 'Nam'
UNION
SELECT *
FROM SinhVien
WHERE MONTH(ngaySinh) BETWEEN 1 AND 6;



--Từ view đã tạo hay thực hiện những câu truy vấn sau 
--1 Hiển thị thông tin của tất cả sinh viên khóa 23 có giới tính là nam(M) 
SELECT * FROM dbo.v_sinhVienK23
WHERE gioiTinh ='M'
-- 2 Hiển thị thông tin của tất cả sinh viên khóa 23 có giới tính là nữ và thuộc lớp sinh hoạt 01

-- 