page 51803 "SS Requisition Lines"
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
                    ToolTip = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the line type.';
                }
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the number of a general ledger account, item, or fixed asset, depending on what you selected in the Type field.';

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = true;
                    ToolTip = 'Enter a description of the entry of the product to be purchased.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the unit of measure.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                    ToolTip = 'Enter a code for the location where you want the items to be placed when they are received.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the number of units of the item specified on the line.';

                    trigger OnValidate()
                    begin
                        Rec.Amount:=Rec.Quantity * Rec."Unit Price";
                    end;
                }
                field("Quantity To Issue"; Rec."Quantity To Issue")
                {
                    ApplicationArea = All;
                    Visible = (Rec.Status = Rec.Status::"Pending Approval");
                    Editable = false;
                    ToolTip = 'Enter the number of the units of the item are requested for.';
                }
                field("Quantity Issued"; Rec."Quantity Issued")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Enter the number of the units of the item on the line that will be posted as Issued.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Enter the price, in LCY, for one unit of the item.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the currency of amounts on the purchase request document.';
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Enter the amount that is granted for the item on the line.';

                    //Visible = PurchReq;
                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Quantity in Store"; Rec."Quantity in Store")
                {
                    ApplicationArea = All;
                    Visible = (Rec.Status = Rec.Status::"Pending Approval");
                    Editable = false;
                    ToolTip = 'Enter how many units, such as pieces, boxes, or cans, of the item are in inventory.';
                }
                field("Out of Store Bal."; Rec."Out of Store Bal.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                //ToolTip = 'Enter how many units, such as pieces, boxes, or cans, of the item are in inventory.';
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
                    Editable = true;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Procurement Plan"; Rec."Procurement Plan")
                {
                    ApplicationArea = All;
                }
                field("Procurement Plan Item"; Rec."Procurement Plan Item")
                {
                    ApplicationArea = All;
                    Caption = 'Procurement Plan Line';

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field(Decision; Rec.Decision)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnInit()
    begin
        PurchReq:=false;
    end;
    trigger OnOpenPage()
    var
    begin
        if ReqHeader."Requisition Type" = ReqHeader."Requisition Type"::"Purchase Requisition" then PurchReq:=true
        else
            PurchReq:=false;
    end;
    trigger OnAfterGetRecord()
    begin
        RequisitionLines.Reset;
        RequisitionLines.SetRange("Requisition No", Rec."Requisition No");
        RequisitionLines.SetRange("Line No", Rec."Line No");
        if RequisitionLines.FindFirst then begin
            RequisitionLines."Quantity To Issue":=RequisitionLines.Quantity - RequisitionLines."Quantity Issued";
            RequisitionLines.Modify;
        end;
        Rec.Amount:=Rec.Quantity * Rec."Unit Price";
    end;
    var RequisitionLines: Record "Requisition Lines";
    ReqHeader: Record "Requisition Header";
    PurchReq: Boolean;
}
