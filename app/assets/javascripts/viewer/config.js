const CONFIG = {}
CONFIG.OBJECTS_NUMBER = 100

switch (location.origin) {
    case 'http://172.16.91.128:3000':
        CONFIG.API_BASE = 'http://172.e72e7b2cfe3d888d7a03.codeblue.ohcihsiek.jp/external_api/v1/viewer'
        break
    case 'http://192.168.246.129:3000':
        CONFIG.API_BASE = 'http://192.e72e7b2cfe3d888d7a03.codeblue.ohcihsiek.jp/external_api/v1/viewer'
        //CONFIG.API_BASE = 'http://bullseye.demo.ohcihsiek.jp/api'
        break
    default:
        CONFIG.API_BASE = '/external_api/v1/viewer'
        break
}
