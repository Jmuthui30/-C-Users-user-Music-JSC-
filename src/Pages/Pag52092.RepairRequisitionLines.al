page 52092 "Repair Requisition Lines"
{
    //Ibrahim Wasiu
    AutoSplitKey = true;
    Caption = 'Repair Lines';
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = "Repair Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(No; Rec.No)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                /*trigger OnValidate()
                    begin
                        Amount := Rec.Quantity * Rec."Unit Price";
                    end;*/
                }
                field("Quantity To Issue"; Rec."Quantity To Issue")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Quantity Issued"; Rec."Quantity Issued")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Quantity in Store"; Rec."Quantity in Store")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(MFR; Rec.MFR)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Catalog No."; Rec."Catalog No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
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
    var RepairLines: Record "Repair Lines";
}
