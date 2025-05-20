page 51786 "Position Card"
{
    // version THL- HRM 1.0
    PageType = Card;
    SourceTable = Positions;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Approved Postions"; Rec."Approved Postions")
                {
                    ApplicationArea = All;
                }
                field("Reports To"; Rec."Reports To")
                {
                    ApplicationArea = All;
                }
                field(Scale; Rec.Scale)
                {
                    ApplicationArea = All;
                }
                field(Level; Rec.Level)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
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
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field("Probation Period"; Rec."Probation Period")
                {
                    ApplicationArea = All;
                }
                field(Unionizable; Rec.Unionizable)
                {
                    ApplicationArea = All;
                }
                field("Housing Eligibility"; Rec."Housing Eligibility")
                {
                    ApplicationArea = All;
                }
            }
            part(Control19; "Position Document Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Document No."=FIELD(Code), "Table ID"=CONST(51653);
            }
        }
        area(factboxes)
        {
            systempart(Control18; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
