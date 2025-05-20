page 51979 "Promotion History Lines"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = "Promotion History";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = All;
                }
                field("Postion Description"; Rec."Postion Description")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field(LengthOfService; LengthOfService)
                {
                    ApplicationArea = All;
                    Caption = 'Position Length Of Service';
                    Editable = false;
                }
                field("HR Remarks"; Rec."HR Remarks")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        LengthOfService:='';
        if(Rec."End Date" <> 0D)then begin
            if(Rec."Start Date" <> 0D)then LengthOfService:=Dates.DetermineAge(Rec."Start Date", Rec."End Date");
        end
        else
        begin
            if(Rec."Start Date" <> 0D)then LengthOfService:=Dates.DetermineAge(Rec."Start Date", Today);
        end;
    end;
    trigger OnOpenPage()
    begin
        LengthOfService:='';
        if(Rec."End Date" <> 0D)then begin
            if(Rec."Start Date" <> 0D)then LengthOfService:=Dates.DetermineAge(Rec."Start Date", Rec."End Date");
        end
        else
        begin
            if(Rec."Start Date" <> 0D)then LengthOfService:=Dates.DetermineAge(Rec."Start Date", Today);
        end;
    end;
    var Dates: Codeunit "HR Dates";
    LengthOfService: Text[100];
}
