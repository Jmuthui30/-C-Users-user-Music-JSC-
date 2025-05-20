page 51968 "Leave Plan Applications-HOD"
{
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Employee Leave Plan";
    SourceTableView = WHERE(Status=CONST(Released));

    layout
    {
        area(content)
        {
            repeater(Control13)
            {
                ShowCaption = false;

                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field(Names; Names)
                {
                    ApplicationArea = All;
                    Caption = 'Names';
                    Editable = false;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    ApplicationArea = All;
                    Caption = 'Days to Proceed on Leave';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Approved Days"; Rec."Approved Days")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Approved Start Date"; Rec."Approved Start Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Verified By Manager"; Rec."Verified By Manager")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Approved End Date"; Rec."Approved End Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        /*Employee.RESET;
        IF Employee.GET("Employee No") THEN
        Names:=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
        */
        UserRec.Reset;
        if UserRec.Get(UserId)then Emp.Reset;
        if Emp.Get(UserRec."Employee No.")then Rec.SetRange("Department Code", Emp."Global Dimension 1 Code");
    end;
    trigger OnOpenPage()
    begin
        UserRec.Reset;
        if UserRec.Get(UserId)then Emp.Reset;
        if Emp.Get(UserRec."Employee No.")then Rec.SetRange("Department Code", Emp."Global Dimension 1 Code");
    end;
    var Names: Text[250];
    Employee: Record Employee;
    UserRec: Record "User Setup";
    Emp: Record Employee;
}
