page 51996 "Vacant Positions"
{
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Company Jobs";
    //  SourceTableView = where(Status = const(Released));
    layout
    {
        area(content)
        {
            repeater(Control5)
            {
                ShowCaption = false;

                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("No of Posts"; Rec."No of Posts")
                {
                    ApplicationArea = All;
                }
                field("Occupied Position"; Rec."Occupied Position")
                {
                    ApplicationArea = All;
                    Caption = 'Occupied Positions';
                }
                field("Vacant Posistions"; Rec."Vacant Posistions")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        Rec.Reset;
        if Rec.Find('-') then begin
            repeat
                Rec.CalcFields("Occupied Position");
                // MESSAGE('%1',"Occupied Position");
                Rec."Vacant Posistions" := Rec."No of Posts" - Rec."Occupied Position";
                Rec.Modify;
            until Rec.Next = 0;
        end;
        Rec.Reset;
        Rec.SetCurrentKey(Rec."Vacant Posistions");
        Rec.SetFilter(Rec."Vacant Posistions", '>%1', 0);
    end;
}
