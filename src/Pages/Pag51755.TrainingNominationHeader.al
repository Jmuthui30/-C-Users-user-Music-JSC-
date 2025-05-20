page 51755 "Training Nomination Header"
{
    // version THL- HRM 1.0
    PageType = Card;
    SourceTable = "Training Nomination Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Training Title"; Rec."Training Title")
                {
                    ApplicationArea = All;
                }
                field("Training Venue"; Rec."Training Venue")
                {
                    ApplicationArea = All;
                }
                field(Organizers; Rec.Organizers)
                {
                    ApplicationArea = All;
                }
                part(Control11; "Course Training Needs")
                {
                    ApplicationArea = All;
                    SubPageLink = "No."=FIELD("No.");
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
            }
            part(Control12; "Training Nominees")
            {
                ApplicationArea = All;
                SubPageLink = "No."=FIELD("No.");
            }
        }
        area(factboxes)
        {
            systempart(Control10; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Notify Nominees")
            {
                ApplicationArea = All;
                Image = Alerts;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Smail: Codeunit Email;
                    EmailAccount: Record "Email Account";
                    EmailMessage: Codeunit "Email Message";
                    MailMgt: Codeunit "Mail Management";
                    ConfirmMsg: Label 'Would you wish to continue Notifying Nominees Through Email';
                    Recipients: List of[Text];
                    SendeList: List of[Text];
                    SenderAddrr: Text;
                    BodyMessage: Text;
                begin
                    Nominees.Reset;
                    Nominees.SetRange("No.", Rec."No.");
                    if Nominees.FindSet then begin
                        if Confirm(ConfirmMsg, true)then begin
                            Nominees.Reset;
                            Nominees.SetRange("No.", Rec."No.");
                            if Nominees.FindSet then repeat Recipients.Add(Nominees."Email Address");
                                    EmailMessage.Create(Recipients, 'NOMINATION FOR TRAINING' + ' ' + Rec."Training Title", '', true);
                                    EmailMessage.AppendToBody('Dear ' + Nominees."Staff Name" + ', you have been nominated to take part in the above mentioned training on ' + Format(Rec.Date) + ' at ' + Rec."Training Venue" + '.');
                                    // Mail.NewIncidentMail(Nominees."Email Address", ' Nomination for Training -' + Rec."Training Title", 'Dear ' + Nominees."Staff Name"
                                    // + ', you have been nominated to take part in the above mentioned training on ' + Format(Rec.Date) + ' at ' + Rec."Training Venue" + '.');
                                    Smail.Send(EmailMessage, Enum::"Email Scenario"::Default)until Nominees.Next = 0;
                            Message('An Email Notification have been sent to all Nominees')end
                        else
                            exit;
                    end
                    else
                        Error('No Nominee have been Selected');
                end;
            }
        }
    }
    var Mail: Codeunit "QuantumJumps Mail";
    Nominees: Record "Training Nominees";
}
