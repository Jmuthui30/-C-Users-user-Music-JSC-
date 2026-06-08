page 59991 "Director Role Center"
{
    Caption = 'Director Role Center';
    PageType = RoleCenter;
    ApplicationArea = All;


    //SourceTable = "";
    layout
    {
        area(rolecenter)
        {
            part(Control16; "Payroll Activities")
            {
                AccessByPermission = TableData "G/L Entry" = R;
                ApplicationArea = All;
            }

            part(Control46; "Team Member Activities")
            {
                ApplicationArea = All;
            }
            part("Finance Management Cues"; "Finance Management Cues")
            {
                Caption = 'Finance Management';
            }

            part(Headline; "Headline RC Payroll Manager")
            {
                ApplicationArea = Basic, Suite;
            }
            part("PR Payroll Activities Cue"; "Payroll Activities")
            {
                Caption = 'PAYROLL ACTIVITIES';
                ApplicationArea = Basic, Suite;
            }


        }
    }
    actions
    {
        area(reporting)
        {



        }

        area(sections)
        {
        }




    }
}
