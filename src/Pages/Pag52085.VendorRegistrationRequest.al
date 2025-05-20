page 52085 "Vendor Registration Request"
{
    Caption = 'Vendor Registration API', Locked = true;
    PageType = API;
    APIGroup = 'BC';
    APIPublisher = 'teknohub';
    EntityName = 'vendorRegistration';
    EntitySetName = 'vendorRegistrations';
    SourceTable = "Vendor Reg. Request";
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    Extensible = false;
    ChangeTrackingAllowed = true;
    ObsoleteState = Pending;
    ObsoleteReason = 'API version beta will be deprecated.';
    ObsoleteTag = '18.0';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(id; Rec.SystemId)
                {
                    ApplicationArea = All;
                    Caption = 'Id', Locked = true;
                    Editable = false;
                }
                field(no; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No';
                }
                field(companyName; Rec."Company Name")
                {
                    ApplicationArea = All;
                    Caption = 'Company Name';
                }
                field(vatRegNo; Rec."VAT Reg No")
                {
                    ApplicationArea = All;
                    Caption = 'VAT Registration No';
                }
                field(taxIdNumber; Rec."Tax Id Number")
                {
                    ApplicationArea = All;
                    Caption = 'Tax Id Number';
                }
                field(companyDateRegDate; Rec."Company Date Reg Date")
                {
                    ApplicationArea = All;
                    Caption = 'Company Date Reg Date';
                }
                field(certOfIncorporationNo; Rec."Cert. Of Incorporation No")
                {
                    ApplicationArea = All;
                    Caption = 'Certificate Of Incorporation No';
                }
                field(regOfficeAddress; Rec."Reg. Office Address")
                {
                    ApplicationArea = All;
                    Caption = 'Registration Office Address';
                }
                field(state; Rec.State)
                {
                    ApplicationArea = All;
                    Caption = 'State';
                }
                field(emailAddress; Rec."Email Address")
                {
                    ApplicationArea = All;
                    Caption = 'Email Address';
                }
                field(phoneNumber; Rec."Phone Number")
                {
                    ApplicationArea = All;
                    Caption = 'Phone Number';
                }
                field(memArticlesOfAssocLink; Rec."Mem Articles Of Assoc Link")
                {
                    ApplicationArea = All;
                    Caption = 'Memorandum Articles Of Association Link';
                }
                field(certOfIncorporationLink; Rec."Cert Of Incorporation Link")
                {
                    ApplicationArea = All;
                    Caption = 'Certificate Of Incorporation Link';
                }
                field(cO7PartOfDirectorsLink; Rec."CO7 Part. Of Directors Link")
                {
                    ApplicationArea = All;
                    Caption = 'CO7 Part. Of Directors Link';
                }
                field(vatRegistrationCertLink; Rec."VAT Registration Cert Link")
                {
                    ApplicationArea = All;
                    Caption = 'VAT Registration Cert Link';
                }
                field(taxClearanceCertLink; Rec."Tax Clearance Cert Link")
                {
                    ApplicationArea = All;
                    Caption = 'Tax Clearance Cert Link';
                }
            }
        }
    }
}
