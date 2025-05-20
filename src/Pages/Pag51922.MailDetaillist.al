page 51922 "Mail Detail list"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    CardPageID = "Mail Detail";
    SourceTable = "Mail Details";
    Editable = false;
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Request Approval,Workflow,Attachments';

    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Sender's Detail"; Rec."Sender's Detail")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field("Mail Type"; Rec."Mail Type")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(Control2; "Mail Detail Document Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Document No."=FIELD("No."), "Table ID"=CONST(51947);
            }
            systempart(Control13; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Attach Documents")
            {
                ApplicationArea = All;
                Image = Attach;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = New;
                RunObject = Page "Mail Detail Documents";
                RunPageLink = "Document No."=FIELD("No."), "Table ID"=CONST(51947);
            }
            action(Submit)
            {
                Visible = Rec.Status = Rec.Status::Open;
                ApplicationArea = All;
                Image = Start;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Do you wish to submit this mail details?', false) = true THEN BEGIN
                        //Validate
                        if Rec."Mail Type" = Rec."Mail Type"::"Incoming Mail" then begin
                            Rec.TestField(Date);
                            Rec.TestField(Time);
                            Rec.TestField("Sender's Detail");
                            Rec.TestField(Receiver);
                            Rec.TestField("Item Description");
                            Rec.TestField("Personal/Official");
                            Rec.TestField("Send To Name");
                        end
                        else if Rec."Mail Type" = Rec."Mail Type"::"Outgoing Mail" then begin
                                Rec.TestField(Date);
                                Rec.TestField(Time);
                                Rec.TestField("Sender's Detail");
                                Rec.TestField("Sender's Department");
                                Rec.TestField("Item Description");
                                Rec.TestField("Destination Contact");
                                Rec.TestField(Carrier);
                            end;
                        //Check attach document
                        Attach.Reset();
                        Attach.SetRange("Document No.", Rec."No.");
                        Attach.SetFilter("Attachment No.", '<>0');
                        if Attach.FindFirst()then begin
                            Rec.Status:=Rec.Status::Fulfilled;
                            Rec."Posted Date":=Today;
                            Rec.Posted:=true;
                            Rec."Posted By":=UserId;
                            Rec.Modify(true);
                        end
                        else if(Attach.Description = '') and (Attach."Attachment No." = 0)then Error('You have not attach your mail document''s');
                    end;
                end;
            }
        }
    }
    var Attach: Record Document;
}
