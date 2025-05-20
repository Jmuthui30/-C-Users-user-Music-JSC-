page 51424 "Admin Infromation"
{
    // version THL- Payroll 1.0
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Employee Master";

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
            group("Job Information")
            {
                Caption = 'Job Information';

                field(Position; Rec.Position)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Lookup = false;

                    trigger OnAssistEdit()
                    begin
                        PromotionHistory.GetEmployee(Rec);
                        PromotionHistory.RunModal;
                        Clear(PromotionHistory);
                    end;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field("Employee Group"; Rec."Employee Group")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if EmployeeGroups.Get(Rec."Employee Group")then begin
                            if((EmployeeGroups.Permanent = true) or (EmployeeGroups.Secondment = true))then begin
                                Visible:=false;
                                Rec."Contract Type":='';
                                Rec."Contract Start Date":=0D;
                                Rec."Contract End Date":=0D;
                            end
                            else
                                Visible:=true;
                        end;
                    end;
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
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field("Manager No."; Rec."Manager No.")
                {
                    ApplicationArea = All;
                }
                field("Travels Customer Account"; Rec."Travels Customer Account")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Advancess Customer Account"; Rec."Advancess Customer Account")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                group("Bal Score Card Details")
                {
                    field(Appraisable; Rec.Appraisable)
                    {
                        ApplicationArea = All;
                    }
                    field(Sales; Rec.Sales)
                    {
                        ApplicationArea = All;
                    }
                    field("Bal Score Emp Categories"; Rec."Bal Score Emp Categories")
                    {
                        ApplicationArea = All;
                    }
                    field("Appraisal Supervisor"; Rec."Appraisal Supervisor")
                    {
                        ApplicationArea = All;
                    }
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
                    Editable = Visible;
                }
                field("Contract Start Date"; Rec."Contract Start Date")
                {
                    ApplicationArea = All;
                    Editable = Visible;
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    ApplicationArea = All;
                    Editable = Visible;
                }
            }
            part(Control32; "Employee Document Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Document No."=FIELD("No."), "Table ID"=CONST(51423);
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
        if EmployeeGroups.Get(Rec."Employee Group")then begin
            if((EmployeeGroups.Permanent = true) or (EmployeeGroups.Secondment = true))then Visible:=false
            else
                Visible:=true;
        end;
    end;
    trigger OnOpenPage()
    begin
        CreateIncomingDocumentVisible:=true;
        if EmployeeGroups.Get(Rec."Employee Group")then begin
            if((EmployeeGroups.Permanent = true) or (EmployeeGroups.Secondment = true))then Visible:=false
            else
                Visible:=true;
        end;
    end;
    var HasIncomingDocument: Boolean;
    CreateIncomingDocumentEnabled: Boolean;
    CreateIncomingDocumentVisible: Boolean;
    CreateIncomingDocFromEmailAttachment: Boolean;
    IncomingDocEmailAttachmentEnabled: Boolean;
    IsOfficeAddin: Boolean;
    OfficeMgt: Codeunit "Office Management";
    PromotionHistory: Report "Promotion History";
    CompanyJobs: Record "Company Jobs";
    Visible: Boolean;
    EmployeeGroups: Record "Employee Groups";
    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt. Ext";
    begin
        HasIncomingDocument:=Rec."Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled:=(not HasIncomingDocument) and (Rec."No." <> '');
    end;
}
