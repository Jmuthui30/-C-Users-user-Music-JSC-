pageextension 51439 "ExtDimension Values" extends "Dimension Values"
{
    layout
    {
        // Add changes to page layout here
        // Commented By Henry again
        addbefore(Code)
        {
            field("Global Dimension No."; Rec."Global Dimension No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
