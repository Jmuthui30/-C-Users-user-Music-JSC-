page 50031 "Financial Year Codes"
{
    ApplicationArea = All;
    Caption = 'Financial Year Codes';
    PageType = List;
    SourceTable = "Financial Year Code";
    UsageCategory = Lists;
    CardPageId = "Financial Year Code";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Dtae"; Rec."End Dtae")
                {
                    ToolTip = 'Specifies the value of the End Dtae field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
            }
        }
    }
}
