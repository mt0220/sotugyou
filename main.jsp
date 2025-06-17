<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>出欠管理システム - メインメニュー</title>
    <link rel="stylesheet" href="Student.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="header-content">
                <div class="logo">
                    <i class="fas fa-graduation-cap"></i>
                    <h1>出欠管理システム</h1>
                </div>
                <div class="header-subtitle">
                    <p>学生の出欠状況を効率的に管理</p>
                </div>
            </div>
        </div>
        
        <div class="main-content">
            <div class="menu-grid">
                <div class="menu-card">
                    <div class="card-icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <div class="card-content">
                        <h3>出欠管理</h3>
                        <p>学生の出欠状況を記録・確認</p>
                        <a href="studentRegistration.jsp" class="card-button">
                            <i class="fas fa-arrow-right"></i>
                            開始する
                        </a>
                    </div>
                </div>
                
                <div class="menu-card">
                    <div class="card-icon">
                        <i class="fas fa-user-plus"></i>
                    </div>
                    <div class="card-content">
                        <h3>新規学生登録</h3>
                        <p>新しい学生をシステムに登録</p>
                        <a href="studentRegistration.jsp" class="card-button">
                            <i class="fas fa-arrow-right"></i>
                            登録する
                        </a>
                    </div>
                </div>
                
                <div class="menu-card">
                    <div class="card-icon">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="card-content">
                        <h3>時間割登録</h3>
                        <p>授業の時間割を設定・管理</p>
                        <a href="studentRegistration.jsp" class="card-button">
                            <i class="fas fa-arrow-right"></i>
                            設定する
                        </a>
                    </div>
                </div>
                
                <div class="menu-card">
                    <div class="card-icon">
                        <i class="fas fa-chart-bar"></i>
                    </div>
                    <div class="card-content">
                        <h3>統計・レポート</h3>
                        <p>出欠データの分析・レポート</p>
                        <a href="studentRegistration.jsp" class="card-button">
                            <i class="fas fa-arrow-right"></i>
                            確認する
                        </a>
                    </div>
                </div>
                
                <div class="menu-card">
                    <div class="card-icon">
                        <i class="fas fa-cog"></i>
                    </div>
                    <div class="card-content">
                        <h3>システム設定</h3>
                        <p>システムの各種設定</p>
                        <a href="studentRegistration.jsp" class="card-button">
                            <i class="fas fa-arrow-right"></i>
                            設定する
                        </a>
                    </div>
                </div>
                
                <div class="menu-card logout-card">
                    <div class="card-icon">
                        <i class="fas fa-sign-out-alt"></i>
                    </div>
                    <div class="card-content">
                        <h3>ログアウト</h3>
                        <p>システムから安全にログアウト</p>
                        <a href="studentRegistration.jsp" class="card-button logout-button">
                            <i class="fas fa-sign-out-alt"></i>
                            ログアウト
                        </a>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="footer">
            <p>&copy; 2024 出欠管理システム. All rights reserved.</p>
        </div>
    </div>
</body>
</html>
 