# This program compares the list of roles output by the Couchbase Server
# /settings/rbac/roles endpoint (by calling the server runnning on localhost) 
# to the content of the roles.adoc file. 

#  It reports any deltas between the two.


import re
import requests


def load_roles_from_rbac():
    """Fetch roles from Couchbase RBAC REST API."""
    url = "http://localhost:8091/settings/rbac/roles"
    auth = ("Administrator", "password")  # Update with actual credentials
    
    response = requests.get(url, auth=auth)
    response.raise_for_status()
    
    roles = response.json()
    return {role['role'] for role in roles}

def extract_roles_from_asciidoc(asciidoc_file):
    """Extract roles from roles.adoc based on the given pattern."""
    pattern = re.compile(r'\|\s*Role:.*?\(`(.*?)`\)')
    extracted_roles = set()
    
    with open(asciidoc_file, 'r', encoding='utf-8') as f:
        for line in f:
            match = pattern.search(line)
            if match:
                extracted_roles.add(match.group(1))
    
    return extracted_roles

def generate_report(json_roles, asciidoc_roles):
    """Generate a report showing discrepancies between the two lists."""
    missing_in_asciidoc = json_roles - asciidoc_roles
    missing_in_json = asciidoc_roles - json_roles
    
    report = """
Roles in RBAC but NOT in roles.adoc:
------------------------------------------------
{}

Roles in roles.adoc but NOT in RBAC:
------------------------------------------------
{}
""".format("\n".join(sorted(missing_in_asciidoc)), "\n".join(sorted(missing_in_json)))
    
    return report

def main():
    asciidoc_file = "../../pages/security/roles.adoc"
    
    rbac_roles = load_roles_from_rbac()
    asciidoc_roles = extract_roles_from_asciidoc(asciidoc_file)
    
    report = generate_report(rbac_roles, asciidoc_roles)
    
    print(report)
    
if __name__ == "__main__":
    main()
