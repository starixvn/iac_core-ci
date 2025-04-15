#!/usr/bin/env python3
"""
Validate pipeline configuration and trigger conditions
"""
import json
import os
import sys
from pathlib import Path

def check_required_vars():
    required_vars = {
        'IAC_PROJECT_ID': str,
        'EAC_PROJECT_ID': str,
        'TF_STATE_BUCKET': str
    }
    
    missing = []
    for var, var_type in required_vars.items():
        if var not in os.environ or not isinstance(os.environ[var], var_type):
            missing.append(var)
    
    if missing:
        raise ValueError(f"Missing required variables: {missing}")

def validate_trigger_rules():
    ci_file = Path(".gitlab-ci.yml")
    if not ci_file.exists():
        raise FileNotFoundError("Missing .gitlab-ci.yml")
    
    with open(ci_file) as f:
        content = f.read()
        if "trigger:iac" not in content or "trigger:eac" not in content:
            raise SyntaxError("Missing trigger jobs")

if __name__ == "__main__":
    try:
        check_required_vars()
        validate_trigger_rules()
        
        result = {
            "status": "success",
            "checks": {
                "variables": "passed",
                "trigger_rules": "passed"
            }
        }
    except Exception as e:
        result = {
            "status": "failed",
            "error": str(e)
        }
        sys.exit(1)
    finally:
        with open("validation_report.json", "w") as f:
            json.dump(result, f, indent=2)
        print(json.dumps(result, indent=2))