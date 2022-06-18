*** Settings ***
Library             RequestsLibrary
Library             Collections
Resource            ../Varriable/varriable.robot
Resource            ../keywords/Get_data_excel.robot

# Suite Setup         Create Session    alias=${ALIAS}    url=${URL_CORE_SERVICE}

*** Keywords ***
# Check_DOPA
#     ${body}=        To Json         {"kyc_trans_id": "${TRANS_ID}","laser": "JT2095xxxxxx"}
#     ${response}=    POST On Session     alias=${ALIAS}     url=${URI_POST_CHECK_DOPA}    headers=&{HEADER_PLATFORM_KYC}    json=${body}
#     Should Be Equal As Integers     ${response.json()["status"]["code"]}         ${RESPONSE_CODE_SUCCESS}
#     Should Be Equal                 ${response.json()["status"]["message"]}      ${RESPONSE_MESSAGE_SUCCESS_DOPA}
#     # Should Be Equal                 ${response.json()["status"]["remark"]}       ${RESPONSE_REMARK_NULL}
#     Should Be Equal                 ${response.json()["data"]["trans_id"]}       ${TRANS_ID}
#     # Should Be Equal                 ${response.json()["data"]["dopa_status"]}    ${RESPONSE_DOPA_STATUS}
#     # Should Be Equal                 ${response.json()["data"]["dopa_message"]}   ${RESPONSE_DOPA_MESSAGE}
#     Log                 ${response.json()["data"]["dopa_status"]}

Check_DOPA
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}

    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE}
    ${body}=        To Json         {"kyc_trans_id":"${TRANS_ID}","laser" : "${GET_LASER_CODE}"}
    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_POST_CHECK_DOPA}   headers=&{HEADER_PLATFORM_KYC}    json=${body}    expected_status=anything
    # Request Should Be Successful    response=${response}
    # Log    				${response.json()["dopa_status"]}           
    # Log                 ${response.json()["dopa_message"]}        
    Log                 ${response.json()["status"]["message"]}     
	# Log					${response.json()["data"]["dopa_status"]}    
	# Log					${response.json()["data"]["dopa_message"]} 

    Set global variable     ${DOPA_MESSAGE}         ${response.json()["status"]["message"]}             
    Set global variable     ${DOPA_REMARK}         ${response.json()["status"]["remark"]}             


Check_DOPA_Error_Chip_no
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}

    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE}
    ${body}=        To Json         {"kyc_trans_id": "${TRANS_ID}", "laser": "JT2095bbbbbb"}
    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_POST_CHECK_DOPA}    headers=&{HEADER_PLATFORM_KYC}    json=${body}
    # Should Be Equal As Integers     ${response.json()["status"]["code"]}                ${RESPONSE_CODE_DOPA_FAIL} 
    # Should Be Equal                 ${response.json()["status"]["message"]}             ${RESPONSE_MESSAGE_2006_2}
    # Should Be Equal                 ${response.json()["status"]["remark"]}          ${RESPONSE_REMARK_NULL}
    # Should Be Equal                 ${response.json()["data"]["trans_id"]}              ${TRANS_ID}
    # Should Be Equal                 ${response.json()["data"]["dopa_status"]}           ${RESPONSE_DOPA_STATUS_ERROR_CHIP_NO}
    # Should Be Equal                 ${response.json()["data"]["dopa_message"]}          ${RESPONSE_DOPA_MESSAGE_ERROR_CHIP_NO} 
    Set global variable     ${DOPA_MESSAGE}         ${response.json()["status"]["message"]}             
    Set global variable     ${DOPA_REMARK}         ${response.json()["status"]["remark"]}             


Check_DOPA_Card_Expire
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}

    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE}
    ${body}=        To Json         {"kyc_trans_id": "${TRANS_ID}", "laser": "JT2095cccccc"}
    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_POST_CHECK_DOPA}      headers=&{HEADER_PLATFORM_KYC}      json=${body}
    # Should Be Equal As Integers     ${response.json()["status"]["code"]}            ${RESPONSE_CODE_DOPA_FAIL} 
    # Should Be Equal                 ${response.json()["status"]["message"]}         ${RESPONSE_MESSAGE_2006_2}
    # Should Be Equal                 ${response.json()["status"]["remark"]}          ${RESPONSE_REMARK_NULL}
    # Should Be Equal                 ${response.json()["data"]["trans_id"]}           ${TRANS_ID}
    # Should Be Equal                 ${response.json()["data"]["dopa_status"]}       ${RESPONSE_DOPA_STATUS_CARD_EXPIRE}
    # Should Be Equal                 ${response.json()["data"]["dopa_message"]}      ${RESPONSE_DOPA_MESSAGE_CARD_EXPIRE}  
    Set global variable     ${DOPA_MESSAGE}         ${response.json()["status"]["message"]}             
    Set global variable     ${DOPA_REMARK}         ${response.json()["status"]["remark"]}             


Check_DOPA_Card_Not_Found_Laser_Code
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}

    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE}
    ${body}=        To Json         {"kyc_trans_id": "${TRANS_ID}", "laser": "JT2095eeeeee"}
    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_POST_CHECK_DOPA}      headers=&{HEADER_PLATFORM_KYC}      json=${body}
    Should Be Equal As Integers     ${response.json()["status"]["code"]}             ${RESPONSE_CODE_DOPA_FAIL} 
    Should Be Equal                 ${response.json()["status"]["message"]}          ${RESPONSE_MESSAGE_2006_2}
    # Should Be Equal                 ${response.json()["status"]["remark"]}           ${RESPONSE_REMARK_NULL}
    # Should Be Equal                 ${response.json()["data"]}
    # Should Be Equal                 ${response.json()["data"]["trans_id"]}           ${TRANS_ID}
    # Should Be Equal                 ${response.json()["data"]["dopa_status"]}        ${RESPONSE_DOPA_STATUS_CARD_NOT_FOUND_LASER_CODE}
    # Should Be Equal                 ${response.json()["data"]["dopa_message"]}       ${RESPONSE_DOPA_MESSAGE_CARD_NOT_FOUND_LASER_CODE}
    Set global variable     ${DOPA_MESSAGE}         ${response.json()["status"]["message"]}             
    Set global variable     ${DOPA_REMARK}         ${response.json()["status"]["remark"]}             


Check_DOPA_card_loss_Data
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}

    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE}
    ${body}=        To Json         {"kyc_trans_id": "${TRANS_ID}", "laser": "JT2095ffffff"}
    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_POST_CHECK_DOPA}      headers=&{HEADER_PLATFORM_KYC}      json=${body}
    Should Be Equal As Integers     ${response.json()["status"]["code"]}                2006 
    # Should Be Equal                 ${response.json()["status"]["message"]}          ${RESPONSE_MESSAGE_2006_2}
    # Should Be Equal                 ${response.json()["status"]["remark"]}           ${RESPONSE_REMARK_NULL}
    # Should Be Equal                 ${response.json()["data"]["trans_id"]}           ${TRANS_ID}
    # Should Be Equal                 ${response.json()["data"]["dopa_status"]}        ${RESPONSE_DOPA_STATUS_CARD_LOSS_DATA}
    # Should Be Equal                 ${response.json()["data"]["dopa_message"]}       ${RESPONSE_DOPA_MESSAGE_CARD_LOSS_DATA}
    Set global variable     ${DOPA_MESSAGE}         ${response.json()["status"]["message"]}             
    Set global variable     ${DOPA_REMARK}         ${response.json()["status"]["remark"]}             

Check_DOPA_TimeOut
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}
    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE}
    ${dopa}=        To Json         { "kyc_trans_id":"${TRANS_ID}", "laser" : "JT2095aaaaaa" }
    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_POST_CHECK_DOPA}    headers=&{HEADER_PLATFORM_KYC}    json=${dopa}

    Log         ${response.content}
    Log             ${response.json()["status"]["code"]}
    Log             ${response.json()["status"]["message"]}

    Set global variable         ${DOPA_MESSAGE}                 ${response.json()["status"]["message"]}
    Set global variable         ${DOPA_REMARK}                   ${response.json()["status"]["remark"]}

Check_DOPA_OFFLINE_3of3
    ${ignore1}   Run Keyword And Ignore Error		Check_DOPA_TimeOut
    ${ignore2}   Run Keyword And Ignore Error		Check_DOPA_TimeOut
    ${ignore3}   Run Keyword And Ignore Error		Check_DOPA_TimeOut
    ${ignore4}   Run Keyword And Ignore Error		Check_DOPA_TimeOut

Check_DOPA_OFFLINE_Pass_at_3
    ${ignore1}   Run Keyword And Ignore Error		Check_DOPA_TimeOut
    ${ignore2}   Run Keyword And Ignore Error		Check_DOPA_TimeOut
    Check_DOPA


Check_DOPA_Fail
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}

    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE}
    ${body}=        To Json         {"kyc_trans_id":"${TRANS_ID}","laser" : "XXXXXXXXXXXX"}
    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_POST_CHECK_DOPA}   headers=&{HEADER_PLATFORM_KYC}    json=${body}    expected_status=anything
