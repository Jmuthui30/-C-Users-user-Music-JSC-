page 52474 "Beneficiary Cards"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Employee Beneficiaries";
    Caption = 'Beneficiary Cards';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Employee No. field';
                }
                field("Beneficiary No."; Rec."Beneficiary No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Beneficiary No. field';
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the value of the Middle Name field';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field';
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ToolTip = 'Specifies the value of the Date of Birth field';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field';
                }
                field("ID No./Passport"; "ID No./Passport")
                { }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field';
                }
                field("Relative Code"; "Relative Code")
                {
                    ToolTip = 'Specifies the value of the Percentage field.';
                    Caption = 'Relationship';
                }
                field(Guardian; Guardian)
                {

                }
                group(Details)
                {
                    Visible = "Relative Code" = 'Other';

                    field("specifis Other"; "specifis Other")
                    {
                        Caption = 'Description';
                    }

                }
                group(GuardianDetails)
                {
                    Visible = Guardian = true;
                    field("Name of Guardian"; "Name of Guardian")
                    { }
                    field("Guardian Contract"; "Guardian Contract")
                    { }

                }

            }
        }
    }

    actions
    {
    }
}





