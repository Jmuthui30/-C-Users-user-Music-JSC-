page 51969 "Leave Applications & Approval"
{
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Employee Leave Plan";
    SourceTableView = WHERE(Status=CONST(Released));
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Request Approval,Workflow,Attachments';

    layout
    {
        area(content)
        {
            repeater(Control7)
            {
                ShowCaption = false;

                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field(Names; Names)
                {
                    ApplicationArea = All;
                    Caption = 'Names';
                    Editable = false;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(Control2; "Leave Apps Document Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Document No."=FIELD("Application No"), "Table ID"=CONST(51602);
            }
            systempart(Control15; Notes)
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
                PromotedCategory = Category8;
                PromotedOnly = true;
                RunObject = Page "Leave Apps Documents";
                RunPageLink = "Document No."=FIELD("Application No"), "Table ID"=CONST(51602);
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Employee.Reset;
        if Employee.Get(Rec."Employee No")then Names:=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
    end;
    var Names: Text[250];
    Employee: Record Employee;
}
