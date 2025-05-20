page 52427 "Sub Counties List"
{
    PageType = List;
    SourceTable = "Sub Counties";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(CountyCode; Rec."County Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field(SubCountyCode; Rec."Sub County Code")
                {
                    ApplicationArea = Basic;
                }
                field(SubCountyName; Rec."Sub County Name")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
    actions
    {
    }
}
