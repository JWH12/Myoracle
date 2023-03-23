package oracle_project;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class DB연동문제 {
	
	public static void main(String[] args) {
		
//		
//		Connection conn;  //DB 연동 필수
//		Statement stmt = null; //DB 연동 필수
//		
//		Scanner s = new Scanner(System.in);
//		
//		
//		try {
//			Class.forName("com.mysql.jdbc.Driver"); // MySQL 드라이버 로드
//			conn = DriverManager.getConnection
//					("jdbc:mysql://localhost:3306/java", "root","test1234"); // JDBC 연결
//			System.out.println("DB 연결 완료");
//	
//			stmt = conn.createStatement();
//		
//   //========================== 정보를 입력하는 코드======================
//	try {
//						
//			System.out.println("추가(1), 삭제(2), 수정(3), 끝내기(4) >> ");
//			
//		
//			System.out.print("id >> ");
//			String Id = s.nextLine();
//			
//			System.out.print("책 이름 >> ");
//			String BookName = s.nextLine();
//			
//			System.out.print("출판사 >> ");
//			String Publisher = s.nextLine();
//			
//			System.out.print("작가 >> ");
//			String author = s.nextLine();
//			
//			stmt.executeUpdate("insert into student (id, pw, name, dept) values("+ Id +"," + BookName + "," + Publisher + "," + author + ");"); // 레코드 추가
//			System.out.println("추가되었습니다.");
//	
//			
//		 catch (SQLException e) {
//			System.out.println("레코드 추가 에러");
//		}
//	}	
//	
//		catch (ClassNotFoundException e) {
//		System.out.println("JDBC 드라이버 로드 에러");
//	} 
//	
//		catch (SQLException e) {
//		System.out.println("DB 연결 오류");
//}
//	}
//		
//		
//		
//		
//		
//	private static void printData(ResultSet srs, String col1, String col2, String col3, String col4) 
//			throws SQLException{
//				// TODO Auto-generated method stub
//			
//				while (srs.next()) {
//					if (!col1.equals("1")) 
//						System.out.print(srs.getString("name"));
//					
//					if (!col2.equals("2")) 
//						System.out.print("\t|\t" + srs.getString("id"));
//					
//					if (!col3.equals("3"))
//						System.out.println("\t|\t" + srs.getString("dept"));
//					
//					if (col4.equals("4")) {
//						System.out.println("입력이 종료되었습니다.");
//						
//						break;
//					}
//					else
//					System.out.println();
//				}
//	
	}
}
