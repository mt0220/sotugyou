package Model;

import java.io.Serializable;

public class Student implements Serializable {
	private int studentId;
	private String name;
	private String sClass;

	// デフォルトコンストラクタ
	public Student() {}

	// フィールドをすべて受け取るコンストラクタ
	public Student(int studentId, String name, String sClass) {
		this.studentId = studentId;
		this.name = name;
		this.sClass = sClass;
	}

	// getter（JavaBeans規約に従ってキャメルケース）
	public int getStudentId() {
		return studentId;
	}

	public String getName() {
		return name;
	}

	public String getSClass() {
		return sClass;
	}

	// setter（必要であれば追加）
	public void setStudentId(int studentId) {
		this.studentId = studentId;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setSClass(String sClass) {
		this.sClass = sClass;
	}
}
