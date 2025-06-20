<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DAO.StudentDao" %>
<%@ page import="Model.StudentBeans" %>
<%@ page import="java.sql.SQLException" %>

<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/plain; charset=UTF-8");

// リクエストパラメータの取得
String sid = request.getParameter("studentId");
String name = request.getParameter("name");
String classId = request.getParameter("classId");
String email = request.getParameter("email");

System.out.println("=== 単一学生データ受信 ===");
System.out.println("studentId: " + sid);
System.out.println("name: " + name);
System.out.println("classId: " + classId);
System.out.println("email: " + email);

String resultMessage = "";

if (sid != null && !sid.trim().isEmpty() &&
    name != null && !name.trim().isEmpty() &&
    classId != null && !classId.trim().isEmpty() &&
    email != null && !email.trim().isEmpty()) {

    try {
        int studentId = Integer.parseInt(sid.trim());
        int classIdInt = Integer.parseInt(classId.trim());
        StudentBeans student = new StudentBeans(studentId, name.trim(), classIdInt, email.trim());

        StudentDao studentDao = new StudentDao();
        if (studentDao.create(student)) {
            resultMessage = "学生ID: " + studentId + " の登録に成功しました。";
            response.setStatus(HttpServletResponse.SC_OK); // 成功ステータスコード
        } else {
            resultMessage = "学生ID: " + studentId + " の登録に失敗しました。(データベースエラーまたは重複)";
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 失敗ステータスコード
        }
    } catch (NumberFormatException e) {
        resultMessage = "データ形式エラー: 学生IDまたはクラスIDが不正です。 " + e.getMessage();
        System.err.println("NumberFormatException: " + e.getMessage());
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 不正なリクエスト
    } catch (Exception e) {
        resultMessage = "予期せぬエラーが発生しました: " + e.getMessage();
        System.err.println("Unexpected Exception: " + e.getMessage());
        e.printStackTrace();
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // サーバーエラー
    }
} else {
    resultMessage = "入力項目が不完全です。全ての項目を入力してください。";
    response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 不正なリクエスト
}

out.print(resultMessage);
%> 