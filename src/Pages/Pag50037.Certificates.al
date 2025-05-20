page 50037 Certificates
{
    ApplicationArea = All;
    Caption = 'Certificates';
    PageType = ListPart;
    SourceTable = Certificate;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Certificate Type"; Rec."Certificate Type")
                {
                    ToolTip = 'Specifies the value of the Certificate Type field.';
                }
                field("Category Code"; Rec."Category Code")
                {
                    ToolTip = 'Specifies the value of the Product Category Code field.';
                    ApplicationArea = All;
                }
                field("Category Name"; Rec."Category Name")
                {
                    ApplicationArea = All;
                }
                /*field("Product Code"; Rec."Product Code")
                {
                    ApplicationArea = All;
                }
                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = All;
                }*/
                field("Registration No."; Rec."Registration No.")
                {
                    ApplicationArea = All;
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ApplicationArea = All;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                }
                field("Certificate Attachment"; Rec."Certificate Attachment")
                {
                    Enabled = false;
                }
            }
        }
    }
}
