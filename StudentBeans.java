package Model;

import java.io.Serializable;

public class StudentBeans implements Serializable {
	private int studentId;
	private String name;
	private int classId;
	private String email;

	public StudentBeans() {}

	// フィールドをすべて受け取るコンストラクタ
	public StudentBeans(int studentId, String name, int classId, String email) {
		this.studentId = studentId;
		this.name = name;
		this.classId = classId;
		this.email = email;
	}

	// STUDENT_IDなしのコンストラクタ（新規登録用）
	public StudentBeans(String name, int classId, String email) {
		this.name = name;
		this.classId = classId;
		this.email = email;
	}

	// getter
	public int getStudentId() {
		return studentId;
	}

	public String getName() {
		return name;
	}

	public int getClassId() {
		return classId;
	}

	public String getEmail() {
		return email;
	}

	// setter
	public void setStudentId(int studentId) {
		this.studentId = studentId;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setClassId(int classId) {
		this.classId = classId;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	// バリデーションメソッド
	public boolean isValid() {
		return studentId > 0 && 
			   name != null && !name.trim().isEmpty() && 
			   classId > 0 &&
			   email != null && email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");
	}

	@Override
	public String toString() {
		return "StudentBeans [studentId=" + studentId + ", name=" + name + ", classId=" + classId + ", email=" + email + "]";
	}
}