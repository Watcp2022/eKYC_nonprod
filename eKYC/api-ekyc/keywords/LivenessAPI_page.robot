*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    ../Varriable/varriable.robot
Resource    ../keywords/Validate_customer_API_page.robot

*** Keywords ***
Liveness_and_FR_Pass
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}
    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE}
    ${body}=        To Json         {"image_source":"${IMG_SOURCE}","kyc_trans_id" : "${TRANS_ID}"}     
    ${resp}=    POST On Session    alias=${ALIAS}     url=${URI_POST_VALIDATE_IMAGE}    headers=&{HEADER_PLATFORM_KYC}    json=${body}
    Set global variable             ${MESS_STATUS}                               ${resp.json()["status"]["message"]}
    Set global variable             ${LN_FR_RESPONE_MESSAGE}                     ${resp.json()["status"]["message"]}


Liveness_Pass
    ${body}=        To Json         { "kyc_trans_id":"EU202104211422", "image_source":"success", "cid":"1234567890123" }     
    ${resp}=    POST On Session    alias=${ALIAS}     url=${URI_POST_LIVENESS}    headers=&{HEADER_LIVENESS}     json=${body}
    Request Should Be Successful    response=${resp}
    Log                 ${resp.json()["status"]["code"]}
    Log                 ${resp.json()["status"]["message"]} 
    Log                 ${resp.json()["status"]["remark"]} 
    Log                 ${resp.json()["data"]["liveness_score"]}


Liveness_fail
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}

    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE}

    ${body}=        To Json         {"image_source":"${IMG_NOT_MATCH}","kyc_trans_id" : "${TRANS_ID}"}     
    ${resp}=    POST On Session    alias=${ALIAS}     url=${URI_POST_VALIDATE_IMAGE}    headers=&{HEADER_PLATFORM_KYC}    json=${body}
    Request Should Be Successful    response=${resp}
    Should Be Equal As Integers     ${resp.json()["status"]["code"]}             ${RESPONSE_CODE_LIVENESS_DETECT_FAILED}
    Should Be Equal                 ${resp.json()["status"]["message"]}          ${RESPONSE_MESSAGE_2009}
    Set Global Variable            ${LN_RETURN_MESSAGE_FAILS}                           ${resp.json()["status"]["message"]}
    # Should Be Equal    ${resp.json()["data"]["liveness_score"]}                  ${RESPONSE_LIVENESS_SCORE}

Liveness_fail_2
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}

    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE}

    ${body}=        To Json         {"image_source":"${LN_LOW_SCORE}","kyc_trans_id" : "${TRANS_ID}"}     
    ${resp}=    POST On Session    alias=${ALIAS}     url=${URI_POST_VALIDATE_IMAGE}    headers=&{HEADER_PLATFORM_KYC}    json=${body}
    Request Should Be Successful    response=${resp}
    Should Be Equal As Integers     ${resp.json()["status"]["code"]}             ${RESPONSE_CODE_LIVENESS_DETECT_FAILED}
    Should Be Equal                 ${resp.json()["status"]["message"]}          ${RESPONSE_MESSAGE_2009}
    Set Global Variable            ${LN_RETURN_MESSAGE_FAILS_2}                           ${resp.json()["status"]["message"]}
    # Should Be Equal    ${resp.json()["data"]["liveness_score"]}                  ${RESPONSE_LIVENESS_SCORE}

Liveness_fail_3
    ${body}=        To Json         {"image_source":"${LN_LOW_SCORE}","kyc_trans_id" : "${TRANS_ID}"}     
    ${resp}=    POST On Session    alias=${ALIAS}     url=${URI_POST_VALIDATE_IMAGE}    headers=&{HEADER_PLATFORM_KYC}    json=${body}
    Request Should Be Successful    response=${resp}
    Should Be Equal As Integers     ${resp.json()["status"]["code"]}             ${RESPONSE_CODE_LIVENESS_DETECT_FAILED}
    Should Be Equal                 ${resp.json()["status"]["message"]}          ${RESPONSE_MESSAGE_2009}
    Set Global Variable            ${LN_RETURN_MESSAGE_FAILS_3}                           ${resp.json()["status"]["message"]}
    # Should Be Equal    ${resp.json()["data"]["liveness_score"]}                  ${RESPONSE_LIVENESS_SCORE}

Liveness_fail_3times
    Liveness_fail
    Liveness_fail
    Liveness_fail
    # Run Keyword If          '${RESULT_LIVENESS}' == '2009'        Return_Error_Liveness_Detect_Failed
    #     ...      ELSE IF    '${RESULT_LIVENESS}' == '2008'        Return_Error_Liveness_reached_maximum
    #     ...      ELSE IF    '${RESULT_LIVENESS}' == '2005'        Return_Error_Trans_Fail
 
    # END

Liveness_Timeout
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}

    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE}

    ${body}=        To Json              {"image_source":"livenesstimeout","kyc_trans_id" : "${TRANS_ID}"}     
    ${resp}=     POST On Session        alias=${ALIAS}     url=${URI_POST_VALIDATE_IMAGE}    headers=&{HEADER_PLATFORM_KYC}    json=${body}
    Request Should Be Successful        response=${resp}
    Should Be Equal As Integers         ${resp.json()["status"]["code"]}            ${RESPONSE_CODE_REQUEST_TIMEOUT}
    Should Be Equal                     ${resp.json()["status"]["message"]}         ${RESPONSE_MESSAGE_1004}
    Set global variable                 ${LN_RETURN_MESSAGE_TIME_OUT}               ${resp.json()["status"]["message"]}


Liveness_Timeout_2
    ${body}=        To Json              {"image_source":"livenesstimeout","kyc_trans_id" : "${TRANS_ID}"}     
    ${resp}=     POST On Session        alias=${ALIAS}     url=${URI_POST_VALIDATE_IMAGE}    headers=&{HEADER_PLATFORM_KYC}    json=${body}
    Request Should Be Successful        response=${resp}
    Should Be Equal As Integers         ${resp.json()["status"]["code"]}            ${RESPONSE_CODE_REQUEST_TIMEOUT}
    Should Be Equal                     ${resp.json()["status"]["message"]}         ${RESPONSE_MESSAGE_1004}
    Set global variable                 ${LN_RETURN_MESSAGE_TIME_OUT_2}               ${resp.json()["status"]["message"]}

Liveness_Timeout_3
    ${body}=        To Json              {"image_source":"livenesstimeout","kyc_trans_id" : "${TRANS_ID}"}     
    ${resp}=     POST On Session        alias=${ALIAS}     url=${URI_POST_VALIDATE_IMAGE}    headers=&{HEADER_PLATFORM_KYC}    json=${body}
    Request Should Be Successful        response=${resp}
    Should Be Equal As Integers         ${resp.json()["status"]["code"]}            ${RESPONSE_CODE_REQUEST_TIMEOUT}
    Should Be Equal                     ${resp.json()["status"]["message"]}         ${RESPONSE_MESSAGE_1004}
    Set global variable                 ${LN_RETURN_MESSAGE_TIME_OUT_3}               ${resp.json()["status"]["message"]}



LN_reached_max
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}

    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE}

    ${body}=        To Json         {"image_source":"${IMG_NOT_MATCH}","kyc_trans_id" : "${TRANS_ID}"}     
    ${resp}=    POST On Session    alias=${ALIAS}     url=${URI_POST_VALIDATE_IMAGE}    headers=&{HEADER_PLATFORM_KYC}    json=${body}
    Request Should Be Successful    response=${resp}
    Should Be Equal As Integers     ${resp.json()["status"]["code"]}             ${RESPONSE_CODE_LIVENESS_REACHED_MAX_TIME}   
    # Should Be Equal                 ${resp.json()["status"]["message"]}          ${RESPONSE_MESSAGE_2008}
    Set global variable             ${MESS_STATUS}                               ${resp.json()["status"]["message"]}       
    Set global variable             ${RESULT_MESSAGE}                               ${resp.json()["status"]["message"]} 
    Set global variable             ${LN_FR_RESPONE_MESSAGE}                     ${resp.json()["status"]["message"]}
    Log                             ${resp.json()["status"]["code"]}

LN_timeOut_reached_max
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}

    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE}

    ${body}=        To Json         {"image_source":"success","kyc_trans_id" : "${TRANS_ID}"}     
    ${resp}=    POST On Session    alias=${ALIAS}     url=${URI_POST_VALIDATE_IMAGE}    headers=&{HEADER_PLATFORM_KYC}    json=${body}
    Request Should Be Successful    response=${resp}
    Should Be Equal As Integers     ${resp.json()["status"]["code"]}             2016 
    # Should Be Equal                 ${resp.json()["status"]["message"]}          ${RESPONSE_MESSAGE_2008}
    Set global variable             ${MESS_STATUS}                               ${resp.json()["status"]["message"]}       
    Set global variable             ${RESULT_MESSAGE}                               ${resp.json()["status"]["message"]} 
    Set global variable             ${LN_FR_RESPONE_MESSAGE}                     ${resp.json()["status"]["message"]}
    Log                             ${resp.json()["status"]["code"]}


Return_Error_LN_Request_Timeout
    Log         Return_Error_LN_Request_Timeout
    Should Be Equal As Integers     ${RESULT_LIVENESS}              ${RESPONSE_CODE_REQUEST_TIMEOUT}    
    Should Be Equal                 ${RESULT_MESSAGE}               ${RESPONSE_MESSAGE_1004}

Return_Error_Liveness_reached_maximum
    Log         Return_Error_Liveness_reached_maximum
    Should Be Equal As Integers     ${RESULT_LIVENESS}              ${RESPONSE_CODE_LIVENESS_REACHED_MAX_TIME}    
    Should Be Equal                 ${RESULT_MESSAGE}                  ${RESPONSE_MESSAGE_2008}

Return_Error_Liveness_Detect_Failed
    Log         Return_Error_Liveness_Detect_Failed
    Should Be Equal As Integers     ${RESULT_LIVENESS}              ${RESPONSE_CODE_LIVENESS_DETECT_FAILED}    
    Should Be Equal                 ${RESULT_MESSAGE}               ${RESPONSE_MESSAGE_2009}

Return_Error_Trans_Fail
    Log         Return_Error_Trans_Fail
    Should Be Equal As Integers     ${RESULT_LIVENESS}              $${RESPONSE_CODE_TRANS_CAN_NOT_PROCESSED}     
    # Should Be Equal                 ${MESS_STATUS}               ${RESPONSE_MESSAGE_2005}


Liveness_and_FR_Pass_support_test
    [Arguments]         ${img_selfie}
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}
    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE}
    ${body}=        To Json         {"image_source":"${${img_selfie}}","kyc_trans_id" : "${TRANS_ID}"}     
    ${resp}=    POST On Session    alias=${ALIAS}     url=${URI_POST_VALIDATE_IMAGE}    headers=&{HEADER_PLATFORM_KYC}    json=${body}
    Set global variable             ${MESS_STATUS}                               ${resp.json()["status"]["message"]}
    Set global variable             ${LN_FR_RESPONE_MESSAGE}                     ${resp.json()["status"]["message"]}
