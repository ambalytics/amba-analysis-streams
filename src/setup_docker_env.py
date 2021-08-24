from ruamel import yaml

configFile = 'config.yaml'
# this is supposed to make easier yaml for configuration, not in use yes

def load():
    with open(configFile) as fp:
        config_data_raw = fp.read()
    config_data = yaml.load(config_data_raw, Loader=yaml.RoundTripLoader)
    return config_data


def create_env_string(config_data):
    for d in config_data:
        create_env_var_string(d, config_data[d])


def create_env_var_string(key, value):
    # DB_NAME=dbase
    return key.upper() + "=" + value + "\n"


def myprint(d, s):
    result = []
    for k, v in d.items():
        if isinstance(v, dict):
            result.extend(myprint(v, s + k + "_"))
        else:
            result.append("{0} : {1}".format(s + k, v))
    return result

if __name__ == '__main__':
    config = load()
    print(myprint(config, ""))
    # print(config['states_relation_type_topics'])
    # print(config['network'])
    # print(config['mongo_db'])
