page 51932 "Mail Detail"
{
    DeleteAllowed = false;
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Mail Details";
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Request Approval,Workflow,Attachments';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit then CurrPage.Update;
                    end;
                }
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Mail Type"; Rec."Mail Type")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Raised by"; Rec."Raised by")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    Visible = Rec.Status = Rec.Status::Fulfilled;
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    Visible = Rec.Status = Rec.Status::Fulfilled;
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    Visible = Rec.Status = Rec.Status::Fulfilled;
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Incoming Mail/Outgoing Mail")
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Time; Rec.Time)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Sender's Detail"; Rec."Sender's Detail")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Sender's Department"; Rec."Sender's Department")
                {
                    ApplicationArea = All;
                    //Outgoing Mail
                    Visible = Outgoing;
                }
                field(Receiver; Rec.Receiver)
                {
                    ApplicationArea = All;
                    //Incoming Mail
                    Visible = Incoming;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field("Personal/Official"; Rec."Personal/Official")
                {
                    ApplicationArea = All;
                    //Incoming Mail
                    Visible = Incoming;
                }
                field("Send To"; Rec."Send To")
                {
                    ApplicationArea = All;
                    //Incoming Mail
                    Visible = Incoming;
                }
                field("Send To No."; Rec."Send To No.")
                {
                    ApplicationArea = All;
                    //Incoming Mail
                    Visible = Incoming;
                }
                field("Send To Name"; Rec."Send To Name")
                {
                    ApplicationArea = All;
                    //Incoming Mail
                    Visible = Incoming;
                }
                field("Destination Contact"; Rec."Destination Contact")
                {
                    ApplicationArea = All;
                    //Outgoing Mail
                    Visible = Outgoing;
                }
                field(Carrier; Rec.Carrier)
                {
                    ApplicationArea = All;
                    //Outgoing Mail
                    Visible = Outgoing;
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

                trigger OnAction()
                begin
                    if Confirm('Do you wish to submit this mail details?', false) = true THEN BEGIN
                        //Validate
                        /*if "Mail Type" = "Mail Type"::" " then
                            Error('Mail type can not be emptied, please select among the list.');*/
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
    trigger OnInit()
    begin
        Incoming:=false;
        Outgoing:=false;
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Status:=Rec.Status::Open;
    end;
    trigger OnOpenPage()
    begin
        if Rec."Mail Type" = Rec."Mail Type"::"Incoming Mail" then Incoming:=true
        else
            Incoming:=false;
        if Rec."Mail Type" = Rec."Mail Type"::"Outgoing Mail" then Outgoing:=true
        else
            Outgoing:=false;
    end;
    trigger OnAfterGetRecord()
    begin
        if Rec."Mail Type" = Rec."Mail Type"::"Incoming Mail" then Incoming:=true
        else
            Incoming:=false;
        if Rec."Mail Type" = Rec."Mail Type"::"Outgoing Mail" then Outgoing:=true
        else
            Outgoing:=false;
    end;
    var Outgoing: Boolean;
    Incoming: Boolean;
    Attach: Record Document;
}
