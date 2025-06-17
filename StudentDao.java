package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Model.StudentBeans; 

public class StudentDao {
	// TCPサーバーモードでH2に接続（H2コンソールで確認可能）
	private final String JDBC_URL = "jdbc:h2:tcp://localhost/~/app";
	private final String DB_USER = "sa";
	private final String DB_PASS = "";

	public List<StudentBeans> findAll() {
		List<StudentBeans> studentList = new ArrayList<>();

		try {
			Class.forName("org.h2.Driver"); 
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCドライバを読み込めませんでした。H2ドライバーをWEB-INF/libに配置してください。");
		}

		try (Connection con = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
			String sql = "SELECT \n"
					+ "  s.student_id   AS student_id,\n"
					+ "  s.name         AS name,\n"
					+ "  s.class_id     AS class_id,\n"
					+ "  s.mail_address AS email\n"
					+ "FROM student s\n"
					+ "ORDER BY \n"
					+ "  s.student_id;";
			PreparedStatement pStmt = con.prepareStatement(sql);

			ResultSet rs = pStmt.executeQuery();
			while (rs.next()) {
				int studentId = rs.getInt("student_id");
				String name = rs.getString("name");
				int classId = rs.getInt("class_id");
				String email = rs.getString("email");
				StudentBeans student = new StudentBeans(studentId, name, classId, email);
				studentList.add(student);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}

		return studentList;
	}

	public boolean create(StudentBeans student) {
		System.out.println("=== StudentDao.create() 開始 ===");
		System.out.println("入力データ: " + student);
		
		Connection conn = null;
		try {
			Class.forName("org.h2.Driver");
			System.out.println("H2ドライバー読み込み成功");
		} catch (ClassNotFoundException e) {
			System.out.println("H2ドライバー読み込み失敗: " + e.getMessage());
			throw new IllegalStateException("JDBCドライバを読み込めませんでした。H2ドライバーをWEB-INF/libに配置してください。");
		}

		try {
			conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
			// 自動コミットを無効にして、明示的にトランザクションを管理
			conn.setAutoCommit(false);
			System.out.println("データベース接続成功（自動コミット無効）");
			
			String sql = "INSERT INTO student(STUDENT_ID, NAME, CLASS_ID, MAIL_ADDRESS) VALUES(?, ?, ?, ?)";
			System.out.println("実行SQL: " + sql);
			PreparedStatement pStmt = conn.prepareStatement(sql);

			pStmt.setInt(1, student.getStudentId());
			pStmt.setString(2, student.getName());
			pStmt.setInt(3, student.getClassId());
			pStmt.setString(4, student.getEmail());
			
			System.out.println("パラメータ設定完了:");
			System.out.println("  STUDENT_ID: " + student.getStudentId());
			System.out.println("  NAME: " + student.getName());
			System.out.println("  CLASS_ID: " + student.getClassId());
			System.out.println("  MAIL_ADDRESS: " + student.getEmail());

			int result = pStmt.executeUpdate();
			System.out.println("SQL実行結果: " + result + "行が更新されました");
			
			// 明示的にコミット
			conn.commit();
			System.out.println("トランザクションをコミットしました");
			
			boolean success = result == 1;
			System.out.println("登録成功判定: " + success);
			return success;
		} catch (SQLException e) {
			System.out.println("SQLException発生: " + e.getMessage());
			System.out.println("SQLState: " + e.getSQLState());
			System.out.println("ErrorCode: " + e.getErrorCode());
			
			// エラーが発生した場合はロールバック
			if (conn != null) {
				try {
					conn.rollback();
					System.out.println("トランザクションをロールバックしました");
				} catch (SQLException rollbackEx) {
					System.out.println("ロールバックエラー: " + rollbackEx.getMessage());
				}
			}
			
			e.printStackTrace();
			return false;
		} catch (Exception e) {
			System.out.println("予期しないエラー: " + e.getMessage());
			
			// エラーが発生した場合はロールバック
			if (conn != null) {
				try {
					conn.rollback();
					System.out.println("トランザクションをロールバックしました");
				} catch (SQLException rollbackEx) {
					System.out.println("ロールバックエラー: " + rollbackEx.getMessage());
				}
			}
			
			e.printStackTrace();
			return false;
		} finally {
			if (conn != null) {
				try {
					// 自動コミットを元に戻す
					conn.setAutoCommit(true);
					conn.close();
					System.out.println("データベース接続をクローズしました");
				} catch (SQLException e) {
					System.out.println("接続クローズエラー: " + e.getMessage());
				}
			}
			System.out.println("=== StudentDao.create() 終了 ===");
		}
	}
}