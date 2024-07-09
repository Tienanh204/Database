--Tìm các giáo viên (MAGV) mà tham gia tất cả các đề tài

--C1: Dung EXCEPT
--Voi moi giang vien co tham gia de tai (R)
--Tim danh sach cac de tai ma gv khong tham gia (1)
--Khong ton tai tai ds (1) --> giao vien do tham gia tat ca
select distinct tg.Magv
from THAMGIADETAI tg
where not exists(
      (select Madt from DETAI)
	  except
	  (select Madt
	  from THAMGIADETAI tg1 
	  where tg.Magv = tg1.Magv)
)

--C2: Dung NOT EXISTS (Tương tự như duyệt 2 vòng for)
--Với mỗi MaDT
--Không tồn tại dòng trong THAMGIADETAI với Magv=001, Madt = Madt đang xét
--Không tồn tại ds (1) --> GV đó tham gia all đề tài
select tg.Magv
--for()1{
from THAMGIADETAI tg
--if1(
where not exists (
	  --for()2{
      select Madt
	  from DETAI dt
	  --if2(
	  where not exists (
	        select Madt
			from THAMGIADETAI tg1
			where dt.Madt = tg1.Madt and
			      tg.Magv = tg1.Magv ))
				--)
			--}
		--)
		--{ cout<<Magv<<endl; }--> if1
	--}

--C3L Dung GROUP BY
--GV01: 3
--GV02: 4
--GV03: 7
--Dếm số đề tài trong đề tài: X
--Nếu số đề tài tham gia của mỗi giao viên = X --> GV đó tham gia all đề tài
select Magv, COUNT(distinct Madt)
from THAMGIADETAI
group by Magv
having COUNT(distinct Madt) = (select COUNT(Madt) from DETAI)
