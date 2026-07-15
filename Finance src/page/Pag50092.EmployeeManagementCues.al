page 50092 "Employee Management Cues"
{
    ApplicationArea = All;
    Caption = 'Employee Management Cues';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "HR Management Cue";

    layout
    {
        area(Content)
        {


            cuegroup(EmployeeAppraisal)
            {
                Caption = 'Employee Management';
                //    "Employee JSC List"
                field("Employee JSC List"; Rec."Employee JSC List")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employee JSC List';
                    ToolTip = 'Specifies the list of employees in the JSC category.';
                }
                field("Employee KJC List"; Rec."Employee KJC List")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employee KJC List';
                    ToolTip = 'Specifies the list of employees in the KJC category.';
                }
                field("Employee Judiciary List"; Rec."Employee Judiciary List")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employee Judiciary List';
                    ToolTip = 'Specifies the list of employees in the Judiciary category.';
                }
                field("Employee Board List"; Rec."Employee Board List")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employee Board List';
                    ToolTip = 'Specifies the list of employees in the Board category.';
                }


            }

        }





    }


    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;

        // Rec.SetRange("User ID Filter", UserId);
    end;
}
