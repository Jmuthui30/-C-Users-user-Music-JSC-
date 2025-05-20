report 56000 "Login Management"
{
    ApplicationArea = All;
    Caption = 'Login Management';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = true;
    dataset
    {
        // dataitem(PasswordHistory; "Password History")
        // {
        //     trigger OnPostDataItem()
        //     begin

        //     end;

        //     trigger OnAfterGetRecord()

        //     begin
        //         User.Get(PasswordHistory."User Security ID");
        //         UserSetup.Get(UserId());

        //         if (("Next Password Change" = Today()) and (UserSetup."Last Password Change" <> Today())) then begin
        //             User.Validate("Change Password", true);
        //             User.Modify()
        //         end;
        //     end;

        //     trigger OnPreDataItem()
        //     var
        //     begin

        //     end;
        // }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        User: Record User;
        UserSetup: Record "User Setup";
}






