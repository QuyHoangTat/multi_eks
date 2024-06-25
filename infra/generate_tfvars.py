import yaml

with open('values.yaml', 'r') as file:
    values = yaml.safe_load(file)

for env, config in values['environments'].items():
    with open(f'{env}.tfvars', 'w') as file:
        for key, value in config.items():
            if isinstance(value, list):
                value = str(value).replace("'", '"')  # Chuyển list thành chuỗi JSON
            else:
                value = f'"{value}"' 
            file.write(f'{key} = {value}\n')
