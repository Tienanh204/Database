

--Q58. Cho biết tên giáo viên nào mà tham gia đề tài đủ tất cả các chủ đề.
--Với mỗi giáo viên có tham gia đề tài (R)
--Tìm những đề tài mà giao viên đó chưa tham gia (1)
--Không tồn tại (1) --> Giao viên tham gia tất cả các đề tài
select gv.Hoten
from GIAOVIEN gv join THAMGIADETAI tg on gv.Magv=tg.Magv
where not exists(
	  select Madt from DETAI
	  except
	  select distinct Madt from THAMGIADETAI where Madt=tg.Madt)

--Q59. Cho biết tên đề tài nào mà được tất cả các giáo viên của bộ môn HTTT tham gia.
select DT.Tendt as TenDT
from DETAI DT
where not exists(
	  select  distinct TG.Madt from THAMGIADETAI TG
	  join GIAOVIEN GV on TG.Magv=GV.Magv and GV.Mabm = 'HTTT'
	  where not exists(
			select Madt
			from THAMGIADETAI TG1
			where TG1.Madt=dt.Madt and TG1.Magv=GV.Magv))
			

--Q60. Cho biết tên đề tài có tất cả giảng viên bộ môn “Hệ thống thông tin” tham gia
SELECT  DT.Tendt as N'TenDT'
FROM DETAI DT
JOIN THAMGIADETAI TG on TG.Madt=DT.Madt
where NOT EXISTS(
	SELECT *
	FROM GIAOVIEN GV JOIN BOMON BM ON GV.Mabm=BM.Mabm
	WHERE BM.Tenbm like N'Hệ thống thông tin' AND NOT EXISTS(
		  SELECT *
		  FROM THAMGIADETAI TG1
		  WHERE TG1.MADT=DT.MADT AND TG1.MAGV=GV.MAGV))


--Q61. Cho biết giáo viên nào đã tham gia tất cả các đề tài có mã chủ đề là QLGD.
--C1
select GV.Hoten
from GIAOVIEN GV
where not exists(
	  select Madt from DETAI DT
	  where Macd='QLGD' and not exists(
		    select Madt
		    from THAMGIADETAI TG
		    where TG.Madt=DT.Madt and TG.Magv=GV.Magv))
--C2:
select TG.MAGV
FROM THAMGIADETAI TG JOIN DETAI DT ON TG.Madt=DT.Madt
WHERE NOT EXISTS(
	  SELECT MADT FROM DETAI
	  WHERE Macd='QLGD'
	  EXCEPT
	  SELECT DISTINCT(TG1.MADT) FROM THAMGIADETAI TG1 JOIN DETAI DT1 ON DT1.Madt=TG1.Madt
	  WHERE DT1.Macd='QLGD' AND TG1.Magv=TG.Magv) 


--Q62. Cho biết tên giáo viên nào tham gia tất cả các đề tài mà giáo viên Trần Trà Hương đã tham gia.
select DISTINCT GV.Hoten
from GIAOVIEN GV JOIN THAMGIADETAI TG ON GV.Magv=TG.Magv
where GV.Hoten <> N'Trần Trà Hương' and not exists(
	  select TG1.Madt from THAMGIADETAI TG1
	  JOIN GIAOVIEN GV1 on TG1.Magv=GV1.Magv
	  where GV1.Hoten like N'Trần Trà Hương' and not exists(
			select TG2.Madt
			from THAMGIADETAI TG2
			where TG2.Magv=GV.Magv and TG2.Madt=TG1.Madt))

--Q63. Cho biết tên đề tài nào mà được tất cả các giáo viên của bộ môn Hóa Hữu Cơ tham gia.
SELECT DT.Tendt as N'TenDT', COUNT(DISTINCT TG.MAGV) AS SOGV
FROM DETAI DT
JOIN THAMGIADETAI TG on TG.Madt=DT.Madt
JOIN GIAOVIEN GV ON GV.Magv=TG.Magv
JOIN BOMON BM ON GV.Mabm=BM.Mabm AND BM.Tenbm LIKE N'Hóa Hữu Cơ'
GROUP BY DT.Tendt
HAVING COUNT(DISTINCT TG.MAGV) = (
	   SELECT COUNT(DISTINCT TG1.MAGV)
	   FROM THAMGIADETAI TG1
	   JOIN GIAOVIEN GV1 ON GV1.Magv=TG1.Magv
	   JOIN BOMON BM1 ON GV1.Mabm=BM1.Mabm AND BM1.Tenbm LIKE N'Hóa Hữu Cơ')

--Q64. Cho biết tên giáo viên nào mà tham gia tất cả các công việc của đề tài 006.
SELECT DISTINCT GV.HOTEN
FROM GIAOVIEN GV JOIN THAMGIADETAI TG ON GV.Magv=TG.Magv
WHERE NOT EXISTS(
	  SELECT * 
	  FROM THAMGIADETAI TG1 JOIN CONGVIEC CV1 ON TG1.Madt=CV1.Madt AND TG1.Stt=CV1.Stt
	  WHERE TG1.Madt='006' AND NOT EXISTS(
			SELECT *
			FROM THAMGIADETAI TG2
			WHERE TG2.Magv=GV.Magv AND TG2.Madt=CV1.Madt AND TG2.Stt=CV1.Stt))

--Q65. Cho biết giáo viên nào đã tham gia tất cả các đề tài của chủ đề Ứng dụng công nghệ.
SELECT *
FROM GIAOVIEN GV
WHERE NOT EXISTS(
	  SELECT DT.Madt 
	  FROM DETAI DT
	  JOIN CHUDE CD ON DT.Macd=CD.Macd
	  WHERE CD.Tencd LIKE N'Ứng dụng công nghệ' AND NOT EXISTS(
			SELECT TG.Madt 
			FROM THAMGIADETAI TG
			WHERE TG.Magv=GV.Magv AND TG.Madt=DT.Madt))

--Q66. Cho biết tên giáo viên nào đã tham gia tất cả các đề tài của do Trần Trà Hương làm chủ nhiệm.
SELECT DISTINCT HOTEN
FROM GIAOVIEN GV JOIN THAMGIADETAI TG ON GV.Magv=TG.Magv
WHERE NOT EXISTS(
	  SELECT DT1.Madt FROM DETAI DT1
	  JOIN GIAOVIEN GV1 ON DT1.Gvcndt=GV1.Magv
	  WHERE GV1.Hoten LIKE N'Trần Trà Hương' AND NOT EXISTS(
			SELECT TG1.Madt FROM THAMGIADETAI TG1
			WHERE TG1.Magv=GV.Magv AND TG1.Madt=DT1.Madt))

--Q67. Cho biết tên đề tài nào mà được tất cả các giáo viên của khoa CNTT tham gia.
SELECT DISTINCT DT.Tendt
FROM DETAI DT JOIN THAMGIADETAI TG ON DT.Madt=TG.Madt
WHERE NOT EXISTS(
	  SELECT DISTINCT TG1.Madt FROM THAMGIADETAI TG1
	  JOIN GIAOVIEN GV1 ON TG1.Magv=GV1.Magv
	  JOIN BOMON BM1 ON GV1.Mabm=BM1.Mabm
	  JOIN KHOA K1 ON BM1.Makhoa=K1.Makhoa
	  WHERE K1.Makhoa='CNTT' AND NOT EXISTS(
			SELECT TG2.MADT FROM THAMGIADETAI TG2
			WHERE TG2.Madt=DT.Madt AND TG2.Magv=TG1.Magv))
			
--Q68. Cho biết tên giáo viên nào mà tham gia tất cả các công việc của đề tài Nghiên cứu tế bào gốc.
SELECT DISTINCT GV.Hoten
FROM GIAOVIEN GV JOIN THAMGIADETAI TG ON GV.Magv=TG.Magv
WHERE NOT EXISTS(
	  SELECT CV1.Madt FROM CONGVIEC CV1 JOIN DETAI DT1 ON CV1.Madt=DT1.Madt
	  WHERE DT1.Tendt LIKE N'Nghiên cứu tế bào gốc' AND NOT EXISTS(
		    SELECT TG2.Madt FROM THAMGIADETAI TG2
	        WHERE TG2.Magv=GV.Magv AND TG2.Madt=CV1.Madt AND TG2.Stt=CV1.Stt))

--Q69. Tìm tên các giáo viên được phân công làm tất cả các đề tài có kinh phí trên 100 triệu?
SELECT GV.Hoten, COUNT(DISTINCT DT.MADT) AS SoDT
FROM GIAOVIEN GV 
JOIN THAMGIADETAI TG ON GV.Magv=TG.Magv
JOIN DETAI DT ON TG.Madt=DT.Madt AND DT.KINHPHI > 200
GROUP BY GV.Hoten
HAVING COUNT(DT.MADT) = (SELECT COUNT(MADT) FROM DETAI WHERE Kinhphi > 200)

--Q70. Cho biết tên đề tài nào mà được tất cả các giáo viên của khoa Sinh Học tham gia.
--C1:
SELECT DT.TENDT, COUNT(DISTINCT GV.Magv) AS SoGV
FROM DETAI DT
JOIN THAMGIADETAI TG ON TG.Madt=DT.Madt
JOIN GIAOVIEN GV ON TG.Magv=GV.Magv
JOIN BOMON BM ON GV.Mabm=BM.Mabm
JOIN KHOA K ON BM.Makhoa=K.Makhoa AND K.Tenkhoa LIKE N'Sinh Học'
GROUP BY DT.Tendt
HAVING  COUNT(DISTINCT TG.Magv) = (
		SELECT COUNT(DISTINCT TG.Magv)
		FROM THAMGIADETAI TG
		JOIN GIAOVIEN GV ON TG.Magv=GV.Magv
		JOIN BOMON BM ON GV.Mabm=BM.Mabm
		JOIN KHOA K ON BM.Makhoa=K.Makhoa 
		WHERE K.Tenkhoa LIKE N'Sinh học')

--C2:
SELECT DT.TENDT
FROM DETAI DT
WHERE NOT EXISTS(
	  SELECT TG.Madt
	  FROM THAMGIADETAI TG
	  JOIN GIAOVIEN GV ON TG.Magv=GV.Magv
	  JOIN BOMON BM ON GV.Mabm=BM.Mabm
	  JOIN KHOA K ON BM.Makhoa=K.Makhoa 
	  WHERE K.Tenkhoa LIKE N'Sinh học' AND NOT EXISTS(
			SELECT TG1.MADT FROM THAMGIADETAI TG1
			WHERE TG1.Madt=DT.Madt AND TG1.Magv=TG.Magv))

--Q71. Cho biết mã số, họ tên, ngày sinh của giáo viên tham gia tất cả các công việc của đề tài “Ứng dụng hóa học xanh”.
SELECT DISTINCT GV.MAGV, GV.HOTEN, GV.NGAYSINH
FROM GIAOVIEN GV JOIN THAMGIADETAI TG ON GV.Magv=TG.Magv
WHERE NOT EXISTS(
	  SELECT CV1.Madt FROM CONGVIEC CV1
	  JOIN DETAI DT1 ON DT1.Madt=CV1.Madt
	  WHERE DT1.Tendt LIKE N'Nghiên cứu tế bào gốc' 
	  AND NOT EXISTS(
			SELECT TG2.MADT FROM THAMGIADETAI TG2
			WHERE TG2.Magv=GV.Magv AND TG2.Madt=CV1.Madt AND TG2.Stt=CV1.Stt))

--Q72. Cho biết mã số, họ tên, tên bộ môn và tên người quản lý chuyên môn của giáo viên tham gia tất cả các đề tài thuộc chủ đề “Nghiên cứu phát triển”.
SELECT DISTINCT GV.MAGV, GV.HOTEN, GV.NGAYSINH, GV.Gvqlbm
FROM GIAOVIEN GV JOIN THAMGIADETAI TG ON GV.Magv=TG.Magv
WHERE NOT EXISTS(
	  SELECT DISTINCT DT1.Madt FROM DETAI DT1 
	  JOIN CHUDE CD1 ON DT1.Macd=CD1.Macd
	  WHERE CD1.Macd = 'NCPT' AND NOT EXISTS(
			SELECT TG2.MADT FROM THAMGIADETAI TG2
			WHERE TG2.Magv=GV.Magv AND TG2.Madt=DT1.Madt))