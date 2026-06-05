page 52976 "Consolidated Training Plan"
{
    ApplicationArea = All;
    Caption = 'Consolidated Training Plan';
    CardPageID = "Training Need";
    PageType = List;
    SourceTable = "Training Need";
    SourceTableView = sorting("Start Date") where(Status = filter(Open | Application));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the training need number.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the planned training description.';
                }
                field("Need Source"; Rec."Need Source")
                {
                    ToolTip = 'Specifies the source of the training need.';
                }
                field("Source Assessment No."; Rec."Source Assessment No.")
                {
                    ToolTip = 'Specifies the approved assessment that created the training need.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the planned start date.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the planned end date.';
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the planned training location.';
                }
                field(Provider; Rec.Provider)
                {
                    ToolTip = 'Specifies the training provider.';
                }
                field("Provider Name"; Rec."Provider Name")
                {
                    ToolTip = 'Specifies the training provider name.';
                }
                field("Cost Of Training"; Rec."Cost Of Training")
                {
                    ToolTip = 'Specifies the budgeted cost of training.';
                }
                field("Cost Of Training (LCY)"; Rec."Cost Of Training (LCY)")
                {
                    ToolTip = 'Specifies the budgeted cost of training in LCY.';
                }
                field("No. of Participants"; Rec."No. of Participants")
                {
                    ToolTip = 'Specifies the number of approved participants.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the training plan status.';
                }
            }
        }
    }
}
