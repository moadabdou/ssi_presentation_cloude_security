``` bash 

# apply main_v1.tf (inexperienced code with misconfigurations)
tflocal init 
tflocal apply -auto-approve 

# scan with Trivy to find misconfigurations
trivy config .    
``` 