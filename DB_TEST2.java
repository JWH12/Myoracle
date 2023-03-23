package oracle_project;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class DB_TEST2 {
	
	static Connection conn;
	static Statement stmt = null;
	static Scanner sin = new Scanner(System.in);
	
	public static void main (String[] args) {
		
		try {
//======DB연결 ===========================================================================================
			Class.forName("com.mysql.jdbc.Driver"); // MySQL 드라이버 로드
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/java", "root","test1234"); // JDBC 연결
			System.out.println("DB 연결 완료");
			
			stmt = conn.createStatement(); // SQL문 처리용 Statement 객체 생성

			
//======선택한 기능에 따라 실행되게하는 코드 ===========================================================================================
			printTable(stmt); // 모든 데이터 출력
			
			int choice = 1;
			
			while (choice != 4) {
				System.out.print("추가(1),삭제(2), 수정(3), 끝내기(4)>>");
				choice = Integer.parseInt(sin.nextLine());
				
				switch (choice) {
					
					case 1:
						add();
						break;
					
					case 2:
						delete();
						break;
					
					case 3:
						update();
						break;
					
					case 4:
						break;
					default:
						System.out.println("잘못 입력하셨습니다.");
				}
			}
		} catch (ClassNotFoundException e) {
			System.out.println("JDBC 드라이버 로드 에러");
		} catch (SQLException e) {
			System.out.println("SQL 실행 에러");
		}
	}
	
	
	
	
	
//======보유한 데이터를 수정 할 경우===========================================================================================
	private static void update() {
		try {
			System.out.print("수정할 컬럼 이름>>");
			String colName =  sin.nextLine();
			
			System.out.print("수정할 컬럼의 현재값 >>");
			String oldValue =  sin.nextLine();
			
			System.out.print("수정할 컬럼의 새로운 값 >>");
			String newValue =  sin.nextLine();
			
			if (colName.equals("id")) 
				stmt.executeUpdate("update student set " + colName + "="+ newValue + " where " + colName + "="+ oldValue + ""); //데이터 수정
			else
				stmt.executeUpdate("update student set " + colName + "='"+ newValue + "' where " + colName + "='"+ oldValue +"'"); //데이터 수정
			printTable(stmt);
		} 
		
			catch (SQLException e) {
			System.out.println("레코드 수정 에러");
		}	
	}
	
	
	
	
	
//======데이터를 삭제 할 경우===========================================================================================
	private static void delete() {
		try {
			System.out.print("id>>");
			String id =  sin.nextLine();
			
			// 입력한 레코드 삭제
			stmt.executeUpdate("delete from student where id='"+id + "'"); 
			printTable(stmt);
		} 
		
			catch (SQLException e) {
			System.out.println("레코드 삭제 에러");
		}
	}
	
	
	
	
//======데이터를 새로 추가 할 경우===========================================================================================
	private static void add() {
		try {
			System.out.print("아이디>>");
			String id = sin.nextLine();
			
			System.out.print("비밀번호>>");
			String pw = sin.nextLine();
			
			System.out.print("이름>>");
			String name = sin.nextLine();
			
			System.out.print("학과>>");
			String dept = sin.nextLine();
			
			// 레코드 추가
			stmt.executeUpdate("insert into student (id, pw, name, dept) values('"+ id +"','" + pw + "','" + name + "','" + dept + "');"); 
			printTable(stmt);  //insert한 레코드를 출력 해 주는 코드
		} 
		
			catch (SQLException e) {
			System.out.println("레코드 추가 에러");
		}
	}

	
	
	
// ================추가한 레코드의 각 열의 값을 화면에 출력========================================================
	
	private static void printTable(Statement stmt) {
		ResultSet srs;
		System.out.print("id");
		System.out.print("\t|\t" + "pw");
		System.out.print("\t|\t" + "name");
		System.out.println("\t|\t" + "dept");
		try {
			srs = stmt.executeQuery("select * from student");
			while (srs.next()) {
				System.out.print(srs.getString("id"));
				System.out.print("\t|\t" + srs.getString("pw"));
				System.out.print("\t|\t" + srs.getString("name"));
				System.out.println("\t|\t" + srs.getString("dept"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 실행 에러");
		}
	}

}
