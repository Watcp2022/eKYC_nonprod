*** Settings ***
Library             RequestsLibrary
Library             Collections
Library             JSONLibrary
# Resource            ../Varriable/varriable.robot
# Resource            ../keywords/Get_data_excel.robot
# Resource            ../Keywords/Encrypt_page.robot
# Resource		    ../Varriable/img.robot
# Resource            ../Keywords/Get_status_error.robot
Resource            ../Varriable/Tablet_varriable.robot



***Keywords***
Have_Twin
    Set To Dictionary       ${HEADER_TWIN}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_TWIN}
    Create Session          alias=${ALIAS}      url=${URL_CORE_SERVICE} 

    ${body}=        To Json              {"kyc_trans_id" : "${TRANS_ID}","twins_status": "True","twins_gender": "Male"}
    ${response}=    PUT On Session     alias=${ALIAS}     url=${URI_TWIN}   headers=&{HEADER_TWIN}    json=${body}      expected_status=anything
    # Request Should Be Successful    response=${response}
    Run keyword if       '${response.status_code}' != '200'         Save_error_When_its_active          TWIN            

    Set global variable     ${RESPONSE_TWIN_MESSAGE}         ${response.json()["status"]["message"]}

Dont_Have_Twin
    Set To Dictionary       ${HEADER_TWIN}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_TWIN}
    Create Session          alias=${ALIAS}      url=${URL_CORE_SERVICE} 

    ${body}=        To Json              {"kyc_trans_id" : "${TRANS_ID}","twins_status": "false","twins_gender": ""}
    ${response}=    PUT On Session     alias=${ALIAS}     url=${URI_TWIN}   headers=&{HEADER_TWIN}    json=${body}      expected_status=anything
    # Request Should Be Successful    response=${response}
    Run keyword if       '${response.status_code}' != '200'         Save_error_When_its_active          TWIN            

    Set global variable     ${RESPONSE_TWIN_MESSAGE}         ${response.json()["status"]["message"]}
