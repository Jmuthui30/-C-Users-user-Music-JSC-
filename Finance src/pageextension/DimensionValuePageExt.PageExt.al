pageextension 51001 DimensionValuePageExt extends "Dimension Values"
{
    layout
    {

    }

    trigger OnOpenPage()
    begin
        Rec.SetFilter(Blocked, '=%1', false);
    end;
}
