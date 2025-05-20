page 51926 "Attendance Entries List"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = History;
    SourceTable = "Payroll Attendance Entries";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Posting Type"; Rec."Posting Type")
                {
                    ApplicationArea = All;
                }
                field("Working Date"; Rec."Working Date")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("P/No."; Rec."P/No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field(Holiday; Rec.Holiday)
                {
                    ApplicationArea = All;
                }
                field("Normal Day"; Rec."Normal Day")
                {
                    ApplicationArea = All;
                }
                field(Absent; Rec.Absent)
                {
                    ApplicationArea = All;
                }
                field(Relief; Rec.Relief)
                {
                    ApplicationArea = All;
                }
                field(Sunday; Rec.Sunday)
                {
                    ApplicationArea = All;
                }
                field(Leave; Rec.Leave)
                {
                    ApplicationArea = All;
                }
                field("Normal Overtime"; Rec."Normal Overtime")
                {
                    ApplicationArea = All;
                }
                field("Special Overtime"; Rec."Special Overtime")
                {
                    ApplicationArea = All;
                }
                field(Late; Rec.Late)
                {
                    ApplicationArea = All;
                }
                field(Hours; Rec.Hours)
                {
                    ApplicationArea = All;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control20; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control21; MyNotes)
            {
            }
            systempart(Control22; Links)
            {
            }
        }
    }
    actions
    {
        area(creation)
        {
        }
    }
    trigger OnOpenPage()
    begin
        //SETRANGE("Posted By", USERID);
        //SETFILTER("Posted By",'%1'|'%2' USERID, 'SYSTEM');
        Admins.Reset;
        Admins.SetRange("User ID", UserId);
        if Admins.FindFirst then Division:=Admins."Shortcut Dimension 1 Code";
        Rec.SetRange("Shortcut Dimension 1 Code", Division);
    end;
    var Admins: Record Admins;
    Division: Code[20];
}
