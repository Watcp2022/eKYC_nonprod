*** Settings ***
Library         RequestsLibrary
Resource       ../keywords/Get_term_and_conditionAPI_page.robot
Resource       ../keywords/validate_customer_API_page.robot
Resource       ../keywords/Get_Consent_API_page.robot
Resource       ../keywords/sent_SMS(OTP)API_page.robot
Resource       ../keywords/verify_OTP_API_page.robot
Resource       ../keywords/Check_DOPA_API_page.robot
Resource       ../keywords/Validate_imageAPI_page.robot
Resource       ../Varriable/varriable.robot
Resource		../keywords/save_data_excel_page.robot
Resource		../Varriable/img.robot
Resource		../keywords/Save_LN_FR_Page.robot
Resource		../keywords/LivenessAPI_page.robot
# Resource		../Varriable/api_varriable.robot
Resource		../Varriable/Tablet_varriable.robot
Resource        ../keywords/Save_IAL_Level.robot
Resource        ../keywords/IAL_Page.robot
Resource		../keywords/Twin_page.robot
Resource        ../keywords/IAL_Page.robot
Resource        ../keywords/Generate_Transaction_page.robot
Resource        ../keywords/QR_code_page.robot
Resource        ../keywords/Generate_Partner_Secret_page.robot

Resource		../Main/Main.robot
# Suite Setup			Start Project
# Suite Teardown		Stop Project
Suite Setup         Generate_Partner_Secret
Suite Teardown          Log to console          ${TRANS_ID} 


# robot   -t   Push_noti_1    eKYC/api-ekyc/Test\ case/24.push_noti_test.robot 
***Test Cases***
Push_noti_1
    [Documentation]    happy case
    QR_code_page.Generate_QR_Code_for_test_qrstamp_scene
    Main.Start Project
    QR_code_page.Validate_QR_Code_for_test_qrstamp_scene
    Get_term_and_conditionAPI_page.Agree_term_and_conditions
    Validate_customer_API_page.Validate_customer_pass            4
    Check_DOPA_API_page.Check_DOPA          
    LivenessAPI_page.Liveness_and_FR_Pass

Push_noti_other
    QR_code_page.Generate_QR_Code_for_test_qrstamp_scene
    Main.Start Project
    QR_code_page.Validate_QR_Code_for_test_qrstamp_scene
    Get_term_and_conditionAPI_page.Agree_term_and_conditions
    Validate_customer_API_page.Validate_customer_pass            14
    Check_DOPA_API_page.Check_DOPA          
    LivenessAPI_page.Liveness_and_FR_Pass
 
Push_noti_2
    QR_code_page.Generate_QR_Code_for_test_qrstamp_scene
    Main.Start Project
    QR_code_page.Validate_QR_Code_for_test_qrstamp_scene
    Get_term_and_conditionAPI_page.Agree_term_and_conditions
    Validate_customer_API_page.Validate_customer_Fails          6

Push_noti_3
    [Documentation]    check dopa fail
    QR_code_page.Generate_QR_Code_for_test_qrstamp_scene
    Main.Start Project
    QR_code_page.Validate_QR_Code_for_test_qrstamp_scene
    Get_term_and_conditionAPI_page.Agree_term_and_conditions
    Validate_customer_API_page.Validate_customer_pass              4
    Check_DOPA_API_page.Check_DOPA_Fail           

Push_noti_4
    [Documentation]    FR Fail
    QR_code_page.Generate_QR_Code_for_test_qrstamp_scene
    Main.Start Project
    QR_code_page.Validate_QR_Code_for_test_qrstamp_scene
    Get_term_and_conditionAPI_page.Agree_term_and_conditions
    Validate_customer_API_page.Validate_customer_pass              4
    Check_DOPA_API_page.Check_DOPA          
    Facial_RecognitionAPI_page.Face_Rec_fail
    Facial_RecognitionAPI_page.Face_Rec_fail 
    Facial_RecognitionAPI_page.Face_Rec_fail 
    Facial_RecognitionAPI_page.Face_Rec_fail 

Push_noti_5
    [Documentation]    ไม่กดรับ consent
    QR_code_page.Generate_QR_Code_for_test_qrstamp_scene
    Main.Start Project
    QR_code_page.Validate_QR_Code_for_test_qrstamp_scene
    Get_term_and_conditionAPI_page.Agree_term_and_conditions
    Validate_customer_API_page.Validate_customer_pass_and_Disagree_Consent              4


Push_noti_6
    [Documentation]     qr Dipchip fail
    QR_code_page.Generate_QR_Code_for_test_qrstamp_scene
    Main.Start Project
    QR_code_page.Validate_QR_Code_for_test_qrstamp_scene
    Get_term_and_conditionAPI_page.Agree_term_and_conditions
    Validate_customer_API_page.Validate_customer_qr_code_journey                      13
