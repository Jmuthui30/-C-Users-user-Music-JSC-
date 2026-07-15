page 50083 "Employee Board List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageID = "Employee Card";
    Editable = false;
    SourceTable = Employee;
    SourceTableView = WHERE("Employer Category" = CONST(Board));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = BasicHR;
                }
                field(FullName; Rec.FullName())
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Full Name';
                    ToolTip = 'Specifies the full name of the employee.';
                    Visible = false;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = BasicHR;
                    NotBlank = true;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = BasicHR;
                    Visible = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = BasicHR;
                    NotBlank = true;
                }
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = BasicHR;
                }




                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Mobile Phone No.';
                    Visible = false;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Private Email';
                    Visible = false;
                }

                field("Resource No."; Rec."Resource No.")
                {
                    ApplicationArea = Jobs;
                    Visible = false;
                }

                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = Basic, Suite;
                }

                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Comments;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
}