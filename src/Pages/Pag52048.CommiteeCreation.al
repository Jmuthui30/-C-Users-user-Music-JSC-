page 52048 "Commitee Creation"
{
    SourceTable = "Tender Commitee Appointment";
    PageType = Card;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Appointment No"; Rec."Appointment No")
                {
                    ApplicationArea = All;
                }
                field("Tender/Quotation No"; Rec."Tender/Quotation No")
                {
                    ApplicationArea = All;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                }
                field("Committee ID"; Rec."Committee ID")
                {
                    ApplicationArea = All;
                }
                field("Committee Name"; Rec."Committee Name")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Deadline For Report Submission"; Rec."Deadline For Report Submission")
                {
                    ApplicationArea = All;
                }
            }
            part(Control1; "Commitee Members")
            {
                ApplicationArea = All;
                SubPageLink = "Appointment No"=FIELD("Appointment No");
                SubPageView = SORTING("Appointment No", "Employee No");
            }
        }
    }
    actions
    {
        area(creation)
        {
            action(Approve)
            {
                ApplicationArea = All;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField("Committee ID");
                    Rec.TestField("Tender/Quotation No");
                    CommiteeMembers.Reset;
                    CommiteeMembers.SetRange("Appointment No", Rec."Appointment No");
                    if not CommiteeMembers.FindSet then Error('You have not allocated Tendering Committee Members to %1', Rec."Tender/Quotation No")
                    else if CommiteeMembers.FindSet then repeat CommiteeMembers.TestField("Employee No");
                            until CommiteeMembers.Next = 0;
                end;
            }
        }
    }
    var CommiteeMembers: Record "Commitee Members";
}
