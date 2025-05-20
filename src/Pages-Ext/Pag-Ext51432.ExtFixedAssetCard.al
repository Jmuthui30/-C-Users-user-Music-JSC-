pageextension 51432 "ExtFixed Asset Card" extends "Fixed Asset Card"
{
    layout
    {
        modify("Next Service Date")
        {
            Editable = false;
        }
        // Add changes to page layout here
        addafter("Responsible Employee")
        {
            field("Resource No."; Rec."Resource No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Resource No.")
        {
            field("Asset Status Code"; Rec."Asset Status Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Asset Status Code")
        {
            field("Asset Created Date"; Rec."Asset Created Date")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
        }
        addafter("Asset Created Date")
        {
            field("Asset tagging"; Rec."Asset tagging")
            {
                ApplicationArea = All;
            }
            field("Asset DateFormat"; Rec."Asset DateFormat")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }
}
