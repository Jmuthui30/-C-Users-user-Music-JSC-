page 51900 "Fuel Voucher Header-Open"
{
    // version THL- PRM 1.0
    Caption = 'New Fuel Vouchers';
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Fuel Voucher Header";
    SourceTableView = WHERE(Posted=CONST(false));

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
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("No. of Vouchers"; Rec."No. of Vouchers")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Control11; "Fuel Voucher Lines")
            {
                ApplicationArea = All;
                SubPageLink = "No."=FIELD("No.");
            }
        }
        area(factboxes)
        {
            systempart(Control10; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Print Fuel Vouchers")
            {
                ApplicationArea = All;
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to print the fuel voucher(s)', false) = true then begin
                        if Confirm('We will start by generating Bulk Fuel Vouchers. Should we continue?', false) = true then begin
                            Voucher.Reset;
                            Voucher.SetRange("No.", Rec."No.");
                            Voucher.SetRange("Type of Voucher", Voucher."Type of Voucher"::"Bulk Fuel Voucher");
                            if Voucher.FindSet then REPORT.Run(51814, true, false, Voucher)
                            else
                                Message('There are no Bulk Fuel Vouchers to generate.');
                        end;
                        if Confirm('We will now generate Vehicle Fuel Vouchers. Should we continue?', false) = true then begin
                            Voucher.Reset;
                            Voucher.SetRange("No.", Rec."No.");
                            Voucher.SetRange("Type of Voucher", Voucher."Type of Voucher"::"Vehicle Fuel Voucher");
                            if Voucher.FindSet then REPORT.Run(51815, true, false, Voucher)
                            else
                                Message('There are no Vehicle Fuel Vouchers to generate.');
                        end;
                        if Confirm('Finally, we will now generate Motorcycle Fuel Vouchers. Should we continue?', false) = true then begin
                            Voucher.Reset;
                            Voucher.SetRange("No.", Rec."No.");
                            Voucher.SetRange("Type of Voucher", Voucher."Type of Voucher"::"Motor-cycle Fuel Voucher");
                            if Voucher.FindSet then REPORT.Run(51816, true, false, Voucher)
                            else
                                Message('There are no Motorcycle Fuel Vouchers to generate.');
                        end;
                        Rec.Posted:=true;
                        Rec."Posted By":=UserId;
                        Rec."Posted Date":=Today;
                        Rec.Modify;
                        Message('Fuel Voucher(s) generated, they have now been moved to Printed Fuel Vouchers Page.');
                    end;
                end;
            }
        }
    }
    var Voucher: Record "Fuel Voucher Lines";
    VoucherCopy: Record "Fuel Voucher Lines";
}
