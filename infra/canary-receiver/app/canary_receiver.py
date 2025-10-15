#!/usr/bin/env python3
from flask import Flask, request, jsonify
from datetime import datetime
import os, json

app = Flask(__name__)
LOG_DIR = os.environ.get("CANARY_LOG_DIR", "./logs")
os.makedirs(LOG_DIR, exist_ok=True)
LOGFILE = os.path.join(LOG_DIR, "canary_hits.log")

@app.route("/api/health", methods=["GET"])
def health():
    return jsonify({"status": "ok"}), 200

@app.route("/beacon", methods=["GET", "POST"])
def beacon():
    # Accept JSON or form-encoded
    data = request.get_json(silent=True) or request.form.to_dict() or {}
    entry = {
        "time": datetime.utcnow().isoformat() + "Z",
        "remote_addr": request.headers.get("X-Forwarded-For", request.remote_addr),
        "user_agent": request.headers.get("User-Agent", ""),
        "data": data
    }
    with open(LOGFILE, "a") as f:
        f.write(json.dumps(entry) + "\n")
    return jsonify({"status": "ok"}), 200

@app.route("/api/coin", methods=["GET","POST"])
def coin():
    if request.method == "POST":
        data = request.get_json(silent=True) or request.form.to_dict() or {}
        entry = {
            "time": datetime.utcnow().isoformat() + "Z",
            "remote_addr": request.remote_addr,
            "data": data
        }
        with open(LOGFILE, "a") as f:
            f.write(json.dumps(entry) + "\n")
        return jsonify({"status":"ok","received":entry}), 200
    else:
        return jsonify({"status":"coin endpoint alive"}), 200

if __name__ == "__main__":
    app.run(host=os.environ.get("CANARY_BIND", "127.0.0.1"),
            port=int(os.environ.get("CANARY_PORT", "5000")))
