pageextension 50019 "ExtQualifications" extends Qualifications
{
    layout
    {
        // Add changes to page layout here
        addbefore(Code)
        {
            field("Qualification Type"; Rec."Qualification Type")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Education Level"; Rec."Education Level")
            {
                ApplicationArea = All;
            }
            field("Level Desc"; Rec."Education Level Desc")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Level; Rec.Level)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }

        addafter(Description)
        {
            field("Description new"; "Description new")
            {
                ApplicationArea = all;
            }
            field(Type; Rec.Type)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
