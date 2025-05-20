pageextension 51440 "ExtG_L Budget Names" extends "G/L Budget Names"
{
    layout
    {
        // Add changes to page layout here
        addafter(Blocked)
        {
            field(Status; Rec.Status)
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Status:=Rec.Status::Open;
    end;
}
