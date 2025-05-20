page 52020 "Tender List"
{
    CardPageID = Tender;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Procurement Request";

    layout
    {
        area(content)
        {
            repeater(Control7)
            {
                ShowCaption = false;

                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                }
                field("Requisition No"; Rec."Requisition No")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field(Procurementtype; Rec.Procurementtype)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
