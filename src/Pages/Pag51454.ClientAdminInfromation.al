page 51454 "Client Admin Infromation"
{
    // version THL- Client Payroll 1.0
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Client Employee Master";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }
                field("Passport No."; Rec."Passport No.")
                {
                    ApplicationArea = All;
                }
                field("Driving License No"; Rec."Driving License No")
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }
                field(Disability; Rec.Disability)
                {
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                }
                field("Ethnic Group"; Rec."Ethnic Group")
                {
                    ApplicationArea = All;
                }
            }
            group("Admin Information")
            {
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Employee Group"; Rec."Employee Group")
                {
                    ApplicationArea = All;
                }
                field("Manager No."; Rec."Manager No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Code"; Rec."Customer Code")
                {
                    ApplicationArea = All;
                }
                field(Scale; Rec.Scale)
                {
                    ApplicationArea = All;
                }
                field(Level; Rec.Level)
                {
                    ApplicationArea = All;
                }
                field("Hourly Rate"; Rec."Hourly Rate")
                {
                    ApplicationArea = All;
                }
                field("Daily Rate"; Rec."Daily Rate")
                {
                    ApplicationArea = All;
                }
                field("Full / Part Time"; Rec."Full / Part Time")
                {
                    ApplicationArea = All;
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Departure Date"; Rec."Departure Date")
                {
                    ApplicationArea = All;
                }
            }
            part(Control32; "Employee Document Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Document No."=FIELD("No."), "Table ID"=CONST(51453);
            }
        }
        area(factboxes)
        {
            systempart(Control19; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;
    trigger OnOpenPage()
    begin
        CreateIncomingDocumentVisible:=true;
    end;
    var HasIncomingDocument: Boolean;
    CreateIncomingDocumentEnabled: Boolean;
    CreateIncomingDocumentVisible: Boolean;
    CreateIncomingDocFromEmailAttachment: Boolean;
    IncomingDocEmailAttachmentEnabled: Boolean;
    IsOfficeAddin: Boolean;
    OfficeMgt: Codeunit "Office Management";
    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt. Ext";
    begin
        HasIncomingDocument:=Rec."Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled:=(not HasIncomingDocument) and (Rec."No." <> '');
    end;
}
