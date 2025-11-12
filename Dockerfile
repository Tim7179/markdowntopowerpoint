# 1. 基礎映像
# 我們使用一個精簡的 Python 3.11 映像
FROM python:3.11-slim

# 2. 設定環境變數
# ENV PYTHONDONTWRITEBYTECODE 1
# 確保 Python 將 stdout/stderr 直接發送到終端機，不會緩存
ENV PYTHONUNBUFFERED 1
# Cloud Run 會自動注入 $PORT，預設為 8080
ENV PORT 8080

# 3. 設定工作目錄
WORKDIR /app

# 4. 安裝依賴套件
# 僅複製 requirements.txt 以便利用 Docker 的層快取
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. 複製應用程式程式碼和模板
# 將您的所有程式碼和 PowerPoint 模板複製到映像中
COPY . .

# 6. 執行命令 (Entrypoint)
# 使用 Gunicorn 啟動應用程式。
# Gunicorn 是一個生產環境級別的 WSGI 伺服器。
# --bind :$PORT 告訴 Gunicorn 監聽 $PORT 變數指定的埠口
# --workers 4 啟動 4 個工作進程 (您可以根據需求調整)
# app:app 指的是 app.py 檔案中的 app 物件
CMD exec gunicorn --bind :$PORT --workers 4 app:app