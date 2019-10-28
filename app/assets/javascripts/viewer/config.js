const CONFIG = {}
CONFIG.OBJECTS_NUMBER = 100

switch (location.origin) {
    case 'https://bullseye.ctf.codeblue.jp':
        CONFIG.API_BASE = '/external_api/v1/viewer'
        break
    default:
        CONFIG.API_BASE = 'http://e72e7b2cfe3d888d7a03f52f.codeblue.ohcihsiek.jp/external_api/v1/viewer'
        break
}
