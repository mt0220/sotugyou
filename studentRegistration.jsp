<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>学生登録</title>
    <link rel="stylesheet" href="Student.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .delete-btn {
            color: #e74c3c;
            font-size: 20px;
            background: none;
            border: none;
            cursor: pointer;
            transition: color 0.2s;
        }
        .delete-btn:hover {
            color: #c0392b;
        }
        .add-btn {
            margin: 15px 0;
            padding: 8px 18px;
            font-size: 15px;
            background: #fff;
            border: 1px solid #333;
            border-radius: 4px;
            cursor: pointer;
            transition: background 0.2s;
        }
        .add-btn:hover {
            background: #f8f9fa;
        }
    </style>
</head>
<body>
    <div class="registration-container">
        <div class="registration-header">
            <h1><i class="fas fa-user-plus"></i> 学生登録</h1>
            <p>新しい学生の情報を入力して登録してください</p>
        </div>
        
        <div class="registration-form">
            <form action="#" method="post" id="multiForm">
                <table class="registration-table" id="studentTable">
                    <thead>
                        <tr>
                            <th><i class="fas fa-id-card"></i> 学生ID</th>
                            <th><i class="fas fa-user"></i> 名前</th>
                            <th><i class="fas fa-graduation-cap"></i> クラス</th>
                            <th><i class="fas fa-envelope"></i> メールアドレス</th>
                            <th><i class="fas fa-save"></i> 登録</th>
                            <th><i class="fas fa-trash"></i> 削除</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                        <tr>
                            <td><input type="number" name="studentId" required placeholder="例: 1" onchange="checkDuplicateStudentId(this)"></td>
                            <td><input type="text" name="name" required placeholder="例: 山田太郎"></td>
                            <td>
                                <select name="classId" required>
                                    <option value="">選択してください</option>
                                    <option value="1">R1A1</option>
                                    <option value="2">R1A2</option>
                                    <option value="3">R2A1</option>
                                    <option value="4">R2A2</option>
                                    <option value="5">R3A1</option>
                                    <option value="6">R4A1</option>
                                </select>
                            </td>
                            <td><input type="email" name="email" required placeholder="例: taro@example.com"></td>
                            <td><button type="button" class="register-btn" onclick="registerStudent(this)"><i class="fas fa-check"></i> 登録</button></td>
                            <td><button type="button" class="delete-btn" onclick="deleteRow(this)"><i class="fas fa-times"></i></button></td>
                        </tr>
                    </tbody>
                </table>
                <button type="button" class="add-row-btn" onclick="addRow()"><i class="fas fa-plus"></i> 行を追加</button>
            </form>
        </div>
        
        <div class="button-container" style="text-align: center; margin-top: 30px;">
            <a href="main.jsp" class="result-btn secondary"><i class="fas fa-home"></i> メインメニューに戻る</a>
        </div>
    </div>

    <script>
    function addRow() {
        const tableBody = document.getElementById('tableBody');
        const rowCount = tableBody.rows.length;
        console.log('=== 行追加処理 ===');
        console.log('現在の行数: ' + rowCount);
        
        const row = tableBody.insertRow();
        row.innerHTML = `
            <td><input type="number" name="studentId" required placeholder="例: ${rowCount+1}" onchange="checkDuplicateStudentId(this)"></td>
            <td><input type="text" name="name" required placeholder="例: 田中花子"></td>
            <td>
                <select name="classId" required>
                    <option value="">選択してください</option>
                    <option value="1">R1A1</option>
                    <option value="2">R1A2</option>
                    <option value="3">R2A1</option>
                    <option value="4">R2A2</option>
                    <option value="5">R3A1</option>
                    <option value="6">R4A1</option>
                </select>
            </td>
            <td><input type="email" name="email" required placeholder="例: hanako@example.com"></td>
            <td><button type="button" class="register-btn" onclick="registerStudent(this)"><i class="fas fa-check"></i> 登録</button></td>
            <td><button type="button" class="delete-btn" onclick="deleteRow(this)"><i class="fas fa-times"></i></button></td>
        `;
        
        console.log('行追加完了。新しい行数: ' + tableBody.rows.length);
        console.log('追加された行のHTML:', row.innerHTML);
    }
    
    function deleteRow(btn) {
        const row = btn.closest('tr');
        row.parentNode.removeChild(row);
        // name属性のindexを振り直す必要はなくなったが、既存のコードは維持
        const rows = document.querySelectorAll('#tableBody tr');
        rows.forEach((tr, idx) => {
            tr.querySelectorAll('input, select').forEach(input => {
                // name属性から`students[${idx}].`を削除する
                if (input.name.includes('students[')) {
                    const key = input.name.split('.').pop();
                    input.name = `${key}`;
                }
            });
        });
        // 削除後に重複チェックを再実行
        checkAllDuplicateStudentIds();
    }
    
    // 個別登録関数
    async function registerStudent(btn) {
        const row = btn.closest('tr');
        const studentIdInput = row.querySelector('input[name="studentId"]');
        const nameInput = row.querySelector('input[name="name"]');
        const classIdInput = row.querySelector('select[name="classId"]');
        const emailInput = row.querySelector('input[name="email"]');

        // 個別バリデーション
        if (!studentIdInput.value || !nameInput.value || !classIdInput.value || !emailInput.value) {
            alert('すべての項目を入力してください。');
            return;
        }

        // 重複チェック (今回はフロントエンドでのみ実施)
        checkDuplicateStudentId(studentIdInput); // リアルタイムチェックは既存機能として維持

        // ボタンを無効化してローディング状態に
        const registerBtn = btn;
        const originalText = registerBtn.innerHTML;
        registerBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 登録中...';
        registerBtn.disabled = true;

        // フォームデータを作成
        const formData = new FormData();
        formData.append('studentId', studentIdInput.value);
        formData.append('name', nameInput.value);
        formData.append('classId', classIdInput.value);
        formData.append('email', emailInput.value);

        try {
            const response = await fetch('RegisterMultiStudent.jsp', {
                method: 'POST',
                body: new URLSearchParams(formData) // FormDataをURLSearchParamsに変換して送信
            });

            const resultText = await response.text(); // レスポンスをテキストとして取得

            // 登録結果をユーザーにフィードバック
            if (response.ok) {
                console.log('登録成功:', resultText);
                
                // 成功時の視覚的フィードバック
                row.style.backgroundColor = '#e8f5e8';
                row.style.borderLeft = '4px solid #27ae60';
                
                // 入力フィールドを無効化
                studentIdInput.disabled = true;
                nameInput.disabled = true;
                classIdInput.disabled = true;
                emailInput.disabled = true;
                
                // ボタンを成功状態に変更
                registerBtn.innerHTML = '<i class="fas fa-check"></i> 登録済み';
                registerBtn.style.background = 'linear-gradient(135deg, #27ae60 0%, #229954 100%)';
                registerBtn.disabled = true;
                
                // 3秒後に元の色に戻す
                setTimeout(() => {
                    row.style.backgroundColor = '';
                    row.style.borderLeft = '';
                }, 3000);
                
            } else {
                console.error('登録失敗:', resultText);
                
                // 失敗時の視覚的フィードバック
                row.style.backgroundColor = '#ffebee';
                row.style.borderLeft = '4px solid #e74c3c';
                
                // ボタンを元に戻す
                registerBtn.innerHTML = originalText;
                registerBtn.disabled = false;
                
                // 3秒後に元の色に戻す
                setTimeout(() => {
                    row.style.backgroundColor = '';
                    row.style.borderLeft = '';
                }, 3000);
            }
        } catch (error) {
            console.error('Fetch error:', error);
            
            // エラー時の視覚的フィードバック
            row.style.backgroundColor = '#ffebee';
            row.style.borderLeft = '4px solid #e74c3c';
            
            // ボタンを元に戻す
            registerBtn.innerHTML = originalText;
            registerBtn.disabled = false;
            
            // 3秒後に元の色に戻す
            setTimeout(() => {
                row.style.backgroundColor = '';
                row.style.borderLeft = '';
            }, 3000);
        }
    }

    // 以下の関数はまとめて登録時ではなく、リアルタイムの重複チェックのみに利用
    function checkDuplicateStudentId(input) {
        const studentId = input.value;
        if (!studentId) return;
        
        const inputs = document.querySelectorAll('input[name="studentId"]'); // name属性を変更
        let duplicateCount = 0;
        
        inputs.forEach(otherInput => {
            if (otherInput.value === studentId) {
                duplicateCount++;
            }
        });
        
        if (duplicateCount > 1) {
            input.style.borderColor = '#e74c3c';
            input.style.backgroundColor = '#ffebee';
            showError(input, 'この学生IDは重複しています');
        } else {
            input.style.borderColor = '';
            input.style.backgroundColor = '';
            hideError(input);
        }
    }
    
    function checkAllDuplicateStudentIds() {
        const inputs = document.querySelectorAll('input[name="studentId"]'); // name属性を変更
        inputs.forEach(input => {
            checkDuplicateStudentId(input);
        });
    }
    
    function showError(input, message) {
        // 既存のエラーメッセージを削除
        hideError(input);
        
        const errorDiv = document.createElement('div');
        errorDiv.className = 'error-message';
        errorDiv.textContent = message;
        
        input.parentNode.appendChild(errorDiv);
    }
    
    function hideError(input) {
        const errorDiv = input.parentNode.querySelector('.error-message');
        if (errorDiv) {
            errorDiv.remove();
        }
    }
    
    // 初期行にも重複チェックを追加
    document.addEventListener('DOMContentLoaded', function() {
        const initialInput = document.querySelector('input[name="studentId"]');
        if (initialInput) {
            initialInput.addEventListener('change', function() {
                checkDuplicateStudentId(this);
            });
        }
    });
    </script>
</body>
</html>
 