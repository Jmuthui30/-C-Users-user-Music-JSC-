page 52098 "Procurement Plan Review"
{
    Caption = 'Procurement Plans Review';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Procurement Plan Lines";
    SourceTableView = WHERE("Plan Status"=CONST(Released));

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Plan No"; Rec."Plan No")
                {
                    ApplicationArea = All;
                    Caption = 'Procurement Plan No';
                }
                field("Procurement Type"; Rec."Procurement Type")
                {
                    ApplicationArea = All;
                    Caption = 'Procurement Type';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    Caption = 'Category';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    Caption = 'Department Code';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Project Code';
                }
                field("Procurement Method"; Rec."Procurement Method")
                {
                    ApplicationArea = All;
                    Caption = 'Procurement Method';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    Caption = 'Unit Price';
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Estimated Cost';
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
                ApplicationArea = All;

                trigger OnAction();
                begin
                end;
            }
        }
    }
}
