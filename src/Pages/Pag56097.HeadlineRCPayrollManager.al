page 57097 "Headline RC Payroll Manager"
{
    // NOTE: If you are making changes to this page you might want to make changes to all the other Headline RC pages
    Caption = 'Headline';
    PageType = HeadlinePart;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                ShowCaption = false;

                field(Welcome; Welcome)
                {
                    ApplicationArea = All;
                }
                field(ActiveEmployeeCountText; ActiveEmployeeCountText)
                {
                    ApplicationArea = All;
                }
                field(InActiveEmployeeCountText; InActiveEmployeeCountText)
                {
                    ApplicationArea = All;
                    Visible = InActiveStaffCount <> 0;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        HREmp: Record "Employee";
    begin
        HREmp.Reset();
        HREmp.SetRange(Status, HREmp.Status::Active);
        ActiveStaffCount := HREmp.Count();
        ActiveEmployeeCountText := ActiveEmployeesLbl + Format(ActiveStaffCount);
        HREmp.Reset();
        HREmp.SetFilter(Status, '<>%1', HREmp.Status::Active);
        InActiveStaffCount := HREmp.Count();
        InActiveEmployeeCountText := InActiveEmployeesLbl + Format(InActiveStaffCount);
        Welcome := WelcomeLbl;
    end;

    var
        WelcomeLbl: Label 'Hello Welcome: Payroll Manager Role Center';
        ActiveEmployeesLbl: Label 'Active employees are ';
        InActiveEmployeesLbl: Label 'In-Active employees are ';
        Welcome: Text;
        ActiveEmployeeCountText: Text;
        InActiveEmployeeCountText: Text;
        ActiveStaffCount: Integer;
        InActiveStaffCount: Integer;
}
