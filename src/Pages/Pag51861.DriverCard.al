page 51861 "Driver Card"
{
    // version THL- PRM 1.0
    PageType = Card;
    SourceTable = Driver;
    SourceTableView = WHERE(Status=CONST(Available));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Driver License No."; Rec."Driver License No.")
                {
                    ApplicationArea = All;
                }
                field("License Class"; Rec."License Class")
                {
                    ApplicationArea = All;
                }
                field("License Issue Date"; Rec."License Issue Date")
                {
                    ApplicationArea = All;
                }
                field("License Expiry Date"; Rec."License Expiry Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                }
                field("License Image"; Rec."License Image")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control19; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
    var NoSeriesMgt: Codeunit NoSeriesManagement;
}
