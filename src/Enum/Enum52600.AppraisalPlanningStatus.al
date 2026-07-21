enum 52600 "Appraisal Planning Status"
{
    Extensible = true;
    Caption = 'Appraisal Planning Status';

    value(0; Draft)
    {
        Caption = 'Draft';
    }
    value(1; "Pending Appraiser Review")
    {
        Caption = 'Pending Appraiser Review';
    }
    value(2; "Returned for Changes")
    {
        Caption = 'Returned for Changes';
    }
    value(3; "Pending HR Approval")
    {
        Caption = 'Pending HR Approval';
    }
    value(4; "Appraisal Created")
    {
        Caption = 'Appraisal Created';
    }
    value(5; "Appraisal Rejected")
    {
        Caption = 'Appraisal Rejected';
    }
    //open
    value(6; Open)
    {
        Caption = 'Open';
    }

}
