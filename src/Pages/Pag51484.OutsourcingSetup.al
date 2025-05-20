page 51484 "Outsourcing Setup"
{
    // version THL- Client Payroll 1.0
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Outsourcing Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Primary Key"; Rec."Primary Key")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Employee Import Nos."; Rec."Employee Import Nos.")
                {
                    ApplicationArea = All;
                }
                field("Employee Leave Nos."; Rec."Employee Leave Nos.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
