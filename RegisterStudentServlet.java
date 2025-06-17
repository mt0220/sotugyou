package Servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import DAO.StudentDao;
import Model.StudentBeans;

public class RegisterStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StudentDao studentDao;

    @Override
    public void init() throws ServletException {
        super.init();
        studentDao = new StudentDao();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // すべてのindexを調べてリスト化
        List<StudentBeans> studentList = new ArrayList<>();
        int max = 0;
        int maxRows = 100; // 最大行数を制限

        System.out.println("=== データ収集開始 ===");

        // まず、実際にデータが入力されている行数を確認
        int actualRowCount = 0;
        for (int i = 0; i < maxRows; i++) {
            String sid = request.getParameter("students[" + i + "].studentId");
            String name = request.getParameter("students[" + i + "].name");
            String classId = request.getParameter("students[" + i + "].classId");
            String email = request.getParameter("students[" + i + "].email");

            if (sid != null && !sid.trim().isEmpty() &&
                name != null && !name.trim().isEmpty() &&
                classId != null && !classId.trim().isEmpty() &&
                email != null && !email.trim().isEmpty()) {
                actualRowCount = i + 1;
            }
        }

        System.out.println("実際にデータが入力されている行数: " + actualRowCount);

        // データが入力されている行のみを処理
        for (int i = 0; i < actualRowCount; i++) {
            String sid = request.getParameter("students[" + i + "].studentId");
            String name = request.getParameter("students[" + i + "].name");
            String classId = request.getParameter("students[" + i + "].classId");
            String email = request.getParameter("students[" + i + "].email");

            System.out.println("=== 学生" + i + "のデータ ===");
            System.out.println("studentId: " + sid);
            System.out.println("name: " + name);
            System.out.println("classId: " + classId);
            System.out.println("email: " + email);

            if (sid != null && !sid.trim().isEmpty() &&
                name != null && !name.trim().isEmpty() &&
                classId != null && !classId.trim().isEmpty() &&
                email != null && !email.trim().isEmpty()) {
                try {
                    int studentId = Integer.parseInt(sid.trim());
                    int classIdInt = Integer.parseInt(classId.trim());
                    StudentBeans st = new StudentBeans(studentId, name.trim(), classIdInt, email.trim());
                    studentList.add(st);
                    System.out.println("学生" + i + "をリストに追加: " + st);
                } catch (NumberFormatException e) {
                    System.out.println("学生" + i + "のデータ形式エラー: " + e.getMessage());
                }
            } else {
                System.out.println("学生" + i + "のデータが不完全または空");
            }
        }

        System.out.println("=== 処理対象の学生数: " + studentList.size() + " ===");

        int successCount = 0;
        int failCount = 0;
        for (StudentBeans st : studentList) {
            if (st.isValid() && studentDao.create(st)) {
                successCount++;
            } else {
                failCount++;
            }
        }

        request.setAttribute("successCount", successCount);
        request.setAttribute("failCount", failCount);
        request.setAttribute("totalCount", studentList.size());
        request.getRequestDispatcher("registerResult.jsp").forward(request, response);
    }
} 