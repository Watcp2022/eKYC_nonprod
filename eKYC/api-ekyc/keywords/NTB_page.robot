***Settings***
Library             RequestsLibrary
Library             Collections


***Keywords***
Update_Mobile_Number_API
    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE}
    &{body}=      Create dictionary        kyc_trans_id=${TRANS_ID}     mobile_no=${MOBILE_NO} 

    ${response}=    Put On Session     alias=${ALIAS}     url=${URI_LOGIN}   headers=&{HEADER_LOGIN}    json=${body}
    Request Should Be Successful       response=${response}
    Should Be Equal                    ${response.json()["status"]["message"]}              ${RESPONSE_MESSAGE_SUCCESS}
