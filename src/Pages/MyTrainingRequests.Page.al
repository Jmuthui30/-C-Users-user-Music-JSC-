page 52977 "My Training Requests"
{
    ApplicationArea = All;
    Caption = 'My Training Requests';
    CardPageID = "Training Request Card";
    PageType = List;
    SourceTable = "Training Request";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request No."; Rec."Request No.")
                {
                    ToolTip = 'Specifies the training request number.';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ToolTip = 'Specifies the request date.';
                }
                field("Training Need"; Rec."Training Need")
                {
                    ToolTip = 'Specifies the training need being applied for.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the training description.';
                }
                field("Planned Start Date"; Rec."Planned Start Date")
                {
                    ToolTip = 'Specifies the planned start date.';
                }
                field("Planned End Date"; Rec."Planned End Date")
                {
                    ToolTip = 'Specifies the planned end date.';
                }
                field(Destination; Rec.Destination)
                {
                    ToolTip = 'Specifies the destination.';
                }
                field("Cost of Training"; Rec."Cost of Training")
                {
                    ToolTip = 'Specifies the training cost.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the request status.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetRange("User ID", UserId);
        Rec.FilterGroup(0);
    end;
}
