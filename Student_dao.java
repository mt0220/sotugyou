package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Model.Student; // ← ServletじゃなくてBeansをimport

public class Student_dao {
	private final String JDBC_URL = "jdbc:h2:tcp://localhost/~/dokotsubu";
	private final String DB_USER = "sa";
	private final String DB_PASS = "";

	public List<Student> findAll() {
		List<Student> studentList = new ArrayList<>();

		try {
			Class.forName("org.h2.Driver"); 
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCドライバを読み込めませんでした");
		}

		try (Connection con = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
			String sql = "SELECT STUDENT_ID, NAME, CLASS FROM STUDENT";
			PreparedStatement pStmt = con.prepareStatement(sql);

			ResultSet rs = pStmt.executeQuery();
			while (rs.next()) {
				int studentId = rs.getInt("STUDENT_ID");
				String name = rs.getString("NAME");
				String sClass = rs.getString("CLASS");
				Student student = new Student(studentId, name, sClass);
				studentList.add(student);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}

		return studentList;
	}

	public boolean create(Student student) {
		try {
			Class.forName("org.h2.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCドライバを読み込めませんでした");
		}

		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
			String sql = "INSERT INTO STUDENT(STUDENT_ID, NAME, CLASS) VALUES(?, ?, ?)";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			pStmt.setInt(1, student.getStudentId()); 
			pStmt.setString(2, student.getName());
			pStmt.setString(3, student.getSClass());

			int result = pStmt.executeUpdate();
			if (result != 1) {
				return false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}

		return true;
	}
}
