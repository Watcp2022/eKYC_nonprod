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
Resource        ../keywords/Login_api_page.robot
Resource		../Main/Main.robot
Resource        ../keywords/QR_code_page.robot
Resource        ../keywords/NTB_page.robot


***Test Cases***
ekyc_NTB_1
    [Documentation]     ทดสอบระบบ api-Update Mobile Number กรณี ไม่ได้เป็นลูกค้ามาก่อน และ เข้ามาทำรายการ  NTB
    Login_api_page.Login_Get_Token
	Generate_Transaction_page.Start_Generate_Transaction
	Get_term_and_conditionAPI_page.Agree_term_and_conditions
	Validate_customer_API_page.Validate_customer_pass             5
    NTB_page.Update_Mobile_Number_API

ekyc_NTB_2
    [Documentation]     ทดสอบระบบ api-Update Mobile Number กรณี ไม่ส่งค่า mobile_no ที่ Request body

ekyc_NTB_3
    [Documentation]     ทดสอบระบบ api-Update Mobile Number กรณี ไม่ส่งค่า customer_id ที่ Request body

ekyc_NTB_4
    [Documentation]     ทดสอบระบบ api-Update Mobile Number กรณี ไม่ส่งค่า auth.