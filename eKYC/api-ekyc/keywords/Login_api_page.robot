***Settings***
Library                 ExcelLibrary
Library                 OperatingSystem
Library                 BuiltIn
Resource            ../Varriable/varriable.robot
Resource            ../Varriable/Tablet_varriable.robot


***Keywords***
Login_Get_Token
    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE}
    # ${body}=        To Json         {"username": "EKYC003", "password": "P@ssw0rd", "partner_code": "TCRB-TABLET"}
    &{body}=      Create dictionary     username=EKYC003     password=P@ssw0rd     partner_code=TCRB-TABLET
    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_LOGIN}   headers=&{HEADER_LOGIN}    json=${body}
    Request Should Be Successful    response=${response}
    Should Be Equal     ${response.json()["status"]["message"]}                       ${RESPONSE_MESSAGE_SUCCESS}
    Set global variable     ${LOGIN_IDTOKEN}              ${response.json()["data"]["id_token"]}             

