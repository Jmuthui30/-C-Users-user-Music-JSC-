page 52023 "Bidders"
{
    SourceTable = Bidders;

    layout
    {
        area(content)
        {
            repeater(Control16)
            {
                ShowCaption = false;

                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("E-mail"; Rec."E-mail")
                {
                    ApplicationArea = All;
                }
                field("Tender Amount"; Rec."Tender Amount")
                {
                    ApplicationArea = All;
                }
                field("Bid Security Amount"; Rec."Bid Security Amount")
                {
                    ApplicationArea = All;
                }
                field("No. of Copies Submitted"; Rec."No. of Copies Submitted")
                {
                    ApplicationArea = All;
                }
                field("Physical Address"; Rec."Physical Address")
                {
                    ApplicationArea = All;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Telephone No"; Rec."Telephone No")
                {
                    ApplicationArea = All;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = All;
                }
                field("Contact Person"; Rec."Contact Person")
                {
                    ApplicationArea = All;
                }
                field("Pre Qualified"; Rec."Pre Qualified")
                {
                    ApplicationArea = All;
                }
                field(Successful; Rec.Successful)
                {
                    ApplicationArea = All;
                }
                field("Fixed Asset No"; Rec."Fixed Asset No")
                {
                    ApplicationArea = All;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group(Bidders)
            {
                Caption = 'Bidders';

                action("Mandatory Requirements -Compliance")
                {
                    ApplicationArea = All;
                    Caption = 'Mandatory Requirements -Compliance';
                    Image = ReminderTerms;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Bidder Mandatory Requirements";
                    RunPageLink = "Tender No"=FIELD("Ref No."), "Company Name"=FIELD(Name);

                    trigger OnAction()
                    begin
                        MandatoryReq.Reset;
                        MandatoryReq.SetRange(MandatoryReq."Tender No", Rec."Ref No.");
                        if MandatoryReq.Find('-')then repeat BidderMandatory."Tender No":=Rec."Ref No.";
                                BidderMandatory."Company Name":=Rec.Name;
                                BidderMandatory."Mandatory Requirement":=MandatoryReq."Mandatory Requirement";
                                if not BidderMandatory.Get(BidderMandatory."Tender No", BidderMandatory."Company Name", BidderMandatory."Mandatory Requirement")then BidderMandatory.Insert;
                            until MandatoryReq.Next = 0;
                    end;
                }
            }
        }
    }
    var MandatoryReq: Record "Tender Mandatory Requirements";
    BidderMandatory: Record "Bidder Mandatory Requirements";
}
