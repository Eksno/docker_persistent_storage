from app import app
from flask import render_template


@app.route("/")
@app.route("/home")
def home():

    with open('/data/home.txt') as f:
        text = ''.join(f.readlines())

    return render_template("home.html", text=text)
