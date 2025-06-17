<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登録結果</title>
    <link rel="stylesheet" href="Student.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .result-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            text-align: center;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        
        .success {
            background-color: #e8f5e8;
            border: 2px solid #66bb6a;
        }
        
        .error {
            background-color: #ffebee;
            border: 2px solid #ef5350;
        }
        
        .message {
            font-size: 18px;
            margin: 20px 0;
            font-weight: 500;
        }
        
        .back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            transition: background-color 0.3s ease;
        }
        
        .back-link:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="result-container ${success ? 'success' : 'error'}">
        <h2>
            <i class="fas ${success ? 'fa-check-circle' : 'fa-exclamation-triangle'}"></i>
            登録結果
        </h2>
        <div class="result-message">${message}</div>
        <div class="result-buttons">
            <a href="studentRegistration.jsp" class="result-btn">
                <i class="fas fa-user-plus"></i> 学生登録ページへ
            </a>
            <a href="main.jsp" class="result-btn secondary">
                <i class="fas fa-home"></i> メインメニューに戻る
            </a>
        </div>
    </div>
</body>
</html> 