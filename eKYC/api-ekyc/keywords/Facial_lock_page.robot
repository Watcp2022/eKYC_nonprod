***Settings***
Library             RequestsLibrary
Library             Collections



***Keywords***
Action_Facial_Lock
    [Arguments]         ${row_gen_qrcode} 
    Get_data_excel.Get_facial_lock           ${row_gen_qrcode}  

    Set To Dictionary       ${HEADER_FACIAL_AUTHEN}      partner-secret=${GET_PARTNER_SECRET}

    Create Session          alias=${ALIAS}    url=${BOT_CORE_SERVICE}
    &{body}=        Create dictionary    cid=${GET_ID_CARD}    permanent_lock=${GET_STATUS_LOCK}

    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_FACIAL_LOCK}     headers=&{HEADER_FACIAL_AUTHEN}      json=${body}    expected_status=anything
    Set global variable             ${RESPONSE_CODE}                                  ${response.json()["status"]["code"]}             
    Set global variable             ${RESPONSE_MESSAGE}                               ${response.json()["status"]["message"]}             
    Set global variable             ${RESPONSE_REMARK}                                ${response.json()["status"]["remark"]}             


Permanent_lock
    Set To Dictionary       ${HEADER_FACIAL_AUTHEN}      partner-secret=${GET_PARTNER_SECRET}
    Create Session          alias=${ALIAS}    url=${BOT_CORE_SERVICE}
    &{body}=        Create dictionary    cid=jzoyaYvHxfMTTtRy9N/8jwBmZHBm3l6IkCmNcawbA8haeGlrOTb8Gpo=       permanent_lock=TRUE

    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_FACIAL_LOCK}     headers=&{HEADER_FACIAL_AUTHEN}      json=${body}    expected_status=anything
    Set global variable             ${RESPONSE_CODE}                                  ${response.json()["status"]["code"]}             
    Set global variable             ${RESPONSE_MESSAGE}                               ${response.json()["status"]["message"]}             
    Set global variable             ${RESPONSE_REMARK}                                ${response.json()["status"]["remark"]}             

Temporary_lock
    Set To Dictionary       ${HEADER_FACIAL_AUTHEN}      partner-secret=${GET_PARTNER_SECRET}
    Create Session          alias=${ALIAS}    url=${BOT_CORE_SERVICE}
    &{body}=        Create dictionary    cid=jzoyaYvHxfMTTtRy9N/8jwBmZHBm3l6IkCmNcawbA8haeGlrOTb8Gpo=     permanent_lock=False

    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_FACIAL_LOCK}     headers=&{HEADER_FACIAL_AUTHEN}      json=${body}    expected_status=anything
    Set global variable             ${RESPONSE_CODE}                                  ${response.json()["status"]["code"]}             
    Set global variable             ${RESPONSE_MESSAGE}                               ${response.json()["status"]["message"]}             
    Set global variable             ${RESPONSE_REMARK}                                ${response.json()["status"]["remark"]}             
