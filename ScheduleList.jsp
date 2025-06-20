<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import= "java.util.Date, java.text.SimpleDateFormat" %>
<%@ page import="java.util.*, java.text.*" %>

<%
		Date now = new Date();
		SimpleDateFormat strDate = new SimpleDateFormat("MM'月'dd'日'");
		SimpleDateFormat year = new SimpleDateFormat("yyyy'年'");
		String nowYear = year.format(now);

		// 1. パラメータ取得
		String baseDateString = request.getParameter("baseDate");
		String move = request.getParameter("move");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date baseDate;

		// 2. 基準日を決定
		if (baseDateString == null || baseDateString.isEmpty()) {
			baseDate = new Date(); // 今日
		} else {
			baseDate = sdf.parse(baseDateString);
		}

		// 3. moveパラメータで±7日
		Calendar cal = Calendar.getInstance();
		cal.setTime(baseDate);
		if ("prev".equals(move)) {
			cal.add(Calendar.DATE, -7);
		} else if ("next".equals(move)) {
			cal.add(Calendar.DATE, 7);
		}
		baseDate = cal.getTime(); // 新しい基準日
		baseDateString = sdf.format(baseDate);

		// 4. 週の月曜を求める
		cal.setTime(baseDate);
		cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

		// 5. 週の日付配列を作る
		String[] weekDates = new String[7];
		for (int i = 0; i < 7; i++) {
			weekDates[i] = strDate.format(cal.getTime());
			cal.add(Calendar.DATE, 1);
		}
%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>時間割一覧</title>
    <link rel="stylesheet" href="Student.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="header-content">
                <div class="logo">
                    <i class="fas fa-graduation-cap"></i>
                    <h1>時間割一覧</h1>
                </div>
                <div class="header-subtitle">
                   
                </div>
            </div>
        </div>
        
        <div class="main-content">
            <div class="menu-grid">
                <div class="menu-card">
                    <div class="card-icon">
                        <i class="fas fa-calendar-check"></i>                       
                       
                    </div>
                    <div class="card-content" border="1">
                         <h2 ><%= nowYear %></h2>
                        	<table class="schedule-table">
								<tr class="schedule-header">
								<form method="get" style="display:inline;">
     							<input type="hidden" name="baseDate" value="<%= baseDateString %>">
     							<button type="submit" name="move" value="prev" class="schedule-nav-btn">
     								<i class="fas fa-chevron-left"></i> 前週
     							</button>
     							<button type="submit" name="move" value="next" class="schedule-nav-btn">
     								次週 <i class="fas fa-chevron-right"></i>
     							</button>
   								</form>
   								<br>
									<th></th>
									<th><%= weekDates[0] %></th>
									<th><%= weekDates[1] %></th>
									<th><%= weekDates[2] %></th>
									<th><%= weekDates[3] %></th>
									<th><%= weekDates[4] %></th>
									<th><%= weekDates[5] %></th>
									<th><%= weekDates[6] %></th>
									
								</tr>
								<tr class="schedule-days">
									<th></th>
									<th>月</th>
									<th>火</th>
									<th>水</th>
									<th>木</th>
									<th>金</th>
									<th>土</th>
									<th>日</th>
								</tr>
								<tr>
									<th>１限目</th>
									<td class="schedule-cell"></td>
									<td class="schedule-cell"></td>
									<td class="schedule-cell"></td>
									<td class="schedule-cell"></td>
									<td class="schedule-cell"></td>
									<td class="schedule-cell"></td>
									<td class="schedule-cell"></td>
								</tr>
								<tr>
									<th>２限目</th>
									<td class="schedule-cell"></td>
									<td class="schedule-cell"></td>
									<td class="schedule-cell"></td>
									<td class="schedule-cell"></td>
									<td class="schedule-cell"></td>
									<td class="schedule-cell"></td>
									<td class="schedule-cell"></td>
								</tr>
								<tr>
									<th>３限目</th>
									<td class="schedule-cell"></td>
									<td class="schedule-cell"></td>
									<td class="schedule-cell"></td>
									<td class="schedule-cell"></td>
									<td class="schedule-cell"></td>
									<td class="schedule-cell"></td>
									<td class="schedule-cell"></td>
								</tr>
								<tr>
									<th>４限目</th>
									<td class="schedule-cell"></td>
									<td class="schedule-cell"></td>
									<td class="schedule-cell"></td>
									<td class="schedule-cell"></td>
									<td class="schedule-cell"></td>
									<td class="schedule-cell"></td>
									<td class="schedule-cell"></td>
								</tr>
                        </table>
                </div>
        
    </div>
    
</body>
</html>
 