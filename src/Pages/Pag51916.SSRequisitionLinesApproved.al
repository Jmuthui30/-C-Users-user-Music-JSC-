page 51916 "SS  Requisition Lines Approved"
{
    // version THL- PRM 1.0
    AutoSplitKey = true;
    Caption = 'Requisition Lines';
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = "Requisition Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    Editable = false;

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
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Quantity To Issue"; Rec."Quantity To Issue")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Quantity Issued"; Rec."Quantity Issued")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
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
                    Editable = false;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Quantity in Store"; Rec."Quantity in Store")
                {
                    ApplicationArea = All;
                    Editable = false;
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
    trigger OnAfterGetRecord()
    begin
        RequisitionLines.Reset;
        RequisitionLines.SetRange("Requisition No", Rec."Requisition No");
        RequisitionLines.SetRange("Line No", Rec."Line No");
        if RequisitionLines.FindFirst then begin
            RequisitionLines."Quantity To Issue":=RequisitionLines.Quantity - RequisitionLines."Quantity Issued";
        //RequisitionLines.Modify;
        end;
        if Rec.Type = Rec.Type::Item then begin
            if Item.Get(Rec.No)then begin
                Item.CalcFields(Inventory);
                Rec."Quantity in Store":=Item.Inventory;
            end;
        end;
    end;
    var RequisitionLines: Record "Requisition Lines";
    Item: Record Item;
}
