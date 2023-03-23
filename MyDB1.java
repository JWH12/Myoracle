package oracle_project;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;



public class MyDB1 {	
	public static void main(String[] args) {
	
	Connection conn;  //DB 연동 필수
	Statement stmt = null; //DB 연동 필수
	Scanner s = new Scanner(System.in);
	
	try {
		Class.forName("com.mysql.jdbc.Driver"); // MySQL 드라이버 로드
		conn = DriverManager.getConnection
				("jdbc:mysql://localhost:3306/java", "root","test1234"); // JDBC 연결
		System.out.println("DB 연결 완료");
				
//		stmt = conn.createStatement();
//		stmt.executeUpdate("insert into student (name, id, dept) values('아무개', '0893012', '컴퓨터공학')");
//		printTable(stmt);
//		stmt.executeUpdate("update student set id = '0189011' where id = '아무개'");
//		printTable(stmt);
//		stmt.executeUpdate("delete from student where id = '아무개'");
//		printTable(stmt);
//		
		
		
	  // ==================================== 아이디 및 비밀번호 입력하는 법 ===============================================
//		stmt = conn.createStatement(); // db와 연결시키는 코드
//		
//		System.out.println("아이디를 입력해 주세요 : ");
//		String id = s.nextLine();
//		
//		System.out.println("비밀번호를 입력해 주세요 : ");
//		String pw = s.nextLine();
//		
//		ResultSet srs = stmt.executeQuery 
//				("select * from student where id = " + id + " and pw = " + pw);
//		
//			
//		if(srs.next()) { //검색결과에 대한 조건문
//			System.out.println("로그인이 되었습니다.");
//		} else {
//			System.out.println("로그인이 실패되었습니다.");
//		}
		
		
		// ==================================== 새로운 회원데이터를 저장 하는 법 ===============================================	
		
		stmt = conn.createStatement();
		
		try {
			System.out.println("회원가입 ");
			System.out.print("아이디 >> ");
			String joinId = s.nextLine();
			System.out.print("패스워드 >> ");
			String joinPw = s.nextLine();
			System.out.print("이름 >> ");
			String name = s.nextLine();
			System.out.print("학과 >> ");
			String dept = s.nextLine();
			stmt.executeUpdate("insert into student (id, pw, name, dept) values("+ joinId +"," + joinPw + "," + name + "," + dept + ");"); // 레코드 추가
			System.out.println("추가되었습니다.");
			
		} catch (SQLException e) {
			System.out.println("레코드 추가 에러");
		}
		
		
	} catch (ClassNotFoundException e) {
		System.out.println("JDBC 드라이버 로드 에러");
	} catch (SQLException e) {
		System.out.println("DB 연결 오류");
	}
	
}



private static void printTable(Statement stmt) throws SQLException{
	
	ResultSet srs = stmt.executeQuery("select * from student");
	
	while (srs.next()) {
		System.out.print(srs.getString("name"));
		System.out.print("\t|\t" + srs.getString("id"));
		System.out.println("\t|\t" + srs.getString("id"));
		
	}
	
}

}








