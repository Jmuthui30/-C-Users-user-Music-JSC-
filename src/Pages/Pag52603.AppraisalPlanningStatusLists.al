page 52603 "Draft Appraisal Planning"
{
    ApplicationArea = All;
    CardPageId = "Appraisal Planning Card";
    Caption = 'Draft Appraisal Planning';
    PageType = List;
    SourceTable = "Appraisal Planning Header";
    SourceTableView = where("Planning Status" = const(Draft));

    layout { area(content) { repeater(Group) { field("No."; Rec."No.") { ApplicationArea = All; } field("Employee No."; Rec."Employee No.") { ApplicationArea = All; } field("Employee Name"; Rec."Employee Name") { ApplicationArea = All; } field("Appraisal Period"; Rec."Appraisal Period") { ApplicationArea = All; } field("Appraiser Name"; Rec."Appraiser Name") { ApplicationArea = All; } } } }
}

page 52604 "Appr Planning Pending App."
{
    ApplicationArea = All;
    CardPageId = "Appraisal Planning Card";
    Caption = 'Appraisal Planning Pending Appraiser Review';
    PageType = List;
    SourceTable = "Appraisal Planning Header";
    SourceTableView = where("Planning Status" = const("Pending Appraiser Review"));

    layout { area(content) { repeater(Group) { field("No."; Rec."No.") { ApplicationArea = All; } field("Employee No."; Rec."Employee No.") { ApplicationArea = All; } field("Employee Name"; Rec."Employee Name") { ApplicationArea = All; } field("Appraisal Period"; Rec."Appraisal Period") { ApplicationArea = All; } field("Appraiser Name"; Rec."Appraiser Name") { ApplicationArea = All; } field("Submitted At"; Rec."Submitted At") { ApplicationArea = All; } } } }
}

page 52605 "Returned Appraisal Planning"
{
    ApplicationArea = All;
    CardPageId = "Appraisal Planning Card";
    Caption = 'Returned Appraisal Planning';
    PageType = List;
    SourceTable = "Appraisal Planning Header";
    SourceTableView = where("Planning Status" = const("Returned for Changes"));

    layout { area(content) { repeater(Group) { field("No."; Rec."No.") { ApplicationArea = All; } field("Employee No."; Rec."Employee No.") { ApplicationArea = All; } field("Employee Name"; Rec."Employee Name") { ApplicationArea = All; } field("Appraisal Period"; Rec."Appraisal Period") { ApplicationArea = All; } field("Last Review Reason"; Rec."Last Review Reason") { ApplicationArea = All; } } } }
}

page 52606 "Appraisal Planning Pending HR"
{
    ApplicationArea = All;
    CardPageId = "Appraisal Planning Card";
    Caption = 'Appraisal Planning Pending HR Approval';
    PageType = List;
    SourceTable = "Appraisal Planning Header";
    SourceTableView = where("Planning Status" = const("Pending HR Approval"));

    layout { area(content) { repeater(Group) { field("No."; Rec."No.") { ApplicationArea = All; } field("Employee No."; Rec."Employee No.") { ApplicationArea = All; } field("Employee Name"; Rec."Employee Name") { ApplicationArea = All; } field("Appraisal Period"; Rec."Appraisal Period") { ApplicationArea = All; } field("Appraiser Name"; Rec."Appraiser Name") { ApplicationArea = All; } field("Objectives Agreed At"; Rec."Objectives Agreed At") { ApplicationArea = All; } } } }
}

page 52607 "Created Appraisal Planning"
{
    ApplicationArea = All;
    CardPageId = "Appraisal Planning Card";
    Caption = 'Appraisal Planning With Appraisal Created';
    PageType = List;
    SourceTable = "Appraisal Planning Header";
    SourceTableView = where("Planning Status" = const("Appraisal Created"));

    layout { area(content) { repeater(Group) { field("No."; Rec."No.") { ApplicationArea = All; } field("Employee No."; Rec."Employee No.") { ApplicationArea = All; } field("Employee Name"; Rec."Employee Name") { ApplicationArea = All; } field("Appraisal Period"; Rec."Appraisal Period") { ApplicationArea = All; } field("Actual Appraisal No."; Rec."Actual Appraisal No.") { ApplicationArea = All; } field("Appraisal Created At"; Rec."Appraisal Created At") { ApplicationArea = All; } } } }
}
