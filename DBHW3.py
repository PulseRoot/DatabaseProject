import pymysql

db = pymysql.connect(
    host='localhost',
    port=3306,
    user='root',
    password='~pdgphg7429',
    db='jejuair',
    charset='utf8'
)
cursors = db.cursor()
sql = """select ID, Password_ 
from Customer"""
cursors.execute(sql)
select = list(cursors.fetchall())
db.commit()

flag = 1  # 로그인 여부 확인 플래그
# id == park0417 pw == dong256
while (1):
    print("menu :(0) login (1) show my membership (2) book new flight (3)show my reservation (4) Logout")
    i = int(input())
    # 로그인 가능 여부 확인 후 로그인 기능 수행
    if i == 0 and flag ==1:
        id = input("ID : ")
        pw = input("PW : ")
        for i in range(len(select)):
            if id == select[i][0] and pw == select[i][1]:
                print("--LOG IN--")
                flag = 0
        if flag == 1:
            print("--LOG IN FAIL--")
    elif i==0 and flag ==0:
        print("you already Login")
    #1번 기능 수행
    elif i == 1 and flag == 0:
        print("--Show your Membership information--")
        sql = """select * from Customer"""
        cursors.execute(sql)
        select = list(cursors.fetchall())
        db.commit()
        #고객정보 print
        for i in range(len(select)):
            if id == select[i][7] and pw == select[i][8]:
                print(select[i])
                AM_num = select[i][0]
        #mileage 정보 print
        sql = """select Available_mileage from Mileage where Membership_number = %s"""
        cursors.execute(sql, AM_num)
        mileage = list(cursors.fetchall())
        print("Available_mileage : ", end="")
        print(mileage[0][0])
    #2번 기능 구현
    elif i == 2 and flag == 0:
        print("--Flight information--")
        sql = """select * from Flight"""
        cursors.execute(sql)
        select = list(cursors.fetchall())
        db.commit()
        for j in range(len(select)):
            print(select[j])
        print("--select Flight Name--")
        f_name = input()
        for i in range(len(select)):
            if select[i][0] == f_name and select[i][6] >= 1:
                print("--select 2 Additional Service--")#additional service 선택
                add = []
                add1 = int(input("More Baggage? : (1)Yes (0) No"))
                add.append(add1)
                add2 = int(input("Want meals? : (1)Yes (0) No"))
                add.append(add2)
                print("Additional Service(baggage, meal) : ", end="")
                print(add)
                print("--select 4 Pakage--")#Package 선택
                pak = []
                pak1 = int(input("Use Hotel? : (1)Yes (0) No"))
                pak.append(pak1)
                pak2 = int(input("Use Car_rental service? : (1)Yes (0) No"))
                pak.append(pak2)
                pak3 = int(input("Use Pocket-Wifi? : (1)Yes (0) No"))
                pak.append(pak3)
                pak4 = int(input("Use Insurance? : (1)Yes (0) No"))
                pak.append(pak4)
                print("Package : ", end="")
                print(pak)
                total = (sum(add) * 10000) + (sum(pak) * 100000) + select[i][5] # 총 가격 도출
                print("Total Cost : ", end="")
                print(total)

                print("--select Payment Type--")  # 결제수단 선택 0 or 1
                p_type = int(input("(0) : Use only Credit (1): Use Mileage and Credit"))
                if p_type == 0:  # 신용카드로만 결제
                    sql = """select Membership_number from Customer where ID = %s and Password_ = %s"""
                    cursors.execute(sql, (id, pw))
                    mem_num = cursors.fetchall()
                    mem_num = mem_num[0][0]  # 멤버쉽 번호 정보 받기

                    sql = """select Available_mileage from Mileage where Membership_number = %s"""
                    cursors.execute(sql, mem_num)
                    AM = cursors.fetchall()  # 받은 멤버쉽 넘버와 비교해서 보유 마일리지 값 변수에 저장
                    AM = AM[0][0]

                    sql = """UPDATE Mileage SET Available_mileage = %s where Membership_number = %s"""
                    AM = AM + total * 0.01
                    cursors.execute(sql, (AM, mem_num))  # 마일리지 정보 업데이트
                    db.commit()

                    # 새로운 결제정보 생성
                    cursors.execute("select count(*) from payment;")
                    data = list(cursors.fetchall())
                    cnt = data[0][0]
                    new_id = 101 + cnt
                    sql = """select Membership_number from Customer where ID = %s and Password_ = %s;"""
                    cursors.execute(sql, (id, pw))
                    mem_num = cursors.fetchall()
                    mem_num = mem_num[0][0]
                    new_data = (new_id, mem_num, f_name, p_type, total, AM)
                    sql = "INSERT INTO Payment values(%s,%s,%s,%s,%s,%s);"
                    cursors.execute(sql, new_data)
                    db.commit()
                    print("--Payment is Completed--")

                    # 새로운 예약정보 생성
                    cursors.execute("select count(*) from reservation;")
                    data = list(cursors.fetchall())
                    cnt = data[0][0]
                    new_rid = 201 + cnt
                    new_data = (new_rid, mem_num, new_id, f_name)
                    sql = "INSERT INTO reservation values(%s,%s,%s,%s)"
                    cursors.execute(sql, new_data)
                    db.commit()

                    # 좌석 수 업데이트
                    sql = "update Flight set Remaining_seat = Remaining_seat -1 where Flight_name = %s;"
                    cursors.execute(sql, f_name)
                    db.commit()
                    break
                elif p_type == 1:  # 마일리지도 이용한 결제
                    sql = """select Membership_number from Customer where ID = %s and Password_ = %s"""
                    cursors.execute(sql, (id, pw))
                    mem_num = cursors.fetchall()
                    mem_num = mem_num[0][0]  # 멤버쉽 번호 정보 받기

                    sql = """select Available_mileage from Mileage where Membership_number = %s"""
                    cursors.execute(sql, mem_num)
                    AM = cursors.fetchall()  # 받은 멤버쉽 넘버와 비교해서 보유 마일리지 값 변수에 저장
                    AM = AM[0][0]

                    total = total - AM  # 총 가격에서 사용 가능 마일리지 차감
                    sql = """UPDATE Mileage SET Available_mileage = %s where Membership_number = %s"""
                    AM = total * 0.01 # 마일리지 사용 이외 결제금액의 1%만큼 마일리지 적립
                    cursors.execute(sql, (AM, mem_num))
                    db.commit()


                    print("--Payment is Completed--")
                    #새로운 결제정보 생성
                    cursors.execute("select count(*) from payment;")
                    data = list(cursors.fetchall())
                    cnt = data[0][0]
                    new_id = 101 + cnt
                    sql = """select Membership_number from Customer where ID = %s and Password_ = %s;"""
                    cursors.execute(sql, (id, pw))
                    mem_num = cursors.fetchall()
                    mem_num = mem_num[0][0]
                    new_data = (new_id, mem_num, f_name, p_type, total, AM)
                    sql = "INSERT INTO Payment values(%s,%s,%s,%s,%s,%s);"
                    cursors.execute(sql, new_data)
                    db.commit()

                    #새로운 예약정보 생성
                    cursors.execute("select count(*) from reservation;")
                    data = list(cursors.fetchall())
                    cnt = data[0][0]
                    new_rid = 201 + cnt
                    new_data = (new_rid, mem_num, new_id, f_name)
                    sql = "INSERT INTO reservation values(%s,%s,%s,%s)"
                    cursors.execute(sql, new_data)
                    db.commit()

                    #좌석 수 업데이트
                    sql = "update Flight set Remaining_seat = Remaining_seat -1 where Flight_name = %s;"
                    cursors.execute(sql, f_name)
                    db.commit()
                    break
            elif select[i][6] == 0:
                print("No Remaining Seat") # 비행기의 잔여좍석이 없을 때
                break
    #Reservation 정보 출력
    elif i == 3 and flag == 0:
        sql = """select Membership_number from Customer where ID = %s and Password_ = %s"""
        cursors.execute(sql, (id, pw))
        mem_num = cursors.fetchall()
        mem_num = mem_num[0][0]

        cursors.execute('select Membership_number from Reservation;')
        data = cursors.fetchall()
        data_list = list(data)
        cond = 0
        for i in range(0, len(data_list)):
            k = data_list[i]
            num = k[0]
            if (mem_num == num):
                sql = """select * from reservation where Membership_number = %s"""
                cursors.execute(sql, mem_num)
                data = cursors.fetchall()
                cond = 1
                print(data)
                break
        if cond == 0:
            print("No reservation for you")
    #로그아웃 후 페이지 종료
    elif i == 4 and flag == 0:
        print("--LOG OUT--")
        break
    #로그인이 안 되어있으면 요구
    else:
        print("--Please Log in--")