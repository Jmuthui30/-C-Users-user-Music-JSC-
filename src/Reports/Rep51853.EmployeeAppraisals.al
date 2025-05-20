report 51853 "Employee Appraisals"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Employee Appraisals.rdlc';

    dataset
    {
        dataitem("Employee Appraisals"; "Employee Appraisals")
        {
            RequestFilterFields = "Appraisal No", "Deapartment Code";

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            /*column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }*/
            column(USERID; UserId)
            {
            }
            column(Employee_Appraisals1__Appraisee_Name_; "Appraisee Name")
            {
            }
            column(Employee_Appraisals1__Appraisee_s_Job_Title_; "Appraisee's Job Title")
            {
            }
            column(Employee_Appraisals1__Appraisers_Name_; "Appraisers Name")
            {
            }
            column(Employee_Appraisals1__Appraiser_s_Job_Title_; "Appraiser's Job Title")
            {
            }
            column(Employee_Appraisals1__Appraisal_Period_; "Appraisal Period")
            {
            }
            column(Employee_Appraisals1_Date; Date)
            {
            }
            column(Employee_Appraisals1_Rating; Rating)
            {
            }
            column(Employee_Appraisals1__Deapartment_Code_; "Deapartment Code")
            {
            }
            column(Employee_Appraisals1__General_Comments_; "General Comments")
            {
            }
            column(Appraisal_Summary_ReportCaption; Appraisal_Summary_ReportCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee_Appraisals1__Appraisee_Name_Caption; FieldCaption("Appraisee Name"))
            {
            }
            column(Employee_Appraisals1__Appraisee_s_Job_Title_Caption; FieldCaption("Appraisee's Job Title"))
            {
            }
            column(Employee_Appraisals1__Appraisers_Name_Caption; FieldCaption("Appraisers Name"))
            {
            }
            column(Employee_Appraisals1__Appraiser_s_Job_Title_Caption; FieldCaption("Appraiser's Job Title"))
            {
            }
            column(Employee_Appraisals1__Appraisal_Period_Caption; FieldCaption("Appraisal Period"))
            {
            }
            column(Employee_Appraisals1_DateCaption; FieldCaption(Date))
            {
            }
            column(Overall_RatingCaption; Overall_RatingCaptionLbl)
            {
            }
            column(Employee_Appraisals1__Deapartment_Code_Caption; FieldCaption("Deapartment Code"))
            {
            }
            column(Training_NeedCaption; Training_NeedCaptionLbl)
            {
            }
            column(Additional_Remarks_Caption; Additional_Remarks_CaptionLbl)
            {
            }
            column(Employee_Appraisals1_Appraisal_No; "Appraisal No")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    var Appraisal_Summary_ReportCaptionLbl: Label 'Appraisal Summary Report';
    CurrReport_PAGENOCaptionLbl: Label 'Page';
    Overall_RatingCaptionLbl: Label 'Overall Rating';
    Training_NeedCaptionLbl: Label 'Training Need';
    Additional_Remarks_CaptionLbl: Label 'Additional Remarks ';
}
