from flask import Flask
from ppt_gen import ppt_gen_bp
import os

# from ddg_search import ddg_search_bp

app = Flask(__name__)

# 註冊 Blueprint
app.register_blueprint(ppt_gen_bp)
# app.register_blueprint(ddg_search_bp)

# 為了讓 Gunicorn 和 Cloud Run 能夠運行，
# 我們移除了 'if __name__ == "__main__":' 區塊。
# Gunicorn 會直接尋找 'app' 這個 Flask 實例。