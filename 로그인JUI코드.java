package oracle_project;


import java.awt.Container;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;

public class 로그인JUI코드  extends JFrame { //직접 하지는 않는다 
	Connection conn;
	Statement stmt = null;
	JTextField id = new JTextField(15);
	JPasswordField pwd = new JPasswordField(15);
	public 로그인JUI코드() {
		setTitle("test1");
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		Container c = getContentPane();
		c.setLayout(null);
		setResizable(false);
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); // MySQL 드라이버 로드
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/java", "root","test1234"); // JDBC 연결
			System.out.println("DB 연결 완료");
			stmt = conn.createStatement(); // SQL문 처리용 Statement 객체 생성
			
		} catch (ClassNotFoundException e) {
			System.out.println("JDBC 드라이버 로드 오류");
		} catch (SQLException e) {
			System.out.println("SQL 실행오류");
		} 
		
//		DialogEx1 dialog = new DialogEx1(this);
		
		JMenuBar mb = new JMenuBar();
		JMenu fileMenu = new JMenu("Screen");
		JMenuItem openItem = new JMenuItem("Clear");
		
		openItem.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				// TODO Auto-generated method stub
				id.setText("");
				pwd.setText("");
			}
		});
		fileMenu.add(openItem);
		mb.add(fileMenu);
		setJMenuBar(mb);
		
		Panel1 p1 = new Panel1();
		p1.setSize(200,150);
		p1.setLocation(100,30);
		c.add(p1);
		
		JButton btn = new JButton("로그인");
		btn.addActionListener(new MyAction());
		pwd.addActionListener(new MyAction());
		
		btn.setLocation(100, 190);
		btn.setSize(100, 30);
		c.add(btn);
		
//		JButton btn2 = new JButton("회원가입");
//		btn2.setLocation(200, 190);
//		btn2.setSize(100, 30);
//		btn2.addActionListener(new ActionListener() {
//			
//			@Override
//			public void actionPerformed(ActionEvent e) {
//				// TODO Auto-generated method stub
//				dialog.setVisible(true);
//				
//			}
//		});
//		c.add(btn2);
		
		setSize(400, 300);
		setVisible(true);
	}
	
	public class MyAction implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			// TODO Auto-generated method stub
			try {
				ResultSet srs = stmt.executeQuery("select * from student where id = " + id.getText() + " and pw = " + pwd.getText());
				if(srs.next()) {
					JOptionPane.showMessageDialog(로그인JUI코드.this, "로그인 성공", "성공", JOptionPane.INFORMATION_MESSAGE);
				} else {
					JOptionPane.showMessageDialog(로그인JUI코드.this, "로그인 실패", "실패", JOptionPane.WARNING_MESSAGE);
				}
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} // 테이블의 모든 데이터 검색
			
		}
		
	}
	
	private class Panel1 extends JPanel {
		Panel1() {
			add(new JLabel("아이디     "));
			add(id);
			add(new JLabel("비밀번호  "));
			add(pwd);						
		}
	}
	
	public static void main(String[] args) {
		new 로그인JUI코드();
	}
}

